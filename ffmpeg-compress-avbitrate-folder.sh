#!/usr/bin/env bash
# Enter the working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p compressed
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Set the video bitrate (e.g. 2M): " bv
read -p "Set the audio bitrate (e.g. 128k): " av

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -c:v libx264 -b:v "$bv" -preset veryfast -r 25 -c:a mp3 -b:a "$av" compressed/"${i%.*}.mp4" # compress
done

echo "Processing complete."
