# Bash_Scripts
## Automated scripts created with the Bash scripting language  
- weather.sh: returns weather forecast for a specified location  
    - You must have 'curl' installed on your system `$ sudo apt install curl`   
    - Run script with -h / --help option to see help page OR -l <location> / --location <location> to see weather report of specified location. E.g:  
      `$ ./weather.sh -h`  or `$ ./weather.sh --help` >> to see help page  
      `$ ./weather.sh -l new-york`  or  `$ ./weather.sh --location new-york` >> to see weather forecast for new-york   
- postgreSQL-install.sh: installs & configures postgreSQL on Debian 11 distro  
- new_user_account_(interactive): prompts user for details and creates a new user account  
- backup_script: a simple script that backs up a specified directory and sends an email notification in the event of a failure  
    - Replace the values of BACKUP_SRC and EMAIL_RECIPIENT with your desired source directory and a valid email address respectively  
    - To be able to send emails from your Linux server, you must install & configure the appropriate packages. Check out my [blogpost](https://medium.com/@anyagaladima_62348/integrate-gmail-with-an-ubuntu-server-by-lilian-galadima-4874356d406a) on how to integrate Gmail on an Ubuntu server
- monitor_system.sh: along with a cron job, this scripts monitors/tracks and logs the health & performance of an ubuntu system. It sets thresholds for CPU, memory, disk, I/O, plus network usage, and sends an email to the administrator if any of these thresholds are breached
  
- cloud_based_backup.sh: backs up a specified directory using rsync. Archives, encrypts and copies backup to pre-existing S3 bucket via the AWS CLI
  - You will be required to enter a passphrase to secure your encryption    
  - To download and decrypt the file from s3:  
    - `$ mkdir s3-downloads` >> create a dedicated directory to store downloads  
    - `$ aws s3 cp s3://S3_bucket_name/backup_filename.tar.gz.gpg ~/s3-downloads/` >> to download using aws cli
    - `$ cd s3-downloads/`    
    - `$ gpg -o backup_filename.tar.gz -d backup_filename.tar.gz.gpg` >> to decrypt file. Enter previous passphrase to authenticate    
