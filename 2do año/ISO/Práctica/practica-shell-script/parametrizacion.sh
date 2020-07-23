#!/bin/bash

let c=$1+$2
echo "$c"
ls pistola 2>stdout
exit 2
echo "#"$#
echo "*"$*
echo "?"$?
echo "Home" $HOME
echo "?"$?
