#!/usr/bin/env bash
# Enter the working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Create an output folder
mkdir -p stab
# Prompt the user for input
echo "# NOTE! Your FFmpeg build must contain libvidstab plugin. Read 'readme-ffmpeg-vidstab.md' instructions to quickly get the correct FFmpeg binary."
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the video bitrate (e.g. 1500k, 8M): " bv
# Remove old transforms file
rm transforms.trf
# Run ffmpeg commands with user input
ffmpeg -i "$input_file" -an -vf vidstabdetect=shakiness=7 -f null -
ffmpeg -i "$input_file" -c:v libx264 -b:v "$bv" -vf vidstabtransform=smoothing=30:zoom=5:input="transforms.trf" stab/"${input_file%.*}-stabilized.mp4"
echo "Processing complete. PRO TIP: It's easier to process all videos using the 'ffmpeg-vidstab-folder.sh' to save time!"
