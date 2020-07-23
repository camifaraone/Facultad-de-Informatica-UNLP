#!/bin/bash
if [ $# == 2 ]
then
  echo "Suma:"
  expr $1 + $2
  echo "Resta:"
  expr $1 - $2
  echo "Producto:"
  expr $1 \* $2
  echo "Cociente:"
  expr $1 / $2
  if [ $1 -gt $2 ]
  then
    echo "Mayor: "$1
  else
    echo "Mayor: "$2
  fi
else 
  echo "Ha ingresado menos de 2 parametros"
  exit 1
fi
