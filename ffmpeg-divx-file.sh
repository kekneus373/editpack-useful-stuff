#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Set the aspect ratio (e.g. 16:9): " ar
read -p "Set the video bitrate (e.g. 2M): " bv

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libxvid -b:v "$bv" -s 720x576 -aspect "$ar" -r 25 -c:a mp3 -b:a 192k "${input_file%.*}.avi"


echo "Processing complete. PRO TIP: Run 'ffmpeg-divx-folder-<aspect ratio>-safe.sh' to save time and encode entire folder!"
