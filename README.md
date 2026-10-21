# 🚀 DriveToDisk

> **Turn your Google Drive into a physical Windows Hard Drive (`E:\`) with true cloud quota!**  
> 100% Free, Open Source, and Automated.

---

## 💡 The Problem
The official Google Drive Desktop app clamps your displayed storage to your physical SSD's free space. If your C: drive has only 10 GB free, Google Drive tells Windows you only have 10 GB free — even if you pay for **2 TB or 5 TB** of Google Cloud storage!

## ✨ The Solution: DriveToDisk
**DriveToDisk** mounts your Google Drive directly via high-performance Windows FUSE:
* 🎯 **True Storage Display**: Shows your real quota in "This PC" (e.g. `4.99 TB Free of 5.00 TB`).
* ⚡ **High-Speed Cache**: Uses local chunked VFS caching for seamless streaming.
* 🔄 **Zero-Touch Startup**: Automatically mounts on Windows boot in the background.
* 🛡️ **Zero Bloatware**: No ads, no telemetry, no subscription fees.

---

## 📦 Quick Installation (1-Click)

1. Download [`Setup_DriveToDisk.bat`](./Setup_DriveToDisk.bat).
2. Right-click and choose **Run as administrator** (or normal user).
3. Choose your preferred drive letter (e.g., `E:`, `X:`, `Z:`).
4. Complete the 1-time Google login in your browser.
5. **Done!** Your Google Drive is now a real Windows Drive letter.

---

## ⚙️ How It Works Under The Hood

* **Engine**: [Rclone](https://rclone.org/)
* **Filesystem Driver**: [WinFsp](https://winfsp.dev/) (Windows File System Proxy)
* **Mode**: VFS Full Cache (`--vfs-cache-mode full`) with smart 30 GB eviction.
* **Auto-mount**: Configured via non-intrusive Windows Run Registry key and silent VBScript launcher.

---

## 📄 License
MIT License — Free to use, modify, and distribute.
