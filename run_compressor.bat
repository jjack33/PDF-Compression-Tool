@echo off
echo Starting PDF Compressor...
echo.
echo If the file picker doesn't appear, check your taskbar or look for a flashing icon.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0compress_pdfs.ps1"