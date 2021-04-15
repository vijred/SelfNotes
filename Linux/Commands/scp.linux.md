Linux Command to copy files between Linux and Windows
=====================================================


* Sample to copy a file from Windows to Linux Server - Run it from Windows Server
    - Example: `scp.exe "C:\temp\\test1.ps1"  LinuxUserName@LinuxServerName:/home/userName/Location` 
* Sample to copy a file from Linux to  Windows Server - Run it from Windows Server
    - Example: `scp.exe  LinuxUserName@LinuxServerName:/home/userName/Location/*  "C:\CopyLocation"` 
* Sample to copy between 2 Linux Servers
    - `scp  SourceLinuxUesrName@Servername.msftdomain.com:/home/MyUserName/Folder/* /home/MyUserName/MyFolder/`


