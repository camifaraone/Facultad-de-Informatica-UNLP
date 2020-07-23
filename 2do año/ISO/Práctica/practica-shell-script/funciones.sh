#!/bin/bash
dos(){
echo $1 $2
}
uno(){
echo $1 $2
}

holaMundo(){
  echo "Hola mundo"
}

select opcion in uno dos salir hola
do
  case $opcion in
    "uno")
      echo "ingrese un numero"
      read p1
      echo "ingrese otro numero"
      read p2
      uno $p1 $p2
    ;;
    "dos")
      dos $1 $2
    ;;
    "salir")
      exit 0;
    ;;
    "hola")
      holaMundo()
    ;;
  esac
done
