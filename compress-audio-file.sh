#!/usr/bin/env bash

read -p "Full path of working directory: " dir
cd "$dir" || { echo "No such directory"; exit 1; }

echo "Enter the input video file name + extension: "; read input_file

# Ask about the codec to use
echo "Choose audio codec:"
select profile in "AAC - recommended for videos" "MP3 - very flexible" "WAV - clean sound" "OGG - open source"; do
    case $REPLY in
        1) c=aac; break ;;
        2) c=mp3; break ;;
        3) c=pcm_s16le; break ;;
        4) c=libvorbis; break ;;
        *) echo "Invalid option." ;;
    esac
done

read -p "Set the audio sample rate (e.g. 44100): " ar
read -p "Set the audio bitrate (e.g. 128k): " ba

# Run ffmpeg command to take action for every file there
ffmpeg -i "$input_file" -c:v copy -c:a "$c" -b:a "$ba" -ar "$ar" "${input_file%.*}-a${input_file##*.}"

echo "================ Processing complete ================"
