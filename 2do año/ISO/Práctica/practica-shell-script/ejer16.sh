#!/bin/bash
for archivo in $(cat /etc/passwd | cut -d: -f1)
do
  cant=$(sudo find / -user $archivo -name *.$1 | wc -l)
  echo "$archivo $cant" >> reporte.txt
done
