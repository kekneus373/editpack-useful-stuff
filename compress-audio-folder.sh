#!/usr/bin/env bash

echo "Full path of working directory: "; read dir
cd "$dir" || { echo "No such directory"; exit 1; }

# Create the output directory
mkdir -p audio

read -p "Specify the source media extension (e.g. mkv): " extin

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
for i in *."$extin"; do ffmpeg -i "$i" -c:v copy -c:a "$c" -b:a "$ba" -ar "$ar" audio/"$i"
done

echo "================ Processing complete ================"
