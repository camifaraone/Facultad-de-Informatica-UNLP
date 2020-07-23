#!/bin/bash
i=0
while true
do
  let i++
  if [ $i -eq 6 ]; then
    break
  elif [ $i -eq 3 ]; then
    continue
  fi
echo $i
done
