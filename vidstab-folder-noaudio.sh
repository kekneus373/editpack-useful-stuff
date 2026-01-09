#!/usr/bin/env bash

# Prompt user for the folder path
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Invalid folder path!"; exit 1; }

# Create directory for output
mkdir -p stab

# Set the input extension and output extension
read -p "Specify the source media extension (e.g. mkv): " extin
extout="stabilized.mp4"
read -p "Enter the video bitrate (e.g. 1500k, 8M): " bv

# Loop over all files with the given input extension
for i in *."$extin"; do
    # Remove any existing transforms.trf file
    rm transforms.trf 2>&1/dev/null
    # Run the vidstabdetect filter on the current file
    ffmpeg -i "$i" -an -vf vidstabdetect=shakiness=7 -f null -
    # Generate the output filename by replacing the input extension with the output extension
    output="stab/${i%.$extin}-$extout"
    # Run the vidstabtransform filter on the current file and save the stabilized video
    ffmpeg -i "$i" -c:v libx264 -an -b:v "$bv" -vf vidstabtransform=smoothing=30:zoom=5:input="transforms.trf" "$output"
done

echo "================ Processing complete ================"
