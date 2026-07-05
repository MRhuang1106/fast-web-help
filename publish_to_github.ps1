param(
  [string]$RepoName = "fast-web-help",
  [string]$Description = "24-hour small website and GitHub Pages help",
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

if (Test-Path ".\preflight_check.ps1") {
  powershell -NoProfile -ExecutionPolicy Bypass -File ".\preflight_check.ps1"
  if ($LASTEXITCODE -ne 0) {
    throw "Preflight failed. Fix the reported issue before publishing."
  }
}

$repo = "MRhuang1106/$RepoName"
$site = "https://MRhuang1106.github.io/$RepoName/"

function Invoke-Native {
  param(
    [string]$FailureMessage,
    [scriptblock]$Command
  )

  & $Command
  if ($LASTEXITCODE -ne 0) {
    throw $FailureMessage
  }
}

function Test-NativeSuccess {
  param([scriptblock]$Command)

  $previousPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  try {
    & $Command *> $null
    return $LASTEXITCODE -eq 0
  } finally {
    $ErrorActionPreference = $previousPreference
  }
}

if ($DryRun) {
  Write-Host "Dry run only. No remote changes will be made."
  Write-Host "Would create or reuse repo: $repo"
  Write-Host "Would push branch: main"
  Write-Host "Would enable GitHub Pages from: main /"
  Write-Host "Would create/update label: client-request"
  Write-Host "Expected site: $site"
  exit 0
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  throw "GitHub CLI is not installed or not on PATH."
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "Git is not installed or not on PATH."
}

if (-not (Test-Path ".git")) {
  git init
  git branch -M main
}

$changes = git status --porcelain
if ($changes) {
  Invoke-Native "Could not stage changes." { git add . }
  Invoke-Native "Could not commit changes." { git commit -m "Launch fast web help page" }
}

$repoExists = $false
if (Test-NativeSuccess { gh repo view $repo }) {
  $repoExists = $true
}

if (-not $repoExists) {
  Invoke-Native "Could not create GitHub repo $repo." { gh repo create $repo --public --description $Description }
}

if (-not (Test-NativeSuccess { git remote get-url origin })) {
  git remote add origin "https://github.com/$repo.git"
}

Invoke-Native "Could not push main to origin." { git push -u origin main }

if (-not (Test-NativeSuccess { gh api "repos/$repo/pages" })) {
  Invoke-Native "Could not enable GitHub Pages for $repo." { gh api -X POST "repos/$repo/pages" -f source.branch=main -f source.path="/" }
}

Invoke-Native "Could not create or update client-request label." { gh label create "client-request" --repo $repo --color "0f766e" --description "Potential paid project request" --force }

Write-Host "Published. GitHub Pages usually appears after 1-3 minutes:"
Write-Host $site
Write-Host "Run live verification after a short wait:"
Write-Host ".\verify_live_site.ps1 -RepoName $RepoName"
