#!/usr/bin/env bash
# Enter the working directory
read -p "Specify the full path of the working directory: " dir
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the start point (e.g. 00:00:10): " ss
read -p "Enter the end point (e.g. 00:00:30): " t
read -p "Enter the output video file name + extension: " output_file

# Run ffmpeg command with user input
ffmpeg -i "$dir"/"$input_file" -ss "$ss" -t "$t" -c copy "$dir"/"$output_file"

echo "Processing complete."
