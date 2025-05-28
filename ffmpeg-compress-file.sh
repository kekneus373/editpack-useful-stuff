#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the output video file name (WITHOUT extension): " output_file
read -p "Set the aspect ratio (e.g. 16:9): " ar
read -p "Set the video bitrate (e.g. 2M): " bv

# Run ffmpeg command with user input
ffmpeg -i "$dir"/"$input_file" -c:v libx264 -b:v "$bv" -s 1280x720 -aspect "$ar" -preset veryfast -r 25 -c:a mp3 -b:a 128k "$dir"/"$output_file".mp4 # compress

echo "Processing complete. PRO TIP: Run 'ffmpeg-compress-folder-16-9.sh' to save time and encode entire folder!"
