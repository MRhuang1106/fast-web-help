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
  git add .
  git commit -m "Launch fast web help page"
}

$repoExists = $false
try {
  gh repo view $repo | Out-Null
  $repoExists = $true
} catch {
  $repoExists = $false
}

if (-not $repoExists) {
  gh repo create $RepoName --public --description $Description
}

try {
  git remote get-url origin | Out-Null
} catch {
  git remote add origin "https://github.com/$repo.git"
}

git push -u origin main

try {
  gh api "repos/$repo/pages" | Out-Null
} catch {
  gh api -X POST "repos/$repo/pages" -f source.branch=main -f source.path="/"
}

gh label create "client-request" --repo $repo --color "0f766e" --description "Potential paid project request" --force

Write-Host "Published. GitHub Pages usually appears after 1-3 minutes:"
Write-Host $site
Write-Host "Run live verification after a short wait:"
Write-Host ".\verify_live_site.ps1 -RepoName $RepoName"
