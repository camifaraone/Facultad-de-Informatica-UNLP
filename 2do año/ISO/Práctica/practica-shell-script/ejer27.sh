#!/bin/bash

diml=0

inicializar(){
  vector=()
}

agregar_elem(){
  vector[${#vector[*]}]=$1
}

eliminar_en(){
  unset vector[$1]
}

longitud(){
  echo ${#vector[*]}
}

imprimir(){
  echo ${vector[*]}
}

inicializar_con_valores(){
  vector=inicializar
  for((i=0; i<$1; i++))
  do
    vector[$i]=$2
  done
}



select opcion in inicializar agregar_elem eliminar_en longitud imprimir inicializar_con_valores salir
do
  case $opcion in
    "inicializar")
      inicializar
    ;;
    "agregar_elem")
      echo "Ingrese un numero"
      read numero
      agregar_elem $numero
    ;;
    "eliminar_en")
      echo "Ingrese la posicion en la cual desea borrar"
      read numero
      eliminar_en $numero
    ;;
    "longitud")
      longitud
    ;;
    "imprimir")
      imprimir
    ;;
    "inicializar_con_valores")
      echo "Ingrese la longitud para el arreglo"
      read n1
      echo "Ingrese el valor a agregar en el arreglo"
      read valor
      inicializar_con_valores $n1 $valor
    ;;
    "salir")
      exit 0
    ;;
  esac
done


