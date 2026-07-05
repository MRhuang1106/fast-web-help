param(
  [string]$RepoName = "fast-web-help",
  [string]$Description = "24-hour small website and GitHub Pages help"
)

$ErrorActionPreference = "Stop"

if (Test-Path ".\preflight_check.ps1") {
  powershell -NoProfile -ExecutionPolicy Bypass -File ".\preflight_check.ps1"
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

$repo = "MRhuang1106/$RepoName"
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
Write-Host "https://MRhuang1106.github.io/$RepoName/"
Write-Host "Run live verification after a short wait:"
Write-Host ".\verify_live_site.ps1 -RepoName $RepoName"
