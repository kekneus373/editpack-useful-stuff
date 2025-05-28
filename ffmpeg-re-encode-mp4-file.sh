#!/usr/bin/env bash

# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the output video file name + extension: " output_file

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libx264 -c:a aac "$output_file"


echo "Processing complete. PRO TIP: It's easier to move videos for processing to the '~/Videos/sh/' folder, and then run 'ffmpeg-re-encode-folder.sh' to save time!"
