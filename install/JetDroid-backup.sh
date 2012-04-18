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

tar czvf $backupfile acct android.log boot cache config d data default.prop dev etc init init.goldfish.rc init.jet.rc init.rc kernel.log lib mnt proc radio recovery.rc sbin sd-ext sdcard sqlite_stmt_journals sys system ueventd* vendor xbin zImage 
