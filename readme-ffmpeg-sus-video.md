# C3322

`ffmpeg -i input.mp4 -c:v libx264 -vf "scale=176x144" -preset veryfast -crf 23 -r 15 -c:a aac -b:a 16k -ar 16000 output.mp4`

# NOMI

`ffmpeg -i input.mp4 -c:v libx264 -vf "scale=176x144" -preset veryfast -crf 23 -r 5 -c:a aac -b:a 8k -ar 16000 output.mp4`

