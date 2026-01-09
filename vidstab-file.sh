#!/usr/bin/env bash

# Prompt user for the folder path
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Invalid folder path!"; exit 1; }

# Create an output folder
mkdir -p stab

# Prompt the user for input
echo "# NOTE! Your FFmpeg build must contain libvidstab plugin. Read 'readme-ffmpeg-vidstab.md' instructions to quickly get the correct FFmpeg binary."
echo "Enter the input video file name + extension: "; read input_file
read -p "Enter the video bitrate (e.g. 1500k, 8M): " bv

# Remove old transforms file
rm transforms.trf 2>&1/dev/null

# Run ffmpeg commands with user input
ffmpeg -i "$input_file" -an -vf vidstabdetect=shakiness=7 -f null -
ffmpeg -i "$input_file" -c:v libx264 -b:v "$bv" -vf vidstabtransform=smoothing=30:zoom=5:input="transforms.trf" stab/"${input_file%.*}-stabilized.mp4"

echo "================ Processing complete ================"
