# render_homeworks.ps1
# Script to render suffix files and place them in the output directory (docs/)

# Skip rendering homework files if this is a single-file render/preview invoked by Quarto
if ($env:QUARTO_PROJECT_DIR -and $env:QUARTO_PROJECT_RENDER_ALL -ne "1") {
    Write-Host "Skipping homework rendering during single-file render or preview."
    exit 0
}

$outputDir = "_sites"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

$files = Get-ChildItem -Path $PSScriptRoot -Filter "*5562048.qmd"
foreach ($file in $files) {
    Write-Host "Rendering $($file.Name)..."
    quarto render $file.FullName
    
    $htmlName = $file.Name.Replace(".qmd", ".html")
    $htmlSrc = Join-Path $PSScriptRoot $htmlName
    $htmlDst = "$PSScriptRoot\$outputDir\$htmlName"
    
    if (Test-Path $htmlSrc) {
        Write-Host "Moving $htmlSrc to $htmlDst"
        Move-Item -Path $htmlSrc -Destination $htmlDst -Force
    }
    
    $filesDirName = $file.Name.Replace(".qmd", "_files")
    $filesDirSrc = Join-Path $PSScriptRoot $filesDirName
    $filesDirDst = "$PSScriptRoot\$outputDir\$filesDirName"
    
    if (Test-Path $filesDirSrc) {
        Write-Host "Moving $filesDirSrc to $filesDirDst"
        if (Test-Path $filesDirDst) {
            Remove-Item -Path $filesDirDst -Recurse -Force
        }
        Move-Item -Path $filesDirSrc -Destination $filesDirDst -Force
    }
}
