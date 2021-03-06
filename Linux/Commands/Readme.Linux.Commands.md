# Linux Commands


Server related commands
-----------------------
* Recent logins on a Server 
    - `last`
* Server Login/Password alternative
    -  You can generate Private and Public Key pair for Authentication, `ssh-keygen` can be used ot geenrate one, Configure Private Key on source server and Public key on Destination Server or LDAP to avoid entering Password every single time
        - [Reference-configure-ssh-keygen](https://www.redhat.com/sysadmin/configure-ssh-keygen)
        - Tip: Make sure to update the permissions of Private key that only you can access, scp can be used to topy the files to different server 
* Alias: Create an Alias
    - `alias myls="ls -ltr"`


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


Size related commands
---------------------
* Size of files `du -sk mongo*`

