#!/bin/sh

HELP='This script fetches the definition of a word from dictionary.com'
WORD="$1"
URL="https://www.dictionary.com/browse/$WORD"


if [ "$#" -eq 0 ] || [ "$1" = "-h" ]; then
  echo "$HELP"
  exit 1
elif [ "$#" -gt 1 ]; then
  echo "$HELP"
  echo "Please Enter only One word to serach"
  exit 1
fi

CONTENT=$(curl -s "$URL" | grep -o '<div class="_bzA3f8_vqmJSIKsgOar">.*</div>' | head -n 1 | sed 's/<[^>]*>//g')

if [ -z "$CONTENT" ]; then
    echo "Definition of \"$1\" is not found.."
    echo "Make sure your spelling is correct!"
else
 
  echo $CONTENT| sed 's/\./\.\n/g' | head -n 2   
fi
