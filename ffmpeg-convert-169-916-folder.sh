#!/bin/bash

# Change the directory where videos for processing are stored
cd /home/bogdan/Videos/sh/
# Run ffmpeg command to take the action for every file there
for i in *.mp4; do ffmpeg -i "$i" -vf "pad=iw:2*trunc(iw*16/18):(ow-iw)/2:(oh-ih)/2,setsar=1" -c:a copy "${i%.*}-sh.mp4"; done

echo "Processing complete. PRO TIP: Use 'ffmpeg-convert-169-916-file.sh' to process only one video file!"
