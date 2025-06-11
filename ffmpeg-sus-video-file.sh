#!/usr/bin/env bash
# Enter working directory
read -p "Specify the full path of the working directory: " dir
cd "$dir" || { echo "Directory not found!"; exit 1; }
# Prompt the user for input
read -p "Enter the input file name + extension: " input_file
# Ask which sound profile to simulate
echo "Choose audio simulation target:"
select profile in "Nomi (8k bitrate, aka 8000)" "C3322 (16k bitrate, aka 16000)"; do
    case $REPLY in
        1) r="5"; ba="8k"; name="8000"; break ;;
        2) r="15"; ba="16k"; name="16000"; break ;;
        *) echo "Invalid option. Please choose 1 or 2." ;;
    esac
done

# Run ffmpeg command with user input
ffmpeg -i "$input_file" -c:v libx264 -vf "scale=176x144" -preset veryfast -crf 23 -r "$r" -ar 16000 -c:a aac -b:a "$ba" "${input_file%.*}-$name.mp4"


echo "Processing complete. PRO TIP: Run 'ffmpeg-sus-video-folder.sh' to save time and encode an entire folder!"
