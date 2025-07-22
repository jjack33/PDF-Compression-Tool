# PowerShell 7+
# PDF Compressor with Ghostscript installer check, admin self-elevation, robust GS detection, and file picker
# Place this script, gs10051w64.exe, and run_compressor.bat in the same folder

# Self-elevate if not running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
}

# Ensure Windows Forms is available
Add-Type -AssemblyName System.Windows.Forms

# Function: Robustly detect Ghostscript location
function Get-GSPath {
    # 1. Check local folder
    $localGS = Join-Path $PSScriptRoot 'gswin64c.exe'
    if (Test-Path $localGS) { return $localGS }

    # 2. Check all folders in PATH
    foreach ($pathDir in $env:Path.Split(';')) {
        if ($pathDir) {
            $possible = Join-Path $pathDir 'gswin64c.exe'
            if (Test-Path $possible) { return $possible }
        }
    }

    # 3. Check common Program Files locations
    $gsFolders = @(
        "$env:ProgramFiles\gs",
        "$env:ProgramFiles(x86)\gs"
    )
    foreach ($folder in $gsFolders) {
        if (Test-Path $folder) {
            $subDirs = Get-ChildItem -Path $folder -Directory -ErrorAction SilentlyContinue
            foreach ($subDir in $subDirs) {
                $binPath = Join-Path $subDir.FullName 'bin\gswin64c.exe'
                if (Test-Path $binPath) { return $binPath }
            }
        }
    }

    return $null
}

# Function: Attempt to install Ghostscript (user will always see GUI)
function Install-GS {
    $installer = Join-Path $PSScriptRoot 'gs10051w64.exe'
    if (-not (Test-Path $installer)) {
        [System.Windows.Forms.MessageBox]::Show("Ghostscript installer (gs10051w64.exe) not found in this folder. Exiting.")
        exit 1
    }
    # Launch installer GUI (no silent mode in latest versions)
    Start-Process -FilePath $installer -Wait -NoNewWindow
    # Wait for user to finish install and verify Ghostscript is present
    Start-Sleep -Seconds 2
    $gs = Get-GSPath
    if ($gs) { return $gs }
    # If still not found, prompt for manual install
    $msg = "Automatic install failed. Please double-click gs10051w64.exe and finish installing Ghostscript. Click Yes when complete, or No to cancel."
    $result = [System.Windows.Forms.MessageBox]::Show($msg, "Manual Install Needed", [System.Windows.Forms.MessageBoxButtons]::YesNo)
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Wait and check again
        do {
            Start-Sleep -Seconds 2
            $gs = Get-GSPath
        } until ($gs)
        return $gs
    } else {
        exit 1
    }
}

# Step 1: Check for Ghostscript, install if needed
$gsPath = Get-GSPath
Write-Host "Ghostscript path found: '$gsPath'" -ForegroundColor Yellow
if (-not $gsPath) {
    [System.Windows.Forms.MessageBox]::Show("Ghostscript not found. The installer will open. Please finish installation and then return here.", "Installing Ghostscript")
    $gsPath = Install-GS
    if (-not $gsPath) {
        [System.Windows.Forms.MessageBox]::Show("Ghostscript could not be installed. Exiting.")
        exit 1
    }
    Write-Host "Ghostscript path after install: '$gsPath'" -ForegroundColor Yellow
}

# Step 2: Show file picker to select PDFs
$ofd = New-Object System.Windows.Forms.OpenFileDialog
$ofd.Title = "Select PDF(s) to compress"
$ofd.Filter = "PDF Files (*.pdf)|*.pdf"
$ofd.Multiselect = $true

# Bring dialog to foreground and force focus
[System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32 {
        [DllImport("user32.dll")]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();
    }
"@

# Hide PowerShell console temporarily
$consoleWindow = [Win32]::GetConsoleWindow()
[Win32]::ShowWindow($consoleWindow, 0) # Hide

Write-Host "Opening file picker dialog..." -ForegroundColor Green
$selected = $ofd.ShowDialog()

# Show console again
[Win32]::ShowWindow($consoleWindow, 5) # Show Normal

if ($selected -ne [System.Windows.Forms.DialogResult]::OK) {
    [System.Windows.Forms.MessageBox]::Show("No files selected. Exiting.", "Cancelled")
    exit 0
}

# Step 3: For each PDF, compress to same folder with _COMPRESSED suffix
foreach ($inputPath in $ofd.FileNames) {
    $folder = Split-Path $inputPath
    $fileBase = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)
    
    # Generate output path in same folder with _COMPRESSED suffix
    $outputPath = Join-Path $folder "$fileBase`_COMPRESSED.pdf"
    
    # If file already exists, add a number
    $counter = 1
    while (Test-Path $outputPath) {
        $outputPath = Join-Path $folder "$fileBase`_COMPRESSED_$counter.pdf"
        $counter++
    }

    # Run Ghostscript compression
    Write-Host "Compressing '$inputPath' to '$outputPath'" -ForegroundColor Cyan
    Write-Host "Using Ghostscript: '$gsPath'" -ForegroundColor Cyan
    
    $args = @(
        "-sDEVICE=pdfwrite"
        "-dCompatibilityLevel=1.4"
        "-dPDFSETTINGS=/screen"
        "-dNOPAUSE"
        "-dQUIET"
        "-dBATCH"
        "-sOutputFile=`"$outputPath`""
        "`"$inputPath`""
    )

    # Use Start-Process to avoid PowerShell argument parsing issues
    try {
        $p = Start-Process -FilePath $gsPath -ArgumentList $args -Wait -PassThru
        if ($p.ExitCode -eq 0) {
            Write-Host "SUCCESS: Compressed '$fileBase' -> saved as '$(Split-Path $outputPath -Leaf)'" -ForegroundColor Green
        } else {
            Write-Host "FAILED: Compression failed for '$fileBase' (Exit code: $($p.ExitCode))" -ForegroundColor Red
        }
    } catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    }
}

[System.Windows.Forms.MessageBox]::Show("All done!", "Complete")
exit 0