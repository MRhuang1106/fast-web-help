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

function Test-Content {
  param(
    [string]$Path,
    [string]$Pattern,
    [string]$Message
  )

  $text = Get-Content -Raw $Path
  Assert-True -Condition ($text -match $Pattern) -Message $Message
}

Write-Host "Running preflight checks..."

Assert-True -Condition (Test-Path "index.html") -Message "Missing index.html"
Assert-True -Condition (Test-Path "samples/cafe.html") -Message "Missing cafe sample"
Assert-True -Condition (Test-Path "samples/readme-refresh.html") -Message "Missing README refresh sample"
Assert-True -Condition (Test-Path ".github/ISSUE_TEMPLATE/project-request.yml") -Message "Missing GitHub issue template"
Assert-True -Condition (Test-Path "publish_to_github.ps1") -Message "Missing publish script"

Assert-True -Condition ([bool](Get-Command git -ErrorAction SilentlyContinue)) -Message "git is not available on PATH"
Assert-True -Condition ([bool](Get-Command gh -ErrorAction SilentlyContinue)) -Message "GitHub CLI is not available on PATH"
Assert-True -Condition ([bool](Get-Command python -ErrorAction SilentlyContinue)) -Message "python is not available on PATH"

$gitStatus = git status --porcelain
Assert-True -Condition (-not $gitStatus) -Message "Working tree is not clean. Commit or inspect changes before publishing."

$auth = gh auth status 2>&1
Assert-True -Condition ($LASTEXITCODE -eq 0) -Message "GitHub CLI is not authenticated."

$badPatterns = @(
  "your-email",
  "replace-this",
  "example\.com",
  "mailto:",
  "Huang W",
  ([char]0xFFFD).ToString()
)

$files = Get-ChildItem -Recurse -File | Where-Object {
  $_.FullName -notmatch '[\\/]\.git[\\/]'
}

foreach ($file in $files) {
  $text = Get-Content -Raw $file.FullName
  foreach ($pattern in $badPatterns) {
    $message = "Found unsafe placeholder or mojibake pattern '{0}' in {1}" -f $pattern, $file.FullName
    Assert-True -Condition (-not ($text -match $pattern)) -Message $message
  }
}

Test-Content "index.html" "<title>Fast Web Help \| MRhuang1106</title>" "Missing expected title"
Test-Content "index.html" "samples/cafe\.html" "Missing cafe sample link"
Test-Content "index.html" "samples/readme-refresh\.html" "Missing README refresh sample link"
Test-Content "index.html" "project-request\.yml" "Missing GitHub issue request link"
Test-Content ".github/ISSUE_TEMPLATE/project-request.yml" "client-request" "Missing client-request label in issue template"

$port = 8765
$proc = Start-Process -FilePath python -ArgumentList @("-m", "http.server", "$port", "--bind", "127.0.0.1") -WorkingDirectory (Get-Location) -PassThru -WindowStyle Hidden
try {
  Start-Sleep -Seconds 2
  $paths = @("/", "/samples/cafe.html", "/samples/readme-refresh.html")
  foreach ($path in $paths) {
    $resp = Invoke-WebRequest -Uri "http://127.0.0.1:$port$path" -UseBasicParsing
    Assert-True -Condition ($resp.StatusCode -eq 200) -Message "Local HTTP check failed for $path"
  }
} finally {
  Stop-Process -Id $proc.Id -Force
}

Write-Host "Preflight checks passed."
