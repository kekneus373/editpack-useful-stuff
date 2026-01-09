#!/usr/bin/env bash

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
echo "Enter the input video file name + extension: "; read input_file

# Ask about which codec to use
echo "Choose audio codec:"
select profile in "AAC - for MP4 videos" "MP3 - very flexible" "WAV - clean sound" "OGG - open source"; do
    case $REPLY in
        1) c=aac; o=m4a; break ;;
        2) c=mp3; o=$c; break ;;
        3) c=pcm_s16le; o=wav; break ;;
        4) c=libvorbis; o=ogg; break ;;
        *) echo "Invalid option." ;;
    esac
done

read -p "Set the audio bitrate (e.g. 128k): " ba
read -p "Set the audio sample rate (e.g. 44100): " ar

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -vn -c:a "$c" -b:a "$ba" -ar "$ar" "${input_file%.*}.$o"

echo "================ Processing complete ================"
