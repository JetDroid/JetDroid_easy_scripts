#/bin/bash

GAppsArchive=gapps-gb-20110828-signed.zip
GAppsURL=http://goo.im/gapps/gapps-gb-20110828-signed.zip

#check if we are in the right working directory
if [ -f JetDroid-install-gapps.sh ]; then 
cd ..
fi 

#check if we need to fetch the gapps package
if !([ -f install/$GAppsArchive ]); then
{ 
  echo "GApps archive not found. Trying to download it ..."
  cd install
  wget -O $GAppsArchive $GAppsURL
  cd ..
}
fi 

if [ -f install/$GAppsArchive ]; then
{ 
  echo "Deleting old APKs..."
  rm system/app/Books.apk 
  rm system/app/BooksPhone.apk 
  rm system/app/CarHomeLauncher.apk 
  rm system/app/CarHomeGoogle.apk 
  rm system/app/FOTAKill.apk 
  rm system/app/GenieWidget.apk 
  rm system/app/Gmail.apk 
  rm system/app/GoogleBackupTransport.apk 
  rm system/app/GoogleCalendarSyncAdapter.apk 
  rm system/app/GoogleContactsSyncAdapter.apk 
  rm system/app/GoogleFeedback.apk 
  rm system/app/GooglePartnerSetup.apk 
  rm system/app/GoogleQuickSearchBox.apk 
  rm system/app/GoogleServicesFramework.apk 
  rm system/app/googlevoice.apk 
  rm system/app/kickback.apk 
  rm system/app/LatinImeTutorial.apk 
  rm system/app/Maps.apk 
  rm system/app/MarketUpdater.apk 
  rm system/app/MediaUploader.apk 
  rm system/app/NetworkLocation.apk 
  rm system/app/OneTimeInitializer.apk 
  rm system/app/SetupWizard.apk 
  rm system/app/Provision.apk 
  rm system/app/QuickSearchBox.apk 
  rm system/app/soundback.apk 
  rm system/app/Street.apk 
  rm system/app/Talk.apk 
  rm system/app/Talk2.apk 
  rm system/app/talkback.apk 
  rm system/app/Vending.apk 
  rm system/app/VoiceSearch.apk 
  rm system/app/YouTube.apk 
  rm system/etc/permissions/com.google.android.maps.xml 
  rm system/etc/permissions/features.xml 
  rm system/framework/com.google.android.maps.jar 
  rm system/lib/libmicrobes_jni.so 
  rm system/lib/libtalk_jni.so 
  rm system/lib/libvoicesearch.so

  echo "Unpacking GApps archive ..."
  mkdir install/gapps-inst
  cd install/gapps-inst 
  unzip ../$GAppsArchive
  chown -R 1000.1000 *
  cp -R system/* ../../system
  #rm ../../system/app/GoogleSearch.apk
  #rm ../../system/app/LatinIME.apk
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
