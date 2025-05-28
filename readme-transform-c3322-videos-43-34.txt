ffmpeg -i input.mp4 -vf "transpose=1,scale=144:176" -aspect 3:4 -c:v libx264 -preset veryfast -crf 23 -c:a aac output.mp4
