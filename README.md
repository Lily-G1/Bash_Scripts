# Bash_Scripts
## Automated scripts created with Bash  
- weather.sh: returns weather forecast for a specified location  
    - You must have 'curl' installed on your system `$ sudo apt install curl`   
    - Run script with -h / --help option to see help page OR -l <location> / --location <location> to see weather report of specified location. E.g:  
      `$ ./weather.sh -h`  or `$ ./weather.sh --help` >> to see help page  
      `$ ./weather.sh -l new-york`  or  `$ ./weather.sh --location new-york` >> to see weather forecast for new-york   
- postgreSQL-install.sh: installs & configures postgreSQL on Debian 11 distro  
- new_user_account_(interactive): prompts user for details and creates a new user account  
- backup_script: a simple script that backs up a specified directory and sends an email notification in the event of a failure  
    - Replace the values of BACKUP_SRC and EMAIL_RECIPIENT with your desired source directory and a valid email address respectively  
    - To be able to send emails from your Linux server, you must install & configure the appropriate packages. Check out this [blogpost](https://medium.com/@anyagaladima_62348/integrate-gmail-with-an-ubuntu-server-by-lilian-galadima-4874356d406a) on how to integrate Gmail on an Ubuntu server  
