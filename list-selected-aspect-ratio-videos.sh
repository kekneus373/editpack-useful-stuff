#!/usr/bin/env bash

# Specify the folder containing your videos
read -p "Full path of working directory: " dir
read -p "Source files extension (e.g. mkv): " extin
cd "$dir" || { echo "No such directory"; exit 1; }

timestamp=$(date +%Y%m%d-%H%M%S)
logfile="skipped-$timestamp.log"

# Prompt the user to write the output to a file
read -p "Save output to a file? (y/N): " yn

# Default to "N" if the user just presses Enter
yn=${yn:-N}

# Check the user's response
if [ "$yn" == "y" ] || [ "$yn" == "Y" ]; then
    txt="result-$timestamp.txt"
else
    txt=/dev/null
fi

echo "
Choose which clips you're interested in:
1) 16:9
2) 9:16
3) 4:3
4) 1:1
5) others
"
read -rp "Your choice: " mode

case $mode in
  1) want="widescreen" ;;
  2) want="vertical" ;;
  3) want="academy" ;;
  4) want="square" ;;
  4) want="und" ;;
  *) echo "Invalid choice"; exit 1 ;;
esac

shopt -s nullglob
echo "================ Looking for $want ================"
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
  elif (( $(bc -l <<< "$dar == 1") )); then type="square"
  else
      type="und"
      continue
  fi

  # ------------ STEP 3 : decide whether to print -------------
  if [[ $type != $want ]]; then
      echo -e "================= Skipping  $f ($type, $dar) =================\n" >> "$logfile"
      continue
  fi

  echo "$f" | tee -a "$txt"
done

echo "================ Processing complete ================"
