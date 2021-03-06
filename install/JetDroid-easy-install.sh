#/bin/bash

JetPlatform=JetDroid-JetPlatform_binary-0.5pre1-0-g646fad1.tar.gz
JetPlatformURL=https://github.com/JetDroid/JetPlatform_binary/tarball/0.5pre1
JetPlatfromDir=JetDroid-JetPlatform_binary-646fad1

#check if we are in the right working directory
if [ -f JetDroid-easy-install.sh ]; then 
cd ..
fi 
#echo "PWD: $(pwd)"
echo
echo "****************************************"
echo "*   Welcome to JetDroid easy install   *"
echo "****************************************"
echo

if [ -d system ]; then
{
  echo "An old system has been detected."
  echo
  echo "It is recommended to remove all files from"
  echo "previous installations before installing JetDroid."
  echo

  read -p "Do you want to clean up your old system? (y/n) "
  if [ "$REPLY" == "y" ]; then 
  {
    # cleanup

    read -p "Should a backup of you old installation be created ? (y/n) "
    if [ "$REPLY" == "y" ]; then 
    {
      # backup
      if !([ -d install/backup ]); then
      {
	echo "creating directory $(pwd)/install/backup for backups"
        mkdir install/backup
      }
      fi

      bash install/JetDroid-backup.sh $(pwd)/install/backup/JetDroid-backup-$(date +%Y%m%d.%s).tgz
      echo
      echo "Backup written to $(pwd)/install/backup/JetDroid-backup-$(date +%Y%m%d.%s).tgz"
    }
    fi 

    bash install/JetDroid-cleanup.sh
  }
  else
  {
    echo
    echo "Be warned that without proper clenup JetDroid may not be working properly"
  }
  fi 
}
fi # if [ -d system ]

echo

if !([ -f install/$JetPlatform ]); then 
{
  echo "JetPlatform file does not exist. Trying to download it ..."
  echo
  cd install
  wget --no-check-certificate -O $JetPlatform $JetPlatformURL 
  cd ..
}
fi

# install JetPlatform files
if [ -f install/$JetPlatform ]; then 
{
  echo "Installing files from JetPlatform archive (install/$JetPlatform)"
  tar xzf install/$JetPlatform
  cp -R $JetPlatfromDir/* ./
  rm -rf $JetPlatfromDir
}
else
{
  echo "ERROR: JetPlatform archive (install/$JetPlatform) not found"
  exit -1
}
fi 


# Permissions and last minute fixes
echo "Changing ownership of all files to root.root"
chown -R root.root *
echo "Changing ownership of /data files to 1000.1000"
chown -R 1000.1000 data
echo "Creating /dev/console with permissions 777"
sudo mkdir dev
sudo mknod dev/console c 5 1
sudo chmod 777 dev/console


echo "JetDroid installation completed"
echo

read -p "Do you want to install Google Apps now (y/n) "
if [ "$REPLY" == "y" ]; then 
{
  bash install/JetDroid-install-gapps.sh
}
fi
