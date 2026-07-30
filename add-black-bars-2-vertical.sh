#!/usr/bin/env bash

# Ask user for working directory and go there
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Ask for input file extension (e.g., webm, mp4)
read -p "Specify the source files extension (e.g. webm): " extin

# Create output directory
mkdir -p out

# Loop through all video files
for video in *."$extin"; do
    # Skip if not a file
    [ -f "$video" ] || continue

    # Get filename without path
    filename=$(basename "$video")

    # Output file path
    output="out/${filename%.*}_16-9.${filename##*.}"

    # FFmpeg command: scale to 16:9 with black bars
    # For 9:16 (height:width), we maintain height and add width with letterboxing
    ffmpeg -i "$video" \
        -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2:black" \
        -c:a aac \
        "$output"

    echo "Converted: $filename → $output"
done

echo "All videos converted!"
