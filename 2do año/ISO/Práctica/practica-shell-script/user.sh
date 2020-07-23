#!/bin/bash
if [ $USER == root ]
then
  echo "Eres root"
else
  echo "Eres $USER"
fi
