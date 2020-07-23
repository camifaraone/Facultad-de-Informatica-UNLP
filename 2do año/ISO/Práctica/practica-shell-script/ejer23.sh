#!/bin/bash

arreglo=(10 3 5 7 9 3 5 4)
let cantidad=0
let resultado=0

for ((i=0; i<${#arreglo[*]}; i++))
do
  resultado=$(expr ${arreglo[$i]} % 2)
  if [ $resultado == 0 ]; then
    echo "${arreglo[$i]}"
  else
    cantidad=$(expr $cantidad + 1)
  fi
done

echo "Impares: $cantidad"
