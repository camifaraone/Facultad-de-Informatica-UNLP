#!/bin/bash
if [ $1 == "-a" ]; then
  for archivo in $(ls *)
  do
    mv $archivo $archivo$2
  done
elif [ $1 == "-b" ]; then
  for archivo in $(ls *)
  do
    mv $archivo $2$archivo
  done
fi
