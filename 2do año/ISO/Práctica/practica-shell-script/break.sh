#!/bin/bash
i=0
#True es un comando que siempre retorta verdadero
while true
do
  let i++ #incrementa i en 1
  if [ $i -eq 6 ]; then
    break #Corta el loop (while)
  fi
  echo $i
done
