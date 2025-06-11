#!/bin/bash
# Prompt the user for input
read -p "Specify the source videos extension (e.g. mkv): " extin
read -p "Enter the video bitrate (e.g. 1500k, 8M): " bv
# Create directory for output
mkdir -p ok
# Set the input extension and output extension
extout="stabilized.mp4"
# Loop over all files with the given input extension
for i in *."$extin"; do
    # Remove any existing transforms.trf file
    rm transforms.trf
    # Run the vidstabdetect filter on the current file
    ffmpeg -i "$i" -an -vf vidstabdetect=shakiness=7 -f null -
    # Generate the output filename by replacing the input extension with the output extension
    output="ok/${i%.$extin}-$extout"
    # Run the vidstabtransform filter on the current file and save the stabilized video
    ffmpeg -i "$i" -c:v libx264 -an -b:v "$bv" -vf vidstabtransform=smoothing=30:zoom=5:input="transforms.trf" "$output"
done
echo "Processing complete, the videos are in 'ok' folder. PRO TIP: Use 'ffmpeg-vidstab-file.sh' to process only one video file!"
