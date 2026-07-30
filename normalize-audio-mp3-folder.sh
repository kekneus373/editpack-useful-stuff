#!/usr/bin/env bash

# Prompt user for the folder path
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Invalid folder path!"; exit 1; }

# Create the output directory
mkdir -p normalized

for file in *; do
    # First pass (analysis)
    stats=$(ffmpeg -i "$file" -af loudnorm=I=-14:TP=-4:LRA=11:print_format=json -f null - 2>&1)
    I=$(echo "$stats" | grep -oP '(?<="input_i" : ")[^"]+')
    TP=$(echo "$stats" | grep -oP '(?<="input_tp" : ")[^"]+')
    LRA=$(echo "$stats" | grep -oP '(?<="input_lra" : ")[^"]+')
    THRESH=$(echo "$stats" | grep -oP '(?<="input_thresh" : ")[^"]+')
    OFFSET=$(echo "$stats" | grep -oP '(?<="target_offset" : ")[^"]+')

    # Second pass (apply normalization + fade)
    duration=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$file")
    fade_start=$(awk -v dur="$duration" 'BEGIN {print dur-5}')
    ffmpeg -i "$file" \
        -af "loudnorm=I=-14:TP=-4:LRA=11:measured_I=$I:measured_TP=$TP:measured_LRA=$LRA:measured_thresh=$THRESH:offset=$OFFSET,afade=t=out:st=$fade_start:d=5" \
        -codec:a libmp3lame -q:a 2 "normalized/${file%.*}.mp3"
done
