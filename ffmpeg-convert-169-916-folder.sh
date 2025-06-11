#!/usr/bin/env bash

# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Ask for input file extension (e.g., webm, mp4)
read -p "Specify the source files extension (e.g. mp4): " extin

# Create output directory
mkdir -p sh

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do
    ffmpeg -i "$i" -c:v libx264 -vf "pad=iw:2*trunc(iw*16/18):(ow-iw)/2:(oh-ih)/2,setsar=1" -preset faster -crf 23 -c:a aac sh/"${i%.*}-sh.mp4"
done

echo "Processing complete. PRO TIP: Use 'ffmpeg-convert-169-916-file.sh' to process only one video file!"
