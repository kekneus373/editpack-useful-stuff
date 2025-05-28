# Video

NOMI: `ffmpeg -i input.mp4 -b:a 8k -ar 16000 -c:v copy output.mp4`
C3322: `ffmpeg -i input.mp4 -b:a 16k -ar 16000 -c:v copy output.mp4`

---

# Audio only

NOMI: `ffmpeg -i input.mp4 -vn -b:a 8k -ar 16000 output.mp3`
C3322: `ffmpeg -i input.mp4 -vn -b:a 16k -ar 16000 output.mp3`
