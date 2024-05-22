#!/bin/sh

HELP='This script fetches the definition of a word from merriam-webster.com'
WORD="$1"
URL="https://www.merriam-webster.com/dictionary/$WORD"


if [ "$#" -eq 0 ] || [ "$1" = "-h" ]; then
  echo "$HELP"
  exit 1
elif [ "$#" -gt 1 ]; then
  echo "$HELP"
  echo "Please Enter only One word to serach"
  exit 1
fi

CONTENT=$(curl -s "$URL" | grep -o '<span class="dtText">.*</span>' | sed 's/<[^>]*>//g' | head -n 3)

if [ -z "$CONTENT" ]; then
    echo "Definition of \"$1\" is not found.."
    echo "Make sure your spelling is correct!"
else
 
  echo $CONTENT
fi 
