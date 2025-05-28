#!/usr/bin/env bash

# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
read -p "Enter the output video file name + extension: " output_file

# Run ffmpeg command with user input
ffmpeg -i "$dir"/"$input_file" -vf "pad=iw:2*trunc(iw*16/18):(ow-iw)/2:(oh-ih)/2,setsar=1" -c:a copy "$dir"/"$output_file"

echo "Processing complete. PRO TIP: It's easier to move videos for processing to the '~/Videos/sh/' folder, and then run 'ffmpeg-convert-169-916-folder.sh' to save time!"
