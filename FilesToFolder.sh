#!/bin/bash
HELP="This bash script moves all files with the same type to a created folder named after the file extension"
INSTRUCT="Add -i after script to take action"
EXTENSIONS=$( ls $pwd | cut -d '.' -f 2 | sort | uniq )

[ -z "$1" ] && echo "$HELP" && echo "$INSTRUCT" && exit 1

if [ $1 = '-i' ];then

  for fol in $EXTENSIONS
  do
    mkdir $fol
  done

  for file in $(ls)
  do
    FILETYPE=$(echo $file | cut -d '.' -f 2)
    mv $file "${PWD}/${FILETYPE}"
  done
fi
