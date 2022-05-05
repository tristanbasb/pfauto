#!bin/bash

d=$(date +%Y-%m-%d-%H)

ligne=1
id=`sed -n $ligne'p' /save/iddossier`


/save/gdrive upload -p "$id" /save/conf_backup/config-"$d".xml