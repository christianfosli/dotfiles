#!/bin/bash

# Use this to quickly sync onedrive and google drive
# AUTOMATION:    
# This script can be run at regular time intervals by modifying
# /etc/crontab file. See 'man crontab' for instructions

echo 'Syncing local changes to remotes'
rclone sync ~/OneDrive/ onedrive:
rclone sync ~/GoogleDrive/ googledrive:

echo 'Syncing remotes to local dirs'
rclone sync onedrive: ~/OneDrive/
rclone sync googledrive: ~/GoogleDrive/

printf 'Sync completet at %s\n' $(date -Iminutes)
