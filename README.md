# 📄 PDF Compression Tool

A simple, foolproof PDF compression tool for Windows that uses Ghostscript. Perfect for non-technical users who just want to quickly compress PDF files.

## ✨ Features

✅ **One-click operation** - Just double-click and select files  
✅ **Automatic Ghostscript installation** - Handles setup for you  
✅ **Batch processing** - Compress multiple PDFs at once  
✅ **Smart file naming** - Adds "_COMPRESSED" suffix automatically  
✅ **No overwriting** - Safely handles duplicate filenames  
✅ **Same-folder output** - Compressed files appear next to originals  
✅ **Admin elevation** - Automatically requests needed permissions  
✅ **Error handling** - Clear messages for any issues  

## 🚀 Quick Start

1. **Download** the files or clone this repository
2. **Download Ghostscript installer** - Get `gs10051w64.exe` from [Ghostscript.com](https://www.ghostscript.com/download/gsdnld.html) and place it in the same folder
3. **Extract** all files to a folder (Desktop works great)
4. **Double-click** `run_compressor.bat`
5. **Select** your PDF files when prompted
6. **Done!** Compressed files automatically appear with "_COMPRESSED" in the name

## 📦 What You Get

- **`compress_pdfs.ps1`** - Main PowerShell script (the brains)
- **`run_compressor.bat`** - Double-click this to start (recommended)
- **`run_compressor_debug.bat`** - Debug version that shows console output
- **`INSTRUCTIONS.md`** - Detailed step-by-step user instructions
- **`gs10051w64.exe`** - Ghostscript installer (download separately)

## 💻 System Requirements

- **Windows 10/11** (with PowerShell)
- **Administrator privileges** (script will prompt automatically)
- **~50MB disk space** (for Ghostscript installation)

## 🔧 How It Works

1. **Auto-elevation** - Requests admin rights if needed for Ghostscript installation
2. **Ghostscript detection** - Finds existing installation or installs it automatically
3. **File selection** - Clean Windows file picker for choosing PDFs
4. **Compression** - Uses Ghostscript with optimal settings for size reduction
5. **Output** - Saves compressed files in same folders as originals

## 📊 Example Results

**Before:**
```
📁 Documents/
├── Tax_Return_2024.pdf     (2.5 MB)
└── Invoice_Jan.pdf         (1.8 MB)
```

**After:**
```
📁 Documents/
├── Tax_Return_2024.pdf              (2.5 MB) ← original unchanged
├── Tax_Return_2024_COMPRESSED.pdf   (800 KB) ← new compressed version
├── Invoice_Jan.pdf                  (1.8 MB) ← original unchanged
└── Invoice_Jan_COMPRESSED.pdf       (600 KB) ← new compressed version
```

**Typical compression:** 60-80% size reduction with minimal quality loss

## 🛠️ Installation & Setup

### Option 1: Quick Download
1. Download all files from this repository
2. Download `gs10051w64.exe` from [Ghostscript Downloads](https://www.ghostscript.com/download/gsdnld.html)
3. Put everything in one folder
4. Double-click `run_compressor.bat`

### Option 2: Git Clone
```bash
git clone https://github.com/jjack33/PDF-Compression-Tool.git
cd PDF-Compression-Tool
# Download gs10051w64.exe and place here
# Double-click run_compressor.bat
```

## 🐛 Troubleshooting

### File picker doesn't appear?
- Check your taskbar for a flashing icon
- Try the debug version: `run_compressor_debug.bat`
- Look for the dialog on other monitors if you have multiple displays

### "Execution policy" error?
- The batch file handles this automatically
- Make sure you're running `run_compressor.bat`, not the `.ps1` file directly
- Run as administrator if problems persist

### Ghostscript installation issues?
- Close everything and try again
- Make sure you're not running from inside a zip file
- Manually download and install Ghostscript first, then run the tool
- Check if antivirus is blocking the installer

### Compression fails?
- Ensure PDF files aren't corrupted
- Check if files are password-protected (not supported)
- Try with a different PDF to isolate the issue
- Run debug mode to see detailed error messages

## ⚙️ Technical Details

### Compression Settings
- **Device:** `pdfwrite` (PDF output device)
- **Compatibility:** PDF 1.4 (maximum compatibility)
- **Quality:** `/screen` (optimized for viewing, good compression)
- **Processing:** Lossless optimization + recompression
- **Safety:** Original files never modified

### Security
- **Admin rights:** Only required for Ghostscript installation
- **Network:** No internet connections after initial Ghostscript download
- **Privacy:** All processing happens locally on your machine
- **Code:** Open source - inspect the PowerShell script yourself

### File Detection Logic
The script automatically finds Ghostscript in these locations:
1. Same folder as the script
2. System PATH environment variable
3. `C:\Program Files\gs\*\bin\`
4. `C:\Program Files (x86)\gs\*\bin\`

## 📝 User Instructions

See [INSTRUCTIONS.md](INSTRUCTIONS.md) for detailed, non-technical step-by-step directions perfect for sharing with end users.

## 🔄 Version History

- **v1.0** - Initial release
  - Basic PDF compression
  - File picker interface
  - Automatic Ghostscript handling
  - Batch processing support
  - Smart output naming
  - Error handling

## 🤝 Contributing

Found a bug or want to improve something?
1. Fork this repository
2. Make your changes
3. Test thoroughly on Windows 10/11
4. Submit a pull request

## 📄 License

This project is free to use and modify. Built with PowerShell and Ghostscript.

**Dependencies:**
- [Ghostscript](https://www.ghostscript.com/) - GPL/AGPL licensed PDF processor
- Windows PowerShell - Built into Windows

## 💡 Why This Tool?

Most PDF compression tools are either:
- **Expensive** - Require paid licenses
- **Online-only** - Privacy concerns, file size limits
- **Complex** - Too many options, confusing UI
- **Unreliable** - Crash, poor compression, corrupt files

This tool is:
- **Free** - No cost, no limits
- **Private** - Everything stays on your computer
- **Simple** - Double-click and go
- **Reliable** - Built on proven Ghostscript technology

---

**Made this tool useful?** ⭐ Star the repo and share it with others who need simple PDF compression!

**Questions or issues?** Open an issue in this repository and I'll help you out.

---

*Built by [@jjack33](https://github.com/jjack33) • Last updated: July 2025*