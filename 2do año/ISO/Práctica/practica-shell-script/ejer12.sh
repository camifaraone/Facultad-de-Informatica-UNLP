#!/bin/bash
echo "Ingrese un numero"
read n1
echo "Ingrese otro numero"
read n2
echo "Suma:"
expr $n1 + $n2
echo "Resta:"
expr $n1 - $n2
echo "Producto:"
expr $n1 \* $n2
echo "Cociente:"
expr $n1 / $n2
if [ $n1 -gt $n2 ]
then
  echo "Mayor: "$n1
else
  echo "Mayor: "$n2
fi
