Ansible
=======

* How toreplace a string on a given file 
```
  - name: Comment parameter xyzstring
    replace:
      path: /etc/mongos.conf
      regexp: 'xyzstring: "true"'
      replace: '#xyzstring: "true"'
```      

* Copy a file
```
  - name: Copy file to bkup
    copy:
      src:  /etc/mymongos.conf
      remote_src:  yes
      dest:  /etc/mymongos.conf.bkup
      backup: yes
      owner: root
      group: root
      mode: '644'
```

