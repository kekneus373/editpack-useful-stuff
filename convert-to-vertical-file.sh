#!/usr/bin/env bash

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
echo "Enter the input video file name + extension: "; read input_file

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libx264 -vf "pad=iw:2*trunc(iw*16/18):(ow-iw)/2:(oh-ih)/2,setsar=1" -preset faster -crf 23 -c:a aac "${input_file%.*}-sh.mp4"

echo "================ Processing complete ================"
