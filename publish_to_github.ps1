param(
  [string]$RepoName = "fast-web-help",
  [string]$Description = "24-hour small website and GitHub Pages help"
)

$ErrorActionPreference = "Stop"

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

git add .
git commit -m "Launch fast web help page"

gh repo create $RepoName --public --source . --remote origin --push --description $Description
gh api -X POST "repos/MRhuang1106/$RepoName/pages" -f source.branch=main -f source.path="/"
gh label create "client-request" --repo "MRhuang1106/$RepoName" --color "0f766e" --description "Potential paid project request" --force

Write-Host "Published. GitHub Pages usually appears after 1-3 minutes:"
Write-Host "https://MRhuang1106.github.io/$RepoName/"
