#!bin/bash

#Création d'un dossier save
mkdir /save

cd /save



####gdrive####
#Installation de gdrive qui permet d'upload et de télécharger de linux vers google drive
wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz >/dev/null 2>&1

#Décompresse gdrive
tar -xvf gdrive_2.1.1_linux_386.tar.gz >/dev/null 2>&1

#Supprime le fichier compresser de gdrive
rm -r gdrive_2.1.1_linux_386.tar.gz



####pfmotion_curl.sh####
#Intallation de pfmotion_curl.sh qui permet de créer une backup de pfsense
git clone https://github.com/blogmotion/bm-backup-pfsense.git >/dev/null 2>&1

#Copie colle le fichier pfmotion_curl.sh
cp /save/bm-backup-pfsense/pfmotion_curl.sh /save/pfmotion_curl.sh

#Supprime le fichier bm-backup-pfsense
rm -r /save/bm-backup-pfsense

#Installation de curl
apt install curl -y >/dev/null 2>&1

#Création d'un dossier conf_backup pour mettre les backup
mkdir /save/conf_backup



####Initialisation####

#Informe l'utilisateur
echo "Veuillez copier le lien en dessous et le coller dans votre naviguateur. Ensuite utilisez votre compte et autoriser l'utilisatation, une fois que c'est fait copier le code d'autorisation"

#Permet de récuperer les informations du compte google de l'utilisateur
./save/gdrive about

echo "Veuillez maintenant renseigner l'addresse ip de votre pfsense :"

####autogdrive####
#Copie colle autogdrive.sh vers /save/
cp ./test/autogdrive.sh /save/autogdrive.sh


####crontab####
#Supprime le cron existant
crontab -l > moncron

#Permet de mettre la ligne suivante dans le cron
echo 
"0 10 * * * /save/pfmotion_curl.sh
 0 15 * * * /save/autogdrive.sh
" >> moncron

#Installer un nouveau fichier moncron 
crontab moncron

#Supprime le fichier moncron
rm moncron