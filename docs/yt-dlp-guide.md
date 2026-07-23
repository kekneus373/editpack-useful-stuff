# Download YT clips for tuff edits 💀🥀✌

```bash
yt-dlp -f bestaudio -x --audio-format opus --download-sections "*0:00:00-0:04:55" "<URL>" -o "<OUTPUT>"
```

**Important:** Before running this command, ensure you have `yt-dlp` installed on your system.

**What does the command do?**
This command uses `yt-dlp` to download a video from a YouTube URL, extracting only the best available audio in OPUS format, within a specific time range, and saving the file to a specified output path.

**Let's dissect the command:**

1. `yt-dlp`: This is the command-line tool used for downloading videos from YouTube.
2. `--output`: specifies the output format, but it is not used in this command. Instead, the `-o` option is used to specify the output file.
3. `-x`: This option extracts audio from the video.
4. `--audio-format opus`: This option specifies the output audio format. In this case, only the OPUS format is used.
5. `--download-sections "*0:00:00-0:04:55"`: This option specifies a time range within which the video should be downloaded. The `*` wildcard matches the entire duration of the video, and the two timestamps (`0:00:00` and `0:04:55`) define the desired time range (0:04:55 seconds into the video).
6. `<URL>`: This is the actual YouTube video URL to download from.
7. `<OUTPUT>`: This is the local file path where the downloaded file will be saved.

**Note:** When using this command, be aware that it might be against YouTube's terms of service. Always make sure to respect copyright laws and only download content you are entitled to.
