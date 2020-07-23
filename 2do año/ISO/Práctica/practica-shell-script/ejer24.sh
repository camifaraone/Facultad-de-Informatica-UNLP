#!/bin/bash
arr1=(1 2 3 4 5)
arr2=(1 2 3 4 5)

for ((i=0; i<${#arr1[*]}; i++))
do
  result=$(expr ${arr1[$i]} + ${arr2[$i]})
  echo "La suma de los elementos de la posicion $i de los vectores es $result"
done

$(($RANDOM%5))
