# watch-desktop-ini.ps1
# Script to monitor the project folder recursively and automatically delete desktop.ini files as they are created.

# Path to monitor (defaults to the directory containing this script)
$watchPath = $PSScriptRoot
if (-not $watchPath) {
    $watchPath = Get-Location
}

Write-Host "Starting file system watcher on: $watchPath"
Write-Host "Monitoring recursively for 'desktop.ini' files..."
Write-Host "Press Ctrl+C to stop the script."

# First, clean up any existing desktop.ini files in the project
Write-Host "Performing initial cleanup of existing desktop.ini files..."
Get-ChildItem -Path $watchPath -Filter "desktop.ini" -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "Found existing: $($_.FullName)"
    try {
        # desktop.ini files are hidden system files, we need to clear attributes first
        $_.Attributes = 'Normal'
        Remove-Item -Path $_.FullName -Force -ErrorAction Stop
        Write-Host "Deleted successfully."
    } catch {
        Write-Warning "Could not delete $($_.FullName): $_"
    }
}

# Create FileSystemWatcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.Filter = "desktop.ini"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Action to perform when a desktop.ini is created or modified
$action = {
    param($sender, $eventArgs)
    $path = $eventArgs.FullPath
    $changeType = $eventArgs.ChangeType
    Write-Host "[$changeType] Detected: $path at $(Get-Date -Format 'HH:mm:ss')"
    
    # Wait briefly for Google Drive or Windows to finish writing/releasing lock
    Start-Sleep -Milliseconds 100
    
    if (Test-Path $path) {
        try {
            # Clear Hidden/System attributes so it can be deleted
            Set-ItemProperty -Path $path -Name Attributes -Value "Normal" -ErrorAction SilentlyContinue
            Remove-Item -Path $path -Force -ErrorAction Stop
            Write-Host "Deleted: $path"
        } catch {
            # Retry after a short delay if it was locked by Google Drive
            Start-Sleep -Milliseconds 500
            try {
                Set-ItemProperty -Path $path -Name Attributes -Value "Normal" -ErrorAction SilentlyContinue
                Remove-Item -Path $path -Force -ErrorAction Stop
                Write-Host "Deleted on retry: $path"
            } catch {
                Write-Warning "Failed to delete: $path. Error: $_"
            }
        }
    }
}

# Register events for Created and Changed
$createdEvent = Register-ObjectEvent $watcher -EventName "Created" -Action $action
$changedEvent = Register-ObjectEvent $watcher -EventName "Changed" -Action $action

try {
    # Keep the script running to listen to events
    while ($true) {
        Start-Sleep -Seconds 1
    }
} finally {
    # Cleanup registered events when exiting
    Write-Host "Stopping file system watcher..."
    Unregister-Event -SourceIdentifier $createdEvent.Name -ErrorAction SilentlyContinue
    Unregister-Event -SourceIdentifier $changedEvent.Name -ErrorAction SilentlyContinue
    $watcher.Dispose()
}
