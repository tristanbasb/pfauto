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
#Vide le terminal
clear
#Informe l'utilisateur
echo "Veuillez copier le lien en dessous et le coller dans votre naviguateur. Ensuite utilisez votre compte et autoriser l'utilisatation, une fois que c'est fait copier le code d'autorisation"
echo " "
#Permet de récuperer les informations du compte google de l'utilisateur
/save/gdrive about
echo " "



####Modification du fichier pfmotion_curl.sh####

####Changer adresse ip#####
#Informe l'utilisateur
echo "Veuillez maintenant renseigner l'addresse ip de votre pfsense :"
#Permet de récupere l'information donner par l'utilisateur
read addIp
#Permet de modifier l'adresse ip de la ligne 14 par l'adresse choisi par l'utilisateur 
sed -i '14 s/192.168.12.34/'$addIp'/' /save/pfmotion_curl.sh
echo " "

####Changer le nom d'utilisateur####
#Informe l'utilisateur
echo "Veuillez renseigner le nom de l'utilisateur que vous avez créez pour les backup :"
#Permet de récupere l'information donner par l'utilisateur
read user
#Permet de modifier le nom d'utilisateur de la ligne 17 
sed -i '17 s/admin/'$user'/' /save/pfmotion_curl.sh
echo " "

####Changer le mot de passe####
#Informe l'utilisateur
echo "Veuillez renseigner le mot de passe de l'utilisateur que vous avez créez pour les backup :"
#Permet de récupere l'information donner par l'utilisateur
read mdp
#Permet de modifier le mot de passe de la ligne 18 
sed -i '18 s/VotreMdp/'$mdp'/' /save/pfmotion_curl.sh
echo " "

####Changer le nom de sauvegarde####
sed -i '40 s/+%Y%m%d%H%M%S/+%Y-%m-%d-%H/' /save/pfmotion_curl.sh
sed -i '84 s/${hostname}_${domain}-//' /save/pfmotion_curl.sh



####Choix du dossier pour les backup de pfsense####
#Permet d'afficher la liste des fichiers et des dossiers du google drive de l'utilisateur
/save/gdrive list
#Informe l'utilisateur
echo " Veuillez séléctionner l id du dossier dans lequel vous souhaitez mettre vos backup (l id est à gauche en face du nom de votre dossier dans la liste ci-dessus):

"
#Permet de récuperer l'information donner par l'utilisateur
read id
#Création d'un fichier iddossier
touch /save/iddossier
#Permet de mettre la varible dans le fichier iddossier
echo $id >> /save/iddossier



####autogdrive####
#Copie colle autogdrive.sh vers /save/
cp /opt/test/autogdrive.sh /save/autogdrive.sh



####crontab####
#Supprime le cron existant
crontab -l > moncron
#Permet de mettre la ligne suivante dans le cron
echo "
0 10 * * * bash /save/pfmotion_curl.sh
0 15 * * * bash /save/autogdrive.sh
" >> moncron 
#Installer un nouveau fichier moncron 
crontab moncron
#Supprime le fichier moncron
rm moncron