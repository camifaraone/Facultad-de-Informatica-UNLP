#!/bin/bash
echo "Contenido del directorio:"
ls
ls | tr a-z A-Z | tr -d aA
