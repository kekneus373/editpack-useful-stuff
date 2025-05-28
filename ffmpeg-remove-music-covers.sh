#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p nc
read -p "Specify the source files extension (e.g. mp3): " extin
read -p "Specify the output format (e.g. ogg): " extout
#read -p "Set the bitrate (e.g. 192k): " ba
# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -q 1 -map a  nc/"${i%.*}.$extout"; done
echo "Processing complete."
#-b:a $ba -minrate $ba -maxrate $ba -bufsize $ba
