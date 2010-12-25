#/bin/bash
#check if we are in the right working directory
if [ -f JetDroid-backup.sh ]; then 
cd ..
fi 

if [ -z "$1" ]; then 
  backupfile="JetDroid-backup-$(date +%Y%m%d.%s).tgz"
  echo "No output filename given. Using default filename $backupfile"
else
  backupfile=$1
fi

tar czvf $backupfile cache config d data default.prop dev etc init init.goldfish.rc init.rc proc sbin sdcard sqlite_stmt_journals sys system zImage boot/append-jet

