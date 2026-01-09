#!/usr/bin/env bash

# Enter the working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
echo "Enter the input video file name + extension: "; read input_file
read -p "Enter the start point (e.g. 00:00:10): " ss
read -p "Enter the end point (e.g. 00:00:30): " t

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -ss "$ss" -t "$t" -c:v libx264 -preset faster -c:a aac "${input_file%.*}-trimmed.mp4"

echo "================ Processing complete ================"
