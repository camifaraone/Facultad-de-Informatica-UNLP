#!/bin/bash

arreglo=(10 3 5 7 9 3 5 4)
resultado=1
for ((i=0; i<${#arreglo[*]}; i++))
do
  resultado=$(expr $resultado \* ${arreglo[$i]})
done

echo "Productoria: $resultado"
