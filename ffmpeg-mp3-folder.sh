#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p mp3
read -p "Specify the source files extension (e.g. webm): " extin
read -p "Set the audio bitrate (e.g. 128k): " ba
# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -c:a mp3 -b:a "$ba" mp3/"${i%.*}.mp3"; done

echo "Processing complete. PRO TIP: Use 'ffmpeg-mp3-file.sh' to process only one audio file!"
