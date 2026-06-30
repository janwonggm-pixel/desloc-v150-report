$ErrorActionPreference = "Stop"

$targetDir = Join-Path $PSScriptRoot "docs"
$target = Join-Path $targetDir "index.html"

$source = Get-ChildItem -LiteralPath $PSScriptRoot -Filter "*.html" -File |
    Where-Object {
        $content = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
        $content.Contains('<div class="toc">') -and $content.Contains('DESLOC V150 Plus')
    } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if ($null -eq $source) {
    throw "Shareable report HTML not found. Expected an HTML file containing '<div class=""toc"">' and 'DESLOC V150 Plus'."
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
Copy-Item -LiteralPath $source.FullName -Destination $target -Force

$noJekyll = Join-Path $targetDir ".nojekyll"
if (-not (Test-Path -LiteralPath $noJekyll)) {
    New-Item -ItemType File -Path $noJekyll | Out-Null
}

Write-Host "Updated share site:"
Write-Host $target
