# ================================================================
# Liberal Blog Publisher — PowerShell (Windows)
# Article : From First Note to Full Confidence: A 6-Month Journey 🎹
# Slug    : from-first-note-to-full-confidence-a-6-month-journey
# ----------------------------------------------------------------
# HOW TO RUN:
#   1. Move all 3 downloaded files into your tools\ folder
#   2. Open PowerShell (Win+R -> powershell -> Enter)
#   3. First time only: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
#   4. Run: & "C:\Users\immor\Downloads\liberalwebsitenew\tools\publish-blog-from-first-note-to-full-confidence-a-6-month-journey.ps1"
# ================================================================

$ErrorActionPreference = "Stop"
$repo = "C:\Users\immor\Downloads\liberalwebsitenew"
$slug = "from-first-note-to-full-confidence-a-6-month-journey"
$blog = "$repo\pages\blog.html"
$article = "$repo\pages\articles\from-first-note-to-full-confidence-a-6-month-journey.html"

Write-Host "" 
Write-Host "  Liberal Blog Publisher" -ForegroundColor Cyan
Write-Host "  Article : From First Note to Full Confidence: A 6-Month Journey 🎹" -ForegroundColor White
Write-Host "  Slug    : from-first-note-to-full-confidence-a-6-month-journey" -ForegroundColor White
Write-Host ""

if (-not (Test-Path $blog)) {
  Write-Host "ERROR: Cannot find $blog" -ForegroundColor Red
  Write-Host "Check the Repo Path in the Blog Generator." -ForegroundColor Yellow
  exit 1
}

Write-Host "Pulling latest from GitHub..." -ForegroundColor Yellow
Set-Location $repo
git pull origin master --quiet
Write-Host "Pull done." -ForegroundColor Green

Write-Host "Inserting card into blog.html..." -ForegroundColor Yellow
$marker = "<!-- PASTE NEW CARD HERE (top of grid = newest first) -->"
$content = Get-Content $blog -Raw -Encoding UTF8
$cardFile = "$repo\tools\card-from-first-note-to-full-confidence-a-6-month-journey.html"

if (-not (Test-Path $cardFile)) {
  Write-Host "ERROR: card-from-first-note-to-full-confidence-a-6-month-journey.html not found in tools\ folder." -ForegroundColor Red
  Write-Host "Download it from the generator and move it to: $repo\tools\" -ForegroundColor Yellow
  exit 1
}

if ($content.Contains($marker)) {
  $card = Get-Content $cardFile -Raw -Encoding UTF8
  $newContent = $content.Replace($marker, $marker + "`r`n`r`n" + $card + "`r`n")
  [System.IO.File]::WriteAllText($blog, $newContent, [System.Text.Encoding]::UTF8)
  Write-Host "blog.html updated." -ForegroundColor Green
} else {
  Write-Host "WARNING: Marker not found in blog.html" -ForegroundColor Yellow
  Write-Host "Add this line inside .blog-grid in blog.html:" -ForegroundColor Yellow
  Write-Host "  $marker" -ForegroundColor Cyan
  exit 1
}

Write-Host "Saving article page..." -ForegroundColor Yellow
$articleFile = "$repo\tools\article-from-first-note-to-full-confidence-a-6-month-journey.html"
if (-not (Test-Path $articleFile)) {
  Write-Host "ERROR: article-from-first-note-to-full-confidence-a-6-month-journey.html not found in tools\ folder." -ForegroundColor Red
  exit 1
}
$null = New-Item -ItemType Directory -Force -Path "$repo\pages\articles"
Copy-Item $articleFile $article -Force
Write-Host "Article saved: pages/articles/from-first-note-to-full-confidence-a-6-month-journey.html" -ForegroundColor Green

Write-Host "Committing and pushing to GitHub..." -ForegroundColor Yellow
Set-Location $repo
git add "pages/blog.html" "pages/articles/from-first-note-to-full-confidence-a-6-month-journey.html"
git commit -m "blog: add from-first-note-to-full-confidence-a-6-month-journey"
git push origin master

Write-Host "" 
Write-Host "Published!" -ForegroundColor Green
Write-Host "Article: From First Note to Full Confidence: A 6-Month Journey 🎹" -ForegroundColor White
Write-Host "Live in ~30 seconds at:" -ForegroundColor White
Write-Host "https://seanqiubrave.github.io/liberalwebsitenew/pages/blog.html" -ForegroundColor Cyan
Write-Host ""
