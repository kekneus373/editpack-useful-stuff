#!/usr/bin/env bash

# Enter working directory
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Prompt the user for input
echo "Enter the input video file name + extension: "; read input_file

echo "Choose aspect ratio:"
select profile in "16:9 - HD 720p" "9:16 - HD 720p" "16:9 - DVD 576p" "9:16 - DVD 576p"; do
    case $REPLY in
        1) s="1280x720"; a="16:9"; break ;;
        2) s="720x1280"; a="9:16"; break ;;
        3) s="1024x576"; a="16:9"; break ;;
        4) s="576x1024"; a="9:16"; break ;;
        *) echo "Invalid option." ;;
    esac
done

# Ask about which codec to use
echo "Choose audio codec:"
select profile in "AAC - best for videos" "MP3 - very flexible"; do
    case $REPLY in
        1) c=aac; break ;;
        2) c=mp3; break ;;
        *) echo "Invalid option. Please choose 1 or 2." ;;
    esac
done

read -p "Set the video bitrate (e.g. 2M): " bv
read -p "Set the audio bitrate (e.g. 128k): " ba
read -p "Set the audio sample rate (e.g. 44100): " ar

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libx264 -b:v "$bv" -s "$s" -aspect "$a" -preset veryfast -r 25 -c:a "$c" -b:a "$ba" -ar "$ar" "${input_file%.*}-c.mp4"

echo "================ Processing complete ================"
