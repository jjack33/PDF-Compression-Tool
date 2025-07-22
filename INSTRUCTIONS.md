# PDF Compressor – Simple Directions

## **1. Unzip the Folder**
Unzip the contents to your Desktop or another easy-to-find location.
You should see:
- `compress_pdfs.ps1`
- `run_compressor.bat`
- `gs10051w64.exe` (download separately if not included)

## **2. Run the Compressor**
Double-click `run_compressor.bat`.

If a security prompt appears, click "Yes" or "Run".

## **3. If Prompted, Install Ghostscript**
If Ghostscript isn't installed, an installer will appear.

Click "Next" and "Finish" to complete the install.

When asked by the script, click "Yes" to confirm you've finished installing.

## **4. Pick Your PDFs**
A window will appear titled "Select PDF(s) to compress".

Browse to your PDF files, select one or more, and click "Open".

## **5. Automatic Compression** *(No manual steps needed!)*

The script now automatically compresses your files! No more manual saving - compressed files are automatically saved in the same folders as your original PDFs with "_COMPRESSED" added to the filename.

**For example:**
- `Tax_Return_2024.pdf` becomes `Tax_Return_2024_COMPRESSED.pdf`
- `Invoice_Jan.pdf` becomes `Invoice_Jan_COMPRESSED.pdf`

## **6. Completion**
You'll see progress messages in the console window.

When done, you'll see "All done!"

The compressed PDFs will be saved in the same folder(s) as your original files.

---

## **Troubleshooting**
- If Ghostscript installer runs, but the script still asks for install, close everything and run `run_compressor.bat` again.
- If you have issues, make sure you're not running files directly from inside the zip.
- If the file picker doesn't appear, check your taskbar for a flashing icon.

## **That's it!**
Whenever you need to compress PDFs, just double-click `run_compressor.bat`, select your files, and they'll be automatically compressed with no additional steps needed!

---

### **Pro Tips:**
- Select multiple PDFs at once to batch process them
- Original files are never modified - only new compressed versions are created
- If a compressed file already exists, the script will add a number (e.g., `_COMPRESSED_1.pdf`)
- Keep the three main files together in the same folder for best results

### **Getting Ghostscript:**
If you don't have the `gs10051w64.exe` file:
1. Go to [Ghostscript Downloads](https://www.ghostscript.com/download/gsdnld.html)
2. Download "GPL Ghostscript 10.05.1 for Windows (64 bit)"
3. Save it as `gs10051w64.exe` in the same folder as the other files

### **File Sizes:**
- Typical compression: 60-80% size reduction
- A 2MB PDF might become 500KB-800KB
- Results vary depending on the original PDF content and quality