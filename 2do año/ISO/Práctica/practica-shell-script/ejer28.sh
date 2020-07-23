#!/bin/bash
if [ $# -gt 0 ]
then
  cantidad=0
  if [ -d $1 ]
  then
    for archivo in $(ls $1)
    do
      if [ -f $1/$archivo ] && [ -r $1/$archivo ] && [ -w $1/$archivo ]
      then
        let cantidad++
      fi
    done
  else
    exit 4
  fi
else
  echo "Envíe un directorio como parametro"
fi
echo "$cantidad"
echo "no creo que funque"
