# render_homeworks.ps1
# Script to render suffix files and place them in the output directory (_sites/)

# Prevent infinite recursion when this script calls quarto render
if ($env:SKIP_HOMEWORK_RENDER -eq "1") {
    Write-Host "Skipping homework rendering (recursion prevention)."
    exit 0
}

# Set environment variable to prevent recursion in child processes
$env:SKIP_HOMEWORK_RENDER = "1"

$outputDir = "_sites"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Get list of files to process
$filesToProcess = @()
$filesToProcessNames = @()

$isQuarto = -not [string]::IsNullOrEmpty($env:QUARTO_PROJECT_DIR) -or -not [string]::IsNullOrEmpty($env:QUARTO_PROJECT_ROOT)

if ($isQuarto) {
    if ($env:QUARTO_PROJECT_OUTPUT_FILES) {
        # Split output files by newline
        $outputFiles = $env:QUARTO_PROJECT_OUTPUT_FILES -split "`r?`n"
        
        # Check if any homework files were rendered in this session
        foreach ($outFile in $outputFiles) {
            if ($outFile -match "(?:^|/|\\)homework(\d+)(?:-5562048)?\.html$") {
                $num = $Matches[1]
                $file = Get-ChildItem -Path $PSScriptRoot -Filter "homework$num-5562048.qmd" | Select-Object -First 1
                if ($file -and $filesToProcessNames -notcontains $file.FullName) {
                    $filesToProcess += $file
                    $filesToProcessNames += $file.FullName
                }
            }
        }
    }
    
    # If we are in Quarto context and no homework files need processing, exit early
    if ($filesToProcess.Count -eq 0) {
        Write-Host "Skipping homework rendering: no homework files were rendered in this session."
        exit 0
    }
} else {
    # Manual run (no Quarto environment): process all homeworks
    $filesToProcess = Get-ChildItem -Path $PSScriptRoot -Filter "*5562048.qmd"
    Write-Host "Manual run detected. Processing all homework files..."
}

foreach ($file in $filesToProcess) {
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
