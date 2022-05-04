#!bin/bash

#Création d'un dossier save
mkdir /save >/dev/null 2>&1

cd /save



####gdrive####
#Installation de gdrive qui permet d'upload et de télécharger de linux vers google drive
wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz >/dev/null 2>&1

#Décompresse gdrive
tar -xvf gdrive_2.1.1_linux_386.tar.gz >/dev/null 2>&1

#Supprime le fichier compresser de gdrive
rm -r gdrive_2.1.1_linux_386.tar.gz >/dev/null 2>&1



####pfmotion_curl.sh####
#Intallation de pfmotion_curl.sh qui permet de créer une backup de pfsense
git clone https://github.com/blogmotion/bm-backup-pfsense.git >/dev/null 2>&1

#Copie colle le fichier pfmotion_curl.sh
cp /save/bm-backup-pfsense/pfmotion_curl.sh /save/pfmotion_curl.sh >/dev/null 2>&1

#Supprime le fichier bm-backup-pfsense
rm -r /save/bm-backup-pfsense >/dev/null 2>&1

#Installation de curl
apt install curl -y >/dev/null 2>&1

#Création d'un dossier conf_backup pour mettre les backup
mkdir /save/conf_backup >/dev/null 2>&1

