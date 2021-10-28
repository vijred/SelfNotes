VirtualBox - One of the VM Types 
-------------------------------
https://www.virtualbox.org/wiki/Downloads is one of the easiest way to start intalling a VM on a laptop. 

Prebuilt images can be downloaded from https://www.osboxes.org/ -> Example, https://www.osboxes.org/centos/#centos-1908-info



* How to configure Network on these VMs 
    -   Good reference - https://www.nakivo.com/blog/virtualbox-network-setting-guide/ 
    -   Bottom line: One of the options is to configure 2 netowrks. 
        -   NAT configuration to communicate between the machine/laptop and VM, Seocnd network to be Host Only virtual netowrk that can be configured to communicate between multiple VMs. (Note: NAT configuration needs port forwardning, get the IP from the Server)