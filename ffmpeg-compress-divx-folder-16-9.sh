#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directories
cd "$dir"
mkdir -p compressed
mkdir -p divx
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Set video bitrate for compression (e.g. 2M): " bv1
read -p "Set video bitrate for conversion (e.g. 2M): " bv2
echo "================= Compressing videos... ================="
# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -c:v libx264 -b:v "$bv1" -s 1280x720 -aspect 16:9 -preset veryfast -r 25 -c:a mp3 -b:a 128k compressed/"${i%.*}.mp4"; done # compress
echo "================= Done! Converting to DivX... ================="
for i in *."$extin"; do ffmpeg -i "$i" -c:v libxvid -b:v "$bv2" -s 720x576 -aspect 16:9 -r 25 -c:a mp3 -b:a 192k divx/"${i%.*}.avi"; done # divx

echo "Processing complete. PRO TIP: Use 'ffmpeg-compress-divx-file-16-9.sh' to process only one video file!"
