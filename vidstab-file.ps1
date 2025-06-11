# v2: introduced Pause when script finishes
# Create an output folder if it doesn't exist
$OutputFolder = "ok"
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Display a warning about FFmpeg
Write-Host "# NOTE! Your FFmpeg build must contain the libvidstab plugin."
Write-Host "Read 'readme.md' instructions to quickly get the correct FFmpeg binary."
$ff = Read-Host "Enter the full path to ffmpeg.exe (e.g., C:\FFmpeg\bin\ffmpeg.exe)"
if (!(Test-Path $ff)) {
    Write-Host "Error: FFmpeg path is invalid. Exiting."
    exit
}

# Prompt the user for input
$input_file = Read-Host "Enter the input video file name + extension (e.g., video.mp4)"
$bv = Read-Host "Enter the video bitrate (e.g., 1500k, 8M)"

# Remove old transforms file if it exists
$transforms_file = "transforms.trf"
if (Test-Path $transforms_file) {
    Remove-Item $transforms_file -Force
}

# Extract only the filename from the input path
$filename = Split-Path -Leaf $input_file

# Run FFmpeg with corrected output path
& $ff -i "$input_file" -an -vf "vidstabdetect=shakiness=7" -f null -
& $ff -i "$input_file" -c:v libx264 -b:v "$bv" -vf "vidstabtransform=smoothing=30:zoom=5:input=transforms.trf" "$OutputFolder\$filename-stabilized.mp4"

Write-Host "Processing complete! The stabilized video is in the 'ok' folder."
Read-Host -Prompt "Press Enter to continue..."
