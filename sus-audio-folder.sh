#!/usr/bin/env bash

# Ask user for working directory and go there
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Directory not found!"; exit 1; }

# Ask which sound profile to simulate
echo "Choose audio simulation target:"
select profile in "Nomi (8k bitrate, aka 8000)" "C3322 (16k bitrate, aka 16000)"; do
    case $REPLY in
        1) ba="8k"; ar="16000"; opt="nomi"; name="8000"; break ;;
        2) ba="16k"; ar="16000"; opt="c3322"; name="16000"; break ;;
        *) echo "Invalid option. Please choose 1 or 2." ;;
    esac
done

# Ask for input file extension (e.g., webm, mp4)
read -p "Specify the source files extension (e.g. webm): " extin

# Create output directory
mkdir -p "$opt"

# Convert each file using selected audio profile
for i in *."$extin"; do
    ffmpeg -i "$i" -vn -ar "$ar" -b:a "$ba" $opt/"${i%.*}-$name.mp3"
done

echo "Done! Output MP3s are in the '$opt/' folder with $ba bitrate at $ar Hz."
