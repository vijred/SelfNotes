#! /bin/bash

# This is sample to create an Alias as profile 
# Save this file in /etc/profile.d/, whihc will be loaded whena user logs in

if [ -x /usr/bin/id ]; then
    if [[ "`/usr/bin/id -u`" -gt 100 ]]; then
        alias myls="ls -ltr"
    fi
fi

