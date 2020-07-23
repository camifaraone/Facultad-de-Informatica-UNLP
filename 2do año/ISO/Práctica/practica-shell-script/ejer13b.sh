#!/bin/bash
select opcion in Listar DondeEstoy QuienEsta Salir
do
  case $opcion in
    "Listar")
      ls
    ;;
    "DondeEstoy")
      pwd
    ;;
    "QuienEsta")
      who
    ;;
    "Salir")
      exit 0
    ;;
    esac
done
