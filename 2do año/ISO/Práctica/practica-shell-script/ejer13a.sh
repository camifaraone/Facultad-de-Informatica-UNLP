#!/bin/bash
for ((i=1; i<= 100; i++))
do
  echo "el cuadrado de $i es:"
  expr $i \* $i
done
