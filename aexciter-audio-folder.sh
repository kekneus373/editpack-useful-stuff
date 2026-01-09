#!/usr/bin/env bash

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
read -p "Source files extension (e.g. mkv): " extin

# Output directory
mkdir -p distorted

# Ask about which codec to use
echo "Choose audio codec:"
select profile in "AAC - for MP4 videos" "MP3 - very flexible" "WAV - clean sound" "OGG - open source"; do
    case $REPLY in
        1) c=aac; o=m4a; break ;;
        2) c=mp3; o=mp3; break ;;
        3) c=pcm_s16le; o=wav; break ;;
        4) c=libvorbis; o=ogg; break ;;
        *) echo "Invalid option." ;;
    esac
done

read -p "Set the audio bitrate (e.g. 128k): " ba
read -p "Set the audio sample rate (e.g. 44100): " ar

# Run ffmpeg command to take the action for every file there
for i in *."$extin"; do ffmpeg -i "$i" -af "aexciter=level_in=14.464:level_out=1.984:amount=1:drive=8.5:blend=0:freq=7500:ceil=9999" -vn -c:a "$c" -b:a "$ba" -ar "$ar" distorted/"${i%.*}.$o"; done

echo "================ Processing complete ================"
