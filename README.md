**Media File Toolbox 🎥**
==========================

🧰 A toolbox for working with media - conversion, compression, applying effects, distoring, rotation, analyzing & playback issue fixes.

**Table of Contents**
--------------------

* 📜 [Scripts](#scripts)
* 🔳 [Quick commands, guides](#quick-commands,-guides)
* 📦 [Resources](#resources)

### 📜 Scripts
-----------

* 📼 **ffmpeg** scripts for video and audio file manipulation:
  + 🗜️ Compressing and converting:
    - 🎵 `convert-audio` *- Get audio from any media file / convert between formats;*
    - 🗜️ `compress` *- Cut down your media size by lowering the input bitrate and scaling it down;*
    - 📀 `divx` *- Encode DVD-player compatible content.*
  + ⏯️ Fixing playback issues:
    - 💽 `remove-music-covers` *- Make it possible to listen modern audio formats on DVD players with MP3 support;*
    - 📳 `vidstab` (`ps1` version for Windows) *- Got a bad camera that hates moving? No problem: FFmpeg can stabilize it entirely for free. Super powerful!*
  + 🔄 Rotating and resizing:
     - 🔃 `convert-to-vertical` *- An ultimate tool for optimizing videos for platforms like TikTok and YouTube Shorts;*
     - 📱 `transform-c3322` *- Tilt videos captured on the specific phone.*
  + 📢 Distorting audio / masking it:
    - 🔊 `aexciter` → get omega hissy audio;
    - 👂 `sus-audio` & `sus-video` → get omega bad quality;
    - 🤫 `pitch` → mask in-video voice.
* ✏️ **Other** scripts for video editing and media file management:
  + 📹 Finding specific video types (logging included): `list-selected-aspect-ratio-videos.sh`;
  + 🗒️ Removing unwanted metadata: `remove-music-covers.sh`;
  + ✂️ Just trimming (w/o OP editors): `trim.sh`;
  + 🧮 Calculating the entire media duration in given directory: `calculate-media-duration.sh`;
  + 📝 Convert filenames to lowercase with hyphens for repo archival compatibility: `rename-safe-ng.sh`.

### 🔳 Quick commands, guides
----------------

📋 Easy copy-paste commands and guides for installing FFmpeg, downloading copyright-free music from the *famous video platform* and fixing device-specific issues:

* 🔩 Learn how to streamline your workflow with optimized FFmpeg configurations: `ffmpeg-compress-multitasking.md`;
* 📈 Get the most out of AEXCiter's features with my comprehensive guide: `ffmpeg-aexciter-cli.md`;
* 🎵 Understand the ins and outs of FFmpeg's pitch adjustment: `ffmpeg-pitch-cli.md`;
* 💡 Quick reference guide to FFmpeg's Q-parameter settings: `ffmpeg-q-parameter.md`;
* 🔍 Dive deep into the world of VidStab with this expert guide: `ffmpeg-vidstab-guide-cli.md`;
* 💻 Resolve audio sync issues with these easy steps: `kazam-screencast-audio-delay-fix.png`;
* 📊 Learn how to resize video frames without losing quality: `scale-video-dimensions.md`;
* 🚀 Get started with yt-dlp, the ultimate video downloader: `yt-dlp-guide.md`.

### 📦 Resources
--------------

📂 In `materials` you'll find:
* 📝 A list of free sound effects: `get-free-sound-effects.txt`;
* 😱 Sources of scary horror music, suitable for creepypastas: `get-vlad-music.txt`;
* 🟩 Green background for chroma-key: `green-05ff00.jpg`;
* 🟥 Light red color from default KineMaster palette: `kinemaster-red-f34451.jpg`;
* ➡️ Figures: `circle.png`, `arrow-nobg.png`;
* 🎬 KineMaster watermark - transparent and ready to go: `kinemaster/`;
* 🛜 Media Offline templates (funny sometimes): `*media-offline`
* 🔔 Funny sounds from a cheap Chinese feature phone (Nomi i220): `call-ended.mp3`, `nomi-i220-call-sound.mp3`, `nomi-sms.mp3`.

Hope you'll find my collection useful. Have a nice day! 👌
