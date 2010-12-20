#/bin/bash

JetPlatform=JetPlatform-0.3pre1-binary.tgz
JetPlatformURL=http://jetdroid.googlecode.com/files/JetPlatform-0.3pre1-binary.tgz
JetKernel=JetKernel-0.3pre3-binary.tgz

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
  wget $JetPlatformURL
  cd ..
}
fi

# install JetPlatform files
if [ -f install/$JetPlatform ]; then 
{
  echo "Installing files from JetPlatform archive (install/$JetPlatform)"
  tar xzf install/$JetPlatform
}
else
{
  echo "ERROR: JetPlatform archive (install/$JetPlatform) not found"
  exit -1
}
fi 

# install JetKernel files
if [ -f install/$JetKernel ]; then 
{
  echo "Installing files from JetKernel archive (install/$JetKernel)"
  tar xzf install/$JetKernel
}
else
{
  echo "ERROR: JetKernel archive (install/$JetKernel) not found"
  exit -1
}
fi 

echo "Changing ownership of all files to root"
chown -R root.root *

echo "JetDroid installation completed"
echo

read -p "Do you want to install Google Apps now (y/n) "
if [ "$REPLY" == "y" ]; then 
{
  bash install/JetDroid-install-gapps.sh
}
fi
