#!/usr/bin/env bash
# Enter the working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the start point (e.g. 00:00:10): " ss
read -p "Enter the end point (e.g. 00:00:30): " t

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -ss "$ss" -t "$t" -c:v libx264 -c:a aac "${input_file%.*}.mp4"

echo "Processing complete."
