Robocopy 
--------

* How to copy files to a different domain 
```
net use \\server1\g$ /user:domain1\user1 * 
net use \\server2\g$ /user:domain2\user2 *
robocopy \\server1\G$\testdir\%3 \\server2\g$\uploads
net use \\server1\g$ /delete
net use \\server2\g$ /delete
```
