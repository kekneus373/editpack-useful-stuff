#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
# Create output directory
cd "$dir"
mkdir -p re-encoded
read -p "Specify the source videos extension (e.g. mkv): " extin

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$input_file" -c:v libx264 -c:a aac "$output_file"
done

echo "Processing complete. PRO TIP: Use 'ffmpeg-re-encode-mp4-file-<aspect ratio>.sh' to process only one video file!"
