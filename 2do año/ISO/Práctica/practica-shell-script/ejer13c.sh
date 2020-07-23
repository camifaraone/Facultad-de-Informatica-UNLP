#!/bin/bash
if [ -e $1 ]; then
  if [ -d $1 ]; then
    echo "Es un directorio"
  else
    echo "Es un archivo"
  fi
else
  mkdir $1
fi
