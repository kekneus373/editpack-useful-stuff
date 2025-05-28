#!/usr/bin/env bash

# Specify the folder containing your videos
read -p "Specify the full path of the working directory: " dir
cd "$dir"
mkdir -p compressed
mkdir -p divx
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Set video bitrate for compression (e.g. 2M): " bv1
read -p "Set video bitrate for conversion (e.g. 2M): " bv2
echo "================= Compressing videos... ================="

# Loop through each file in the folder
for i in *."$extin"; do
    # Use ffprobe to get video stream information
    aspect_ratio=$(ffprobe -v error -select_streams v:0 -show_entries stream=display_aspect_ratio -of default=noprint_wrappers=1:nokey=1 "$i" 2>/dev/null)

    # Convert aspect ratio to float if it's in ratio format
    if [[ $aspect_ratio == *":"* ]]; then
        IFS=':' read -r num den <<< "$aspect_ratio"
        aspect_ratio=$(echo "scale=4; $num/$den" | bc)
    fi

    # Check if aspect ratio is approximately 16:9 (1.777...)
    if [ -n "$aspect_ratio" ] && [ "$(echo "$aspect_ratio >= 1.76 && $aspect_ratio <= 1.78" | bc)" -eq 1 ]; then
        ffmpeg -i "$i" -c:v libx264 -b:v "$bv1" -s 1280x720 -aspect 16:9 -preset veryfast -r 25 -c:a mp3 -b:a 128k compressed/"${i%.*}.mp4" # compress
    fi
done

echo "================= Done! Converting to DivX... ================="

for i in *."$extin"; do
    # Use ffprobe to get video stream information
    aspect_ratio=$(ffprobe -v error -select_streams v:0 -show_entries stream=display_aspect_ratio -of default=noprint_wrappers=1:nokey=1 "$i" 2>/dev/null)

    # Convert aspect ratio to float if it's in ratio format
    if [[ $aspect_ratio == *":"* ]]; then
        IFS=':' read -r num den <<< "$aspect_ratio"
        aspect_ratio=$(echo "scale=4; $num/$den" | bc)
    fi

    # Check if aspect ratio is approximately 16:9 (1.777...)
    if [ -n "$aspect_ratio" ] && [ "$(echo "$aspect_ratio >= 1.76 && $aspect_ratio <= 1.78" | bc)" -eq 1 ]; then
        ffmpeg -i "$i" -c:v libxvid -b:v "$bv2" -s 720x576 -aspect 16:9 -r 25 -c:a mp3 -b:a 192k divx/"${i%.*}.avi" # divx
    fi
done

echo "Processing complete. PRO TIP: Use 'ffmpeg-compress-divx-file-<aspect rario>.sh' to process only one video file!"
