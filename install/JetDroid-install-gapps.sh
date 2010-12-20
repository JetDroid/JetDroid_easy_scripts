#/bin/bash

GAppsArchive=gapps-passion-EPE54B-signed.zip
GAppsURL=http://cyanogenmod-mirror.local.host.name/gapps/gapps-passion-EPE54B-signed.zip

#check if we are in the right working directory
if [ -f JetDroid-install-gapps.sh ]; then 
cd ..
fi 

#check if we need to fetch the gapps package
if !([ -f install/$GAppsArchive ]); then
{ 
  echo "GApps archive not found. Trying to download it ..."
  cd install
  wget $GAppsURL
  cd ..
}
fi 

if [ -f install/$GAppsArchive ]; then
{ 
  echo "Unpacking GApps archive ..."
  mkdir install/gapps-inst
  cd install/gapps-inst 
  unzip ../$GAppsArchive
  chown -R 1000.1000 *
  cp -R system/* ../../system
  rm ../../system/app/GoogleSearch.apk
  rm ../../system/app/LatinIME.apk
  #rm ../../system/app/Provision.apk
  cd ../..
  rm -rf install/gapps-inst 
  echo "GApps installation complete"
}
else
{
  echo "ERROR: GApps archive not found"
}
fi
