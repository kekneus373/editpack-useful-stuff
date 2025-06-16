
**Media File Toolbox 🎥**
==========================

A collection of scripts for working with video and audio files, including conversion, compression, rotation, and playback issue fixes.

**Table of Contents**
--------------------

* [Scripts](#scripts)
* [Quick commands, guides](#quick-commands,-guides)
* [Resources](#resources)

### Scripts
-----------

A list of available scripts:

* **ffmpeg** scripts for video and audio file manipulation:
  + Compressing and converting files:
    - `ffmpeg-compress` *- Cut down the media size by lowering the bitrate of input streams;*
    - `ffmpeg-divx` *- Encode and put your videos on a DVD disc to enjoy them on TV;*
    - `ffmpeg-mp3` *- Get MP3 from any media file.*
  + Fixing playback issues:
    - `ffmpeg-remove-music-covers` *- Make it possible to listen modern audio formats on DVD players with MP3 support;*
    - `ffmpeg-vidstab-file` (`ps1` version for Windows machines) *- Got a bad camera that hates moving? No problem: FFmpeg can stabilize it for you entirely for free.*
  + Rotating and resizing videos
     - `ffmpeg-convert-169-916` *- An ultimate tool for optimizing videos for posting on platforms like TikTok and YouTube Shorts;*
     - `ffmpeg-transform-c3322` *- Rotate wrong-tinted videos captured on the specific phone.*
* **Other** scripts for video editing and media file management:
  + Finding and processing specific file formats: `ffmpeg-find-vids`;
  + Removing unwanted metadata and effects: `ffmpeg-remove-music-covers`;
  + Just trimming (no OP editors required): `ffmpeg-trim`;
  + Distorting audio or simulating a specific quality of some devices:
    - `apply-aexciter`;
    - `ffmpeg-sus`;
  + Calculating the entire duration of media files in a particular directory: `ffmpeg-calculate-media-duration.sh`.

### Quick commands, guides
----------------

Easy copy-paste commands and guides for installing FFmpeg, downloading copyright-free music from the famous video platform and fixing specific device issues:

* `readme-ffmpeg-vistab.md` *- Set up your environment to stabilize videos. Windows included;*
* `readme-compress-ffmpeg-multitasking.md` *- Compress videos in the background and keep working without utilizing the entire CPU;*
* `readme-use-yt-dlp-to-download-music.txt` *- Use this powerful tool to download background music you need. Even cut out some track from a mix;*
* `readme-fix-kazam-screencast-audio-delay.png` *- Synchronize audio stream in a laggy screen recording made with Kazam in Kdenlive. A bit strange at first, but looking a bit closer will tell you how it's done;*
* `use-aexciter.md` *- Make audio worse and hissy, like from a bad microphone;*
* `use-pitch.md` *- Guide to pitch the voice with FFmpeg.*

### Resources
--------------

In a folder called `materials`, you'll find:
* A list of free sound effects: `get-free-sound-effects.txt`;
* A source of scary horror music, suitable for creepypastas: `get-vlad-music.txt`;
* Green background for chroma-key (I used it several times when making a Trap Nation-like music video with "live" background): `green-05ff00.jpg`;
* Light red color from default KineMaster palette: `kinemaster-red-f34451.jpg`;
* `circle.png`, `arrow-nobg.png`;
* Funny sounds from a cheap Chinese feature phone called Nomi i220: `call-ended.mp3`, `nomi-i220-call-sound.mp3`, `nomi-sms.mp3`.

Hope you'll find my collection useful. Have a nice day!
