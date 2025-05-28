#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p divx
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Set video bitrate (e.g. 2M): " bv
# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -c:v libxvid -b:v "$bv" -s 576x720 -aspect 9:16 -r 25 -c:a mp3 -b:a 192k divx/"${i%.*}.avi"; done

echo "Processing complete. PRO TIP: Use 'ffmpeg-divx-file-9-16.sh' to process only one video file!"
