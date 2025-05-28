# If the video is 176x144 4:3 (check by running `ffprobe -i input.mp4`):

ffmpeg -i input.mp4 -vf "transpose=1,scale=144:176" -aspect 3:4 -c:v libx264 -preset veryfast -crf 23 -c:a copy output.mp4
