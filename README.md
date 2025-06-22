# Robocopy To

This is a simple Powershell script to add "Robocopy To" to the context menu in Windows Explorer to make it convenient to files and folders using Robocopy.

## Why?
The file copy in Windows Explorer is very slow, especially when copying large files or many files. Robocopy is a built-in command-line utility in Windows that is much faster and more efficient for copying files and directories.

The main problem with Robocopy for most users is two fold:
1. Robocopy is a command-line utility, so it requires you to open a command prompt and type the command manually, get file paths, etc.
2. Robocopy's default behavior is not ideal, so you need to specify options every time you use it

The aim of this script is to make it easy to use Robocopy from the context menu in Windows Explorer, so you can copy files and directories with just a few clicks.

## How to use

1. Download `Robocopy-To.ps1` and `Robocopy-To-Install.bat` from this repository into a folder of your choice (e.g. `C:\RobocopyTo`)
2. Run `Robocopy-To-Install.bat`

Thats it. Now you can right-click on any file or folder in Windows Explorer and select "Robocopy To" to copy it to a destination folder.

## How to uninstall

To uninstall run the `Robocopy-To-Uninstall.bat` script.


## Default Behavior

By default `Robocopy-To.ps1` specifies the following options:
- `/E` - Copy all subdirectories, including empty ones
- `/DCOPY:T` - Copy directory timestamps
- `/COPY:DAT` - Copy data, attributes, and timestamps
- `/R:3` - Retry 3 times on failed copies
- `/W:3` - Wait 3 seconds between retries
- `/MT:$threads` - Enables multithreading. The thread count is your CPU core count * 4
- `/NFL` - No file list
- `/NDL` - No directory list

You can easily modify the arguments provided in the script for whatever default behavior best suits your needs.
