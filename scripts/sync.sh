#!/bin/bash

# Use this to quickly sync onedrive and google drive
echo 'Sycing local changes to remotes'
rclone sync ~/OneDrive/ onedrive:
rclone sync ~/GoogleDrive/ googledrive:
echo 'Sycing remotes to local dirs'
rclone sync onedrive: ~/OneDrive/
rclone sync googledrive: ~/GoogleDrive/
echo 'done'
