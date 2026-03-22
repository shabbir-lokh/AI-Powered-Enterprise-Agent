# bootstrap.ps1 — Enterprise Agent Capstone setup script (Windows / PowerShell)
# Run from the repo root: .\setup\bootstrap.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Enterprise Agent Capstone — Bootstrap Script" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# ── 1. Check Git ──────────────────────────────────────────────────────────────
Write-Host "[1/6] Checking Git..." -ForegroundColor Yellow
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  ✗  Git not found. Download from: https://git-scm.com/download/win" -ForegroundColor Red
    Write-Host "     Install Git and re-run this script." -ForegroundColor Red
    exit 1
}
$gitVersion = git --version
Write-Host "  ✓  $gitVersion" -ForegroundColor Green

# ── 2. Check Python ───────────────────────────────────────────────────────────
Write-Host "[2/6] Checking Python..." -ForegroundColor Yellow
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "  ✗  Python not found. Download from: https://www.python.org/downloads/" -ForegroundColor Red
    Write-Host "     Make sure to tick 'Add Python to PATH' during installation." -ForegroundColor Red
    exit 1
}
$pythonVersion = python --version
Write-Host "  ✓  $pythonVersion" -ForegroundColor Green

# ── 3. Create virtual environment ────────────────────────────────────────────
$venvPath = Join-Path $RepoRoot ".venv"
Write-Host "[3/6] Creating virtual environment at .venv..." -ForegroundColor Yellow
if (Test-Path $venvPath) {
    Write-Host "  ✓  Virtual environment already exists, skipping creation." -ForegroundColor Green
} else {
    python -m venv $venvPath
    Write-Host "  ✓  Virtual environment created." -ForegroundColor Green
}

# ── 4. Activate venv and upgrade pip ─────────────────────────────────────────
Write-Host "[4/6] Activating venv and upgrading pip..." -ForegroundColor Yellow
$activateScript = Join-Path $venvPath "Scripts\Activate.ps1"
. $activateScript
python -m pip install --upgrade pip --quiet
Write-Host "  ✓  pip upgraded." -ForegroundColor Green

# ── 5. Install dependencies ───────────────────────────────────────────────────
Write-Host "[5/6] Installing Python dependencies from setup\requirements.txt..." -ForegroundColor Yellow
$requirementsFile = Join-Path $RepoRoot "setup\requirements.txt"
pip install -r $requirementsFile
Write-Host "  ✓  All dependencies installed." -ForegroundColor Green

# ── 6. Create .env file if missing ───────────────────────────────────────────
Write-Host "[6/6] Setting up .env file..." -ForegroundColor Yellow
$envFile = Join-Path $RepoRoot ".env"
if (-not (Test-Path $envFile)) {
    @"
# ── OpenAI ───────────────────────────────────────────────────────────────────
OPENAI_API_KEY=your_openai_api_key_here

# ── App Config ────────────────────────────────────────────────────────────────
APP_ENV=development
APP_PORT=8000
"@ | Set-Content $envFile
    Write-Host "  ✓  .env file created. Edit it and add your OPENAI_API_KEY." -ForegroundColor Green
} else {
    Write-Host "  ✓  .env file already exists, skipping." -ForegroundColor Green
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Setup complete!" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Open .env and replace 'your_openai_api_key_here' with your real key." -ForegroundColor White
Write-Host "     Get a key at: https://platform.openai.com/" -ForegroundColor White
Write-Host "  2. Activate the venv in your terminal:" -ForegroundColor White
Write-Host "     .\.venv\Scripts\Activate.ps1" -ForegroundColor Yellow
Write-Host "  3. Start building the agent in src/" -ForegroundColor White
Write-Host ""
