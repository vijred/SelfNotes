
Dataiku - How to 
=============================

What Needs to be installed 
-----------------
* Setup Network
* Create User Manager Identity
* User ARM Tempaltes to build Fleet Manager
* User and retain Certificate to login to the Servers (admin is default pw and centos is default login and use same PW)
* Confgure License on Fleet Manager (Need to re-provision the designer nodes after updating the license)
* Configure Tempaltes on Fleet Manager and deploy the Designer Node 


Additional configurations 
------------------------

* How to install a driver (MSSQL Driver)
```
## Download the driver 
curl -L -o mssql-jdbc.tar.gz "https://go.microsoft.com/fwlink/?linkid=2338543"

## Unzip the driver 
tar xzf mssql-jdbc.tar.gz

## Find the location of the driver 
ps -ef | grep dataiku
ps -ef | grep dss

# Typical location on a DSS Node
cd /data/dataiku/dss_data

## Copy the driver file to desired location 
sudo cp /home/centos/sqljdbc_13.2/enu/jars/mssql-jdbc-13.2.1.jre11.jar     /data/dataiku/dss_data/lib/jdbc/

## Restart dss node (UI is best)
```
