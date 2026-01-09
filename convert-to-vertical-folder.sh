#!/usr/bin/env bash

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Ask for input file extension (e.g., webm, mp4)
echo "Enter the input video file name + extension: "; read input_file

# Create output directory
mkdir -p sh

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do
    ffmpeg -i "$i" -c:v libx264 -vf "pad=iw:2*trunc(iw*16/18):(ow-iw)/2:(oh-ih)/2,setsar=1" -preset faster -crf 23 -c:a aac sh/"${i%.*}-sh.mp4"
done

echo "================ Processing complete ================"
