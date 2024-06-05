#!/bin/bash

# Variables
DIR="/absolute path to source directory"
BACKUP_DIR="/absolute path to destination directory"
CLOUD_STORAGE="s3://your_aws_s3_bucket_name"
ADMIN_EMAIL="youremail@email.com"

# Perform backup using rsync
rsync -av --delete $DIR/ $BACKUP_DIR/

# Compress & archive backed up (destination) directory
tar -czf "$BACKUP_DIR.tar.gz" $BACKUP_DIR/

# Encrypt backed up (destination) directory
gpg -c --cipher-algo blowfish -o "$BACKUP_DIR.tar.gz.gpg" "$BACKUP_DIR.tar.gz"

# Upload encrypted backup to AWS S3 bucket
aws s3 cp "$BACKUP_DIR.tar.gz.gpg" $CLOUD_STORAGE

# Notify in the event of failure
if [ $? -ne 0 ]; then
    echo "Full backup failed" | mail -s "Backup Failure" $ADMIN_EMAIL
fi
