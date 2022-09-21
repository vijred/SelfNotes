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
