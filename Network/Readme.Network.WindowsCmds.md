Windows Server Netowrk utils
============================

* First reference to commonly used commands 
    - https://vijredblog.wordpress.com/2014/03/12/network-command-utilities-ipconfig-arp-route-ping-tracert-netstat-nslookup/ 

* Find Security protocol
    - `[Net.ServicePointManager]::SecurityProtocol`
* Change a security prototype example:
    - `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
* Good debug tool
    - Wireshark

* How to capture netowrk trace
    - Open Application
    - Run Command Prompt as an Administrator
    - Run this command to start collecting the network trace- `netsh trace start persistent=yes capture=yes tracefile=c:\mmagent.etl`
    - Replicate the issue by navigating to application, repro the problem
    - One you see the error message pop up, enter the following command to stop the network trace- `Netsh trace stop`
    - Navigate to C drive on your machine and share the mmagent.etl for analysis with required team

