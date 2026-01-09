#!/usr/bin/env bash

# Fix wrong-tinted videos captured on Samsung C3322 feature phone (e.g. when recorded in portait, but saved in landscape)

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
echo "Enter the input video file name + extension: "; read input_file

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -vf "transpose=1,scale=144:176" -aspect 3:4 -c:v libx264 -preset veryfast -crf 23 -c:a aac "${input_file%.*}-r.mp4"

echo "================ Processing complete ================"
