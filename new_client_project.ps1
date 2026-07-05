param(
  [Parameter(Mandatory = $true)]
  [string]$ClientSlug,

  [ValidateSet("starter-page", "readme-refresh")]
  [string]$Type = "starter-page"
)

$ErrorActionPreference = "Stop"

if ($ClientSlug -notmatch "^[a-z0-9-]+$") {
  throw "ClientSlug must use lowercase letters, numbers, and hyphens only."
}

$source = Join-Path "delivery" $Type
if (-not (Test-Path $source)) {
  throw "Unknown delivery template: $Type"
}

$targetRoot = Join-Path "client-work" $ClientSlug
if (Test-Path $targetRoot) {
  throw "Target already exists: $targetRoot"
}

New-Item -ItemType Directory -Force $targetRoot | Out-Null
Copy-Item -Path (Join-Path $source "*") -Destination $targetRoot -Recurse

Write-Host "Created client project:"
Write-Host $targetRoot
