<#
Robocopy-To.ps1
https://github.com/ZeroErrors/robocopy-to

.SYNOPSIS
  Context-menu helper that copies one folder to another using Robocopy.
  First parameter  = source folder supplied by Explorer.
  Optional second  = destination folder (skips the folder picker when present).
#>

param(
    [Parameter(Mandatory)]
    [string]$Src,

    [string]$Dest
)

# Ask for a target when the second argument is missing
if (-not $Dest) {
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.BrowseForFolder(0,'Choose destination',0)
    if (-not $folder) {
        Write-Host "No destination folder selected. Exiting." -ForegroundColor Red
        pause
        exit
    }
    $Dest = $folder.Self.Path
}

$cpuCount = [Environment]::ProcessorCount
$threads = [Math]::Min($cpuCount * 4, 128)

# ----- Tweak your Robocopy switches here -----
$robocopyArgs = @(
    '"{0}"' -f $Src
    '"{0}"' -f $Dest
    '/E'            # copy sub-dirs, even empty ones
    '/DCOPY:T'      # keep directory timestamps
    '/COPY:DAT'     # copy data, attrs, timestamps
    '/R:3'          # retry 3× on errors
    '/W:3'          # wait 3s between retries
    "/MT:$threads"  # 8 threads (change to taste)
    '/NFL'        # no file list
    '/NDL'        # no directory list
   # '/NJH'        # no job header
   # '/NJS'        # no job summary
   # '/NP'         # no progress
)
# ---------------------------------------------

# Write-Host "Robocopy" @robocopyArgs -ForegroundColor Cyan
robocopy @robocopyArgs

Write-Host "`nDone."
pause   # comment-out if you don’t want the Pause
