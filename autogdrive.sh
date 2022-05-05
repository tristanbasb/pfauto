#!bin/bash

#Permet de récuperer la date et la mettre dans un variable
d=$(date +%Y-%m-%d-%H)

#Permet de récuperer la premiere ligne du fichier iddossier
ligne=1
id=`sed -n $ligne'p' /save/iddossier`

#Upload le backup vers le dossier parent sur google drive
/save/gdrive upload -p "$id" /save/conf_backup/config-"$d".xml