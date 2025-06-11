#!/usr/bin/env bash

# Fix wrong-tinted videos captured on Samsung C3322 feature phone (e.g. when recorded in portait, but saved in landscape)

# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Ask for input file extension (e.g., webm, mp4)
read -p "Specify the source files extension (e.g. mp4): " extin

# Create output directory
mkdir -p r

# Run ffmpeg command with user input
for i in *."$extin"; do
    ffmpeg -i "$i" -vf "transpose=1,scale=144:176" -aspect 3:4 -c:v libx264 -preset veryfast -crf 23 -c:a aac r/"${i%.*}-r.mp4"
done

echo "Processing complete. PRO TIP: Run 'ffmpeg-transform-c3322-file.sh' to process only one video file!"
