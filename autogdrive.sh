#!bin/bash

d=$(date +%Y-%m-%d-%H)
echo "$d"
ligne=1
id=`sed -n $ligne'p' /save/iddossier`
echo "$id"

#/save/gdrive upload