#!/bin/bash

#Random Password Generator
HELP='This script generates random base64 passwords of desired length'

if [ "$#" -eq 0 ] || [ "$1" = '-h' ];then
  echo "$HELP"
  echo "Please enter the length of the password"
  exit 1
elif [ "$#" -gt 2 ];then
  echo "$HELP"
  echo "Please enter the length of the password to be generated followed by the         amount of passwords if more than 1 is desired"
  exit 1
fi

PASSWORD_LENGTH=$1

if [ "$#" -eq 1 ];then
  for i in $(seq 1);
  do
    openssl rand -base64 48 | cut -c1-$PASSWORD_LENGTH
  done
  exit 1
fi

if [ "$#" -eq 2 ];then
  for i in $(seq 1 $2);
  do
    openssl rand -base64 48 | cut -c1-$PASSWORD_LENGTH
  done
  exit 1
fi
