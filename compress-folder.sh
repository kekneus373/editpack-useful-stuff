#!/usr/bin/env bash

echo "Full path of working directory: "; read dir
cd "$dir" || { echo "No such directory"; exit 1; }

# Create output directory
mkdir -p compressed
timestamp=$(date +%Y%m%d-%H%M%S)
logfile="compressed/skipped-$timestamp.log"

read -p "Specify the source videos extension (e.g. mkv): " extin

echo "Choose aspect ratio:"
select profile in "16:9 - HD 720p" "9:16 - HD 720p" "16:9 - DVD 576p" "9:16 - DVD 576p" "4:3 - HD 1024x768" "4:3 - SD 800x600"; do
    case $REPLY in
        1) s="1280x720"; a="16:9"; want="widescreen"; break ;;
        2) s="720x1280"; a="9:16"; want="vertical"; break ;;
        3) s="1024x576"; a="16:9"; want="widescreen"; break ;;
        4) s="576x1024"; a="9:16"; want="vertical"; break ;;
        5) s="1024x768"; a="4:3"; want="academy"; break ;;
        6) s="800x600"; a="4:3"; want="academy"; break ;;
        *) echo "Invalid option." ;;
    esac
done

# Ask about which codec to use
echo "Choose audio codec:"
select profile in "AAC - best for videos" "MP3 - very flexible"; do
    case $REPLY in
        1) c=aac; break ;;
        2) c=mp3; break ;;
        *) echo "Invalid option. Please choose 1 or 2." ;;
    esac
done

read -p "Set the video bitrate (e.g. 2M): " bv
read -p "Set the audio bitrate (e.g. 128k): " ba
read -p "Set the audio sample rate (e.g. 44100): " ar

echo "============== Converting $want clips =============="

shopt -s nullglob
for f in *."$extin"; do
  # ------------ STEP 1 : get width, height, SAR ----------------
  read w h sar <<< "$(ffprobe -v error -select_streams v:0 \
        -show_entries stream=width,height,sample_aspect_ratio \
        -of csv=p=0 "$f" |
        awk -F',' '{ split($3,a,":"); if($3=="N/A"){a[1]=a[2]=1}; print $1,$2,a[1]":"a[2]}')"

  IFS=: read sar_n sar_d <<< "$sar"
  dar=$(bc -l <<< "scale=6; $w*$sar_n/($h*$sar_d)")

  # ------------ STEP 2 : classify clip -------------------------
  type=""   # will be "widescreen" / "academy" / "vertical"
  if   (( $(bc -l <<< "$dar >= 1.70 && $dar <= 1.80") )); then type="widescreen"
  elif (( $(bc -l <<< "$dar >= 1.29 && $dar <= 1.38") )); then type="academy"
  elif (( $(bc -l <<< "$dar > 0.54  && $dar < 0.65") ));  then type="vertical"
  else
      echo -e "================= Skipping  $f ($dar) =================" >> $logfile
      continue
  fi

  # ------------ STEP 3 : decide whether to process -------------
  if [[ $type != $want ]]; then
      echo -e "================= Skipping  $f ($type, $dar) =================\n" >> $logfile
      continue
  fi

  echo "================= Processing  $f ($type, $dar) ================="

  ffmpeg -i "$f" -c:v libx264 -b:v "$bv" -s "$s" -aspect "$a" -preset veryfast -r 25 -c:a "$c" -b:a "$ba" -ar "$ar" "compressed/${f%.*}.mp4"

done

echo "================ Processing complete ================"
