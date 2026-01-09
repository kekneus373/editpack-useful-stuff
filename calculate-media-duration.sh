#!/usr/bin/env bash

# Prompt user for the folder path
echo "Full path of working directory: "; read dir
cd "$dir" || { echo "Invalid folder path!"; exit 1; }

# Prompt the user to write the output to a file
read -p "Log media duration to a file? (y/N): " yn

# Default to "N" if the user just presses Enter
yn=${yn:-N}

# Check the user's response
if [ "$yn" == "y" ] || [ "$yn" == "Y" ]; then
    timestamp=$(date +%Y%m%d-%H%M%S)
    txt="duration-$timestamp.txt"
else
    txt=/dev/null
fi

# Initialize total duration in seconds
total_duration=0

# Loop through all media files in the folder
for file in *; do
    if [[ -f "$file" ]]; then
        # Get the duration of the file in seconds using ffprobe
        duration=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of csv=p=0 "$file" 2>/dev/null)
	echo "$file: $(echo "$duration / 3600" | bc) hours, $(echo "($duration % 3600) / 60" | bc) minutes, $(printf "%.0f" "$(echo "$duration % 60" | bc)") seconds" | tee -a "$txt"
        
        # If duration is valid, add it to the total
        if [[ $duration =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            total_duration=$(echo "$total_duration + $duration" | bc)
        else
            echo "Skipping file: $file (not a valid media file)"
        fi
    fi
done

# Convert total duration to hours, minutes, and seconds
hours=$(echo "$total_duration / 3600" | bc)
minutes=$(echo "($total_duration % 3600) / 60" | bc)
seconds=$(printf "%.0f" "$(echo "$total_duration % 60" | bc)")

# Output the total duration
echo "Total duration of media files in the folder: ${hours}h ${minutes}m ${seconds}s" | tee -a "$txt"
