#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Prompt the user for input
read -p "Enter the input file name + extension: " input_file
read -p "Set the audio bitrate (e.g. 128k): " ba

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:a mp3 -b:a "$ba" "${input_file%.*}.mp3"

echo "Processing complete. PRO TIP: Run 'ffmpeg-mp3-folder.sh' to save time and encode entire folder!"
