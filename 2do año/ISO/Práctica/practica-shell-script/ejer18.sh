#!/bin/bash
while true; do
  if [ "$1" == "$( who |grep $1 |cut -d" " -f1 )" ]; then
    echo "El usuario $1 está logueado"
    break;
  fi
  echo "Buscando usuario..."
  sleep 10
done
exit 0
