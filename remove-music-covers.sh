#!/usr/bin/env bash

# Prompt user for the folder path
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Invalid folder path!"; exit 1; }

# Create an output folder
mkdir -p nc

# Prompt the user for input
read -p "Specify the source files extension (e.g. mp3): " extin
read -p "Specify the output format (e.g. ogg): " extout

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -q 1 -map a  nc/"${i%.*}.$extout"; done

echo "================ Processing complete ================"

# Optional
#read -p "Set the bitrate (e.g. 192k): " ba
#-b:a $ba -minrate $ba -maxrate $ba -bufsize $ba
