#!/bin/bash
let count=0
while true
do
 var=$(ps aux | grep apache)  #busco todos los procesos, busco apache
 if [[ -n $var ]]
 then
  let count++
  if [[ $count == 10 ]]
  then
   exit 50
  fi
 fi
sleep 1
echo "TUTU"
done
