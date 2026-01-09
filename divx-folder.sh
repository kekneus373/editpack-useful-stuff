#!/usr/bin/env bash

echo "Full path of working directory: "; read dir
cd "$dir" || { echo "No such directory"; exit 1; }

mkdir -p divx
logfile="divx/skipped-`date +%Y%m%d-%H%M%S`.log"

read -p "Source files extension (e.g. mkv): " extin
read -p "Target video bitrate (e.g. 2000k or 2M): " bv

echo "
Choose target DVD mode
1) PAL 16:9
2) PAL 4:3
3) PAL 16:9  ⟵ convert vertical (9:16) clips and crop bars
"
read -rp "Your choice: " mode

case $mode in
  1) target_ar="16:9" ; want="widescreen" ;;
  2) target_ar="4:3"  ; want="academy"    ;;
  3) target_ar="16:9" ; want="vertical"   ;;
  *) echo "Invalid choice"; exit 1 ;;
esac

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

  # ------------ STEP 4 : build filter chain --------------------
  vf=""
  if [[ $type == "vertical" ]]; then
      # Rotate 90° clockwise, crop away top/bottom bars if present
      # then scale to 720×576 (will be stretched to 16:9 by DAR)
      vf="scale=-1:576,pad=720:576:(ow-iw)/2:(oh-ih)/2"
  else
      # Normal landscape clip: just scale; keep SAR 64/45 for 16:9, 16/15 for 4:3
      if [[ $target_ar == "16:9" ]]; then
          vf="scale=720:576,setsar=64/45"
      else
          vf="scale=720:576,setsar=16/15"
      fi
  fi

  # ------------ STEP 5 : encode --------------------------------
  ffmpeg -i "$f" -vf "$vf" \
         -c:v libxvid -b:v "$bv" -r 25 -aspect "$target_ar" \
         -c:a mp3 -b:a 192k \
         "divx/${f%.*}.avi"
done

echo "================ Processing complete ================"
