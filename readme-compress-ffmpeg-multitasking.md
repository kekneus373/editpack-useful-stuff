```bash
ffmpeg -i input.mp4 -c:v libx264 -preset veryslow -b:v 5000k -r 25 -s 1280x720 -profile:v baseline -c:a copy -threads 1 output.mp4
ffmpeg -i input.mp4 -c:v libx264 -preset medium -b:v 5000k -r 25 -s 1280x720 -profile:v baseline -c:a copy -threads 1 output.mp4
```

Explanation:

- `-i input.mp4`: Specifies the input video file.
- `-c:v libx264`: Sets the video codec to H.264 using libx264.
- `-preset medium` or `-preset veryslow`: Specifies the encoding preset. Medium is a good balance between encoding speed and file size. Veryslow prioritizes compression efficiency over encoding speed (lower CPU usage).
- `-b:v 5000k`: Sets the target video bitrate to 10000 kbps or 5000 kbps for the high and baseline profiles, respectively.
- `-r 25`: Sets the output frame rate to 30 fps or 25 fps.
- `-s 1280x720`: Sets the output resolution to 1920x1200 or 1280x720.
- `-profile:v baseline`: Sets the H.264 profile to high or baseline for the high and baseline profiles, respectively.
- `-c:a copy`: Copies the audio stream without re-encoding.
- `-threads 1`: Limits the number of threads to 1 for encoding.

Replace `input.mp4` with the name of your input video file, and adjust the output file name and parameters according to your needs.

These commands will create two separate output files, each with different video resolutions, bitrates, and profiles, while limiting the encoding process to a single thread.
