# Builds the Chrome Web Store upload: context-capture-v<version>.zip
# Usage: npm run package

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$version = (Get-Content manifest.json -Raw | ConvertFrom-Json).version
$zip = "context-capture-v$version.zip"

# Files the extension always needs.
$include = @('manifest.json', 'background.js', 'popup.html', 'options.html', 'offscreen.html')
$include += Get-ChildItem content-scripts, icons -File | ForEach-Object { "$($_.Directory.Name)/$($_.Name)" }

# chunks/ and assets/ can hold leftovers from older builds.
# Include only the files reachable from the files above.
$candidates = Get-ChildItem chunks, assets -File | ForEach-Object { "$($_.Directory.Name)/$($_.Name)" }
$queue = [System.Collections.Generic.Queue[string]]::new()
$include | ForEach-Object { $queue.Enqueue($_) }
while ($queue.Count -gt 0) {
    $file = $queue.Dequeue()
    if ($file -notmatch '\.(js|html|css|json)$') { continue }
    $text = Get-Content $file -Raw
    foreach ($c in $candidates) {
        if ($include -notcontains $c -and $text.Contains((Split-Path $c -Leaf))) {
            $include += $c
            $queue.Enqueue($c)
        }
    }
}

$skipped = $candidates | Where-Object { $include -notcontains $_ }
if ($skipped) { Write-Host "Skipped unused files: $($skipped -join ', ')" }

# Write the zip directly. Compress-Archive in Windows PowerShell 5.1 stores
# paths with backslashes, which the Chrome Web Store can reject.
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
if (Test-Path $zip) { Remove-Item $zip }
$archive = [System.IO.Compression.ZipFile]::Open((Join-Path $root $zip), 'Create')
try {
    foreach ($f in $include) {
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $archive, (Join-Path $root $f), $f, 'Optimal') | Out-Null
    }
} finally {
    $archive.Dispose()
}

Write-Host "Created $zip ($($include.Count) files)"
