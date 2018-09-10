#!/bin/bash

# Use this to quickly sync onedrive and google drive
# AUTOMATION:    
# This script can be run at regular time intervals by modifying
# /etc/crontab file. See 'man crontab' for instructions

# cd into parent dir, write log
parentDir=$HOME'/dotfiles/scripts/'
printf 'cd-ing to %s\n' $parentDir
cd $parentDir
printf 'sync.sh - actioned %s\n' $(date +'%Y%m%H%M') &>> sync.log

# check for changes
echo 'Checking for local changes since the last sync...'
lastchange_one=$(find ~/OneDrive/ -printf '%TY%Tm%Td%TH%TM\n' | sort -nr | head -n 1)
lastchange_dri=$(find ~/GoogleDrive/ -printf '%TY%Tm%Td%TH%TM\n' | sort -nr | head -n 1)
lastsync=0
if [ -f last_synced ]; then
    lastsync=$(cat last_synced)
fi
printf 'Last change ~/OneDrive at %s, Last change ~/GoogleDrive %s, Last sync %s\n' $lastchange_one $lastchange_dri $lastsync

# sync local changes to remotes
if ((lastchange_one > lastsync)); then
    echo 'Syncing ~/OneDrive to remote'
    rclone --log-file=sync.log sync ~/OneDrive/ onedrive:
    echo '~/OneDrive synced to remote' &>> sync.log
    date +'%Y%m%d%H%M' > last_synced
fi

if ((lastchange_dri > lastsync)); then
    echo 'Syncing ~/GoogleDrive to remote'
    rclone sync --log-file=sync.log ~/GoogleDrive/ googledrive:
    echo '~/GoogleDrive synced to remote' &>> sync.log
    date +'%Y%m%d%H%M' > last_synced
fi

#sync remotes to local dirs
echo 'Syncing remote to ~/OneDrive'
rclone sync --log-file=sync.log onedrive: ~/OneDrive/
echo 'Syncing remote to ~/GoogleDrive'
rclone sync --log-file=sync.log googledrive: ~/GoogleDrive/
echo 'remotes synced to ~/OneDrive and ~/GoogleDrive' &>> sync.log

printf 'cd-ing back to '
cd -
echo 'done'
