#!/bin/bash
if [[ $# -gt 0 ]]
then
  num=1
  for ruta in $*
  do
    if [[ $(expr $num % 2) -eq 1 ]]
    then
      if [[ -f $ruta ]]
      then
        echo "Es un fichero"
      elif [[ -d $ruta ]]
      then
        echo "Es un directorio"
      fi
    fi
    let num++
  done
else
  echo "No se ha recibido ningún parametro"
fi
$*
