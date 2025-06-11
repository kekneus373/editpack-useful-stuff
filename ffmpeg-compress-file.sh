#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Prompt the user for input
read -p "Enter the input video file name + extension: " input_file
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
read -p "Set the video bitrate (e.g. 2M): " bv
read -p "Set the audio bitrate (e.g. 128k): " ba
# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libx264 -b:v "$bv" -s "$s" -aspect "$a" -preset veryfast -r 25 -c:a mp3 -b:a "$ba" "${input_file%.*}-c.mp4" # compress

echo "Processing complete. PRO TIP: Run 'ffmpeg-compress-folder-<aspect ratio>-safe.sh' to save time and encode entire folder!"
