param(
  [string]$RepoName = "fast-web-help"
)

$ErrorActionPreference = "Stop"

function Assert-True {
  param(
    [bool]$Condition,
    [string]$Message
  )

  if (-not $Condition) {
    throw $Message
  }
}

$repo = "MRhuang1106/$RepoName"
$site = "https://MRhuang1106.github.io/$RepoName/"

Write-Host "Checking GitHub repository..."
gh repo view $repo --json nameWithOwner,url,visibility | Out-Null
Assert-True ($LASTEXITCODE -eq 0) "Repository $repo is not available."

Write-Host "Checking GitHub Pages configuration..."
$pages = gh api "repos/$repo/pages" 2>&1
Assert-True ($LASTEXITCODE -eq 0) "GitHub Pages is not configured for $repo."

Write-Host "Checking live pages..."
$paths = @(
  "",
  "samples/cafe.html",
  "samples/readme-refresh.html"
)

foreach ($path in $paths) {
  $url = "$site$path"
  $ok = $false
  for ($i = 0; $i -lt 12; $i++) {
    try {
      $resp = Invoke-WebRequest -Uri $url -UseBasicParsing
      if ($resp.StatusCode -eq 200) {
        $ok = $true
        break
      }
    } catch {
      Start-Sleep -Seconds 10
    }
  }
  Assert-True $ok "Live page did not return 200: $url"
}

Write-Host "Checking issue template link..."
$requestUrl = "https://github.com/$repo/issues/new?template=project-request.yml"
$requestResp = Invoke-WebRequest -Uri $requestUrl -UseBasicParsing
Assert-True ($requestResp.StatusCode -eq 200) "Issue request URL did not return 200."

Write-Host "Live verification passed:"
Write-Host $site
