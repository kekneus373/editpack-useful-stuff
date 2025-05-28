#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p compressed
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Set video bitrate (e.g. 2M): " bv

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -c:v libx264 -b:v "$bv" -s 720x1280 -aspect 9:16 -preset veryfast -r 25 -c:a mp3 -b:a 128k compressed/"${i%.*}.mp4" # compress

echo "Processing complete. PRO TIP: Use 'ffmpeg-compress-file-<aspect ratio>.sh' to process only one video file!"
