# Linux Commands


Server related commands
-----------------------
* Find Server version 
    - `cat /etc/os-release`
* Recent logins on a Server 
    - `last`
* Server Login/Password alternative
    -  You can generate Private and Public Key pair for Authentication, `ssh-keygen` can be used ot geenrate one, Configure Private Key on source server and Public key on Destination Server or LDAP to avoid entering Password every single time
        - [Reference-configure-ssh-keygen](https://www.redhat.com/sysadmin/configure-ssh-keygen)
        - Tip: Make sure to update the permissions of Private key that only you can access, scp can be used to topy the files to different server 
* Alias: Create an Alias
    - `alias myls="ls -ltr"`
* Check a process running on the server
    -   `ps -ef | grep serviceinfo`
* Example to give permissions to a given user 
	-	`setfacl -R -m u:username:rwx /home/usernamexyz/foldername`

Service related commands  
------------------------
* chkconfig 
    - `chkconfig` command is used to list all available services and view or update their run level settings. In simple words it is used to list current startup information of services or any particular service
* How to list all services 
    -   `/usr/bin/systemctl --all `
* List mongo related service running 
    -   `/usr/bin/systemctl --all | grep mongo`
* Install a service
    -   mostly by the application - Example: `Application install --configfile.conf`
* Check status, start or stop  service 
```
sudo systemctl status myservice.service
sudo systemctl start myservice.service
sudo systemctl stop myservice.service
```
* How to uninstall a service - Example  
```
systemctl status mongosqld01k.service
sudo systemctl disable mongosqld01k.service
sudo rm /etc/systemd/system/mongosqld01k.service
sudo rm /usr/lib/systemd/system/mongosqld01k.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
```

* How to check logs of the service 
```
sudo journalctl -u mongosqld01k.service
```


Shell related commands
----------------------
* How to check edit mode 
```
if [[ -o emacs ]]; then
  echo emacs mode
elif [[ -o vi ]]; then
  echo vi mode
else
  echo neither
fi
```

* how to set emacs mode 
    -   `set -o emacs`

* what is default profile file 
    -   `~/.bash_profile`

* How to set default profile to bash 
    - Create a file .profile, add `/usr/bin/bash`

File related commands
---------------------
* List file permissions in Number format
    - `$ stat -c "%a %n" -- *`
    - `stat .ssh/ -c "%a %n" -- *`
* Create a directory
    - `mkdir`
* Secure  Copy of files 
    - `scp` 
* Display last few lines of a file
    - `tail filename.txt`
* Display First 10 lines of a file
    - `head -10 mongodb.log`
* Find all files wiht a given name 
    -   `sudo find / -name *mongo*`
* Change owenr of a given folder and all its files
    -   `sudo chown -R username: foldername/`


Size related commands
---------------------
* Size of files `du -sk mongo*`

* disk-free - shows available and used disk space on the Linux system.
```
# Disk free space in human readable format 
df -h 
```

powershell
--------
* how to open powershell after installing - `pwsh`

Network related commands
--------------
* IP Configuration command - `ifconfig`

How to update server name (At least a VM Name)
--------------
    -   This needs to be updated in 2 files /etc/hosts and /etc/hostname, quick ref - `sudo vi /etc/hostname` `sudo vi /etc/hosts`
    -   Option-2: `hostnamectl set-hostname mynewhostname.abcabc.org`

* How to create openssl certificate 
```
openssl req -nodes -newkey rsa:2048 -keyout test.key -out test.crt -x509 -days 365 -subj "/C=US/ST=NY/L=NY/O=TEST IT/OU=DEVOPS/CN=TEST"
cat test.crt test.key > test.pem
chown username test.pem
```

* How to unpackage .tgz file 
    -   `tar zxvf fileName.tgz`

* How to delete a user
    -   `deluser username`

* How to check installed package
    ```
    rpm -qa | grep mysql
    rpm -qi mysql-community-client-plugins-8.0.27-1.el7.x86_64
    ```

