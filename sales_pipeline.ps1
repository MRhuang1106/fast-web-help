param(
  [ValidateSet("list", "due", "add", "touch", "summary")]
  [string]$Action = "summary",

  [string]$Id,
  [string]$Source,
  [string]$LeadName,
  [string]$Url,
  [string]$Offer,
  [string]$Price = "$49",
  [string]$Status = "planned",
  [string]$Notes = "",
  [int]$FollowupDays = 2
)

$ErrorActionPreference = "Stop"
$path = "SALES_PIPELINE.csv"

if (-not (Test-Path $path)) {
  throw "Missing $path"
}

function Read-Pipeline {
  Import-Csv $path
}

function Write-Pipeline {
  param([object[]]$Rows)
  $Rows | Export-Csv -Path $path -NoTypeInformation
}

function Next-Id {
  param([object[]]$Rows)
  $ids = $Rows | ForEach-Object { [int]$_.id }
  if (-not $ids) { return 1 }
  return (($ids | Measure-Object -Maximum).Maximum + 1)
}

$rows = @(Read-Pipeline)
$today = (Get-Date).ToString("yyyy-MM-dd")

switch ($Action) {
  "summary" {
    $rows | Group-Object status | Sort-Object Name | Select-Object Name,Count | Format-Table -AutoSize
  }
  "list" {
    $rows | Sort-Object {[int]$_.id} | Format-Table id,status,source,lead_name,price,next_followup -AutoSize
  }
  "due" {
    $rows |
      Where-Object { $_.next_followup -and $_.next_followup -le $today -and $_.status -notin @("won", "lost", "rejected") } |
      Sort-Object next_followup |
      Format-Table id,status,source,lead_name,next_followup,notes -AutoSize
  }
  "add" {
    if (-not $Source -or -not $LeadName -or -not $Offer) {
      throw "For add, provide -Source, -LeadName, and -Offer."
    }

    $new = [pscustomobject]@{
      id = Next-Id $rows
      status = $Status
      source = $Source
      lead_name = $LeadName
      url = $Url
      offer = $Offer
      price = $Price
      last_touch = ""
      next_followup = ""
      notes = $Notes
    }
    Write-Pipeline ($rows + $new)
    Write-Host "Added lead #$($new.id): $LeadName"
  }
  "touch" {
    if (-not $Id) {
      throw "For touch, provide -Id."
    }

    $found = $false
    foreach ($row in $rows) {
      if ($row.id -eq $Id) {
        $row.status = $Status
        $row.last_touch = $today
        $row.next_followup = (Get-Date).AddDays($FollowupDays).ToString("yyyy-MM-dd")
        if ($Notes) { $row.notes = $Notes }
        $found = $true
      }
    }

    if (-not $found) {
      throw "No lead found with id $Id."
    }

    Write-Pipeline $rows
    Write-Host "Updated lead #$Id"
  }
}
