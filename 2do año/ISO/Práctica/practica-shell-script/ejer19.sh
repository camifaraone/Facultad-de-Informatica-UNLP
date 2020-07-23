#!/bin/bash
echo "MENU DE OPCIONES"
select option in $(ls) salir
do
  case $option in
    "salir")
      exit 0
    ;;
    *)
      ./$option
  esac
done
