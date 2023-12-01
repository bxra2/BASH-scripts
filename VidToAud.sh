#!/bin/bash
HELP="This Bash script converts video to mp3 audio using ffmpeg"
INPUT="Please input the name of the video to be extracted"
EXTRAH="You can enter the name of the file followed by the outputted file name if you want it to be different from video name"

[ -z "$1" ] && echo "$HELP" && echo "$INPUT" && exit 1

if [ "$#" -gt 2 ]; then 
  echo "$HELP" ; echo "$EXTRAH" ; exit 1
fi

if [ "$1" = "-h" ]; then 
  echo "$HELP" ; echo "$INPUT" ; echo "$EXTRAH" ; exit 1
fi

FILENAME="$1"

if [ "$#" -eq 1 ]; then 
  FIR=$(echo "$FILENAME" | cut -d'.' -f1)
  EXT=".mp3"
  ffmpeg -i "$1" -q:a 0 -map a "$FIR$EXT"
fi
