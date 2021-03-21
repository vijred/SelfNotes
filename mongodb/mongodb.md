MongoDB info
============


* Connect arbitor
    - `mongo --host Servername.msft.com --port 30001` 
* Connect to a mongodb Server
    - `mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username MyUserName -p --host ServerNameFQDN DBName`
```
mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username `whoami` -p --host `hostname` admin
```
* Execute a command without connecting to mongodb shell 
```
mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username `whoami` -p --host `hostname` admin --quiet --eval "rs.isMaster().primary"
```
* Add a user to specific Role
```
	MongoDB Enterprise > db.grantRolesToUser(
   "UserName",
   [
     { role: "dbAdminAnyDatabase", db: "admin" }
   ]
 )
```
* Check User Roles:
```
		MongoDB Enterprise > db.getUser("UserName")
```
* Remove a user from specific role:
```
		db.revokeRolesFromUser(
		  "UserName",
		  [
		    { role: "dbAdminAnyDatabase", db: "admin" } 
		  ]
		)
```		
		
* Verify Servers and its Primary state
```
		rs.isMaster()"
```		
		
* Verify users exists and mapped to correct roles (Sample) 
```
		use $external 
		db.getUser("mgo_username")
```
* Add a User: 
```
		use $external
		db.getSiblingDB("$external").createUser({user: "mgo_UserName",roles: [ { role: "mgo_Rolename", db: "admin"}]})
```
* Get Role info
```
    user admin; db.getRole("Rolename")
```		
* Rotate Logs
```
			db.adminCommand( { logRotate : 1 } ) -- From  https://wiki.paychex.com/pages/viewpage.action?pageId=668407173> 
```
* Command to Exit / Quit:
 ```
    exit.
```
* Failover 
```
			rs.status()
			rs.conf()
			rs.freeze(360)
			rs.stepDown()
```
* Change configuration - Reconfigure priorities
```
			cfg = rs.conf()
			cfg.members[0].priority = 0.5
			cfg.members[1].priority = 1
			rs.reconfig(cfg)
```
* Take backup of database: 
```
		mongodump --db dbName --out outFile --host "IP:PORT"  --username <user>  --password <pass>
```		
* Active Connections on database: 
```
		db.currentOp ()
```
* Active Sessions / Users on a Given server:
```
			use config
			db.system.sessions.aggregate( [  { $listSessions: { allUsers: true } } ] )
```
* Number of connections per client on mongoDB
```			db.currentOp(true).inprog.reduce((accumulator, connection) => { ipaddress = connection.client ? connection.client.split(":")[0] : "unknown"; accumulator[ipaddress] = (accumulator[ipaddress] || 0) + 1; accumulator["TOTAL_CONNECTION_COUNT"]++; return accumulator; }, { TOTAL_CONNECTION_COUNT: 0 })
			
			db.currentOp(true).inprog.reduce(
  (accumulator, connection) => {
    ipaddress = connection.client ? connection.client.split(":")[0] : "unknown";
    accumulator[ipaddress] = (accumulator[ipaddress] || 0) + 1;
    accumulator["TOTAL_CONNECTION_COUNT"]++;
    return accumulator;
  },
  { TOTAL_CONNECTION_COUNT: 0 }
)
```			
* Server Status
```
			db.serverStatus()
```
* Find a document in collection
```
    db.PAYROLL_COMPLETE.find({ _id: "1030013468942751"} )
	db.PAYROLL_COMPLETE.find()
```
* Number of documents in a given collection
```
	db.PAYROLL_COMPLETE.count()
```
* Find documents prior ot given date example:
```
	db.PAYROLL_COMPLETE.find({ "consumedDate": { $lt: new Date('2021-01-12') } } )
	db.PAYROLL_COMPLETE.find({ "consumedDate": { $lt: ISODate("2021-01-11T19:49:41.646Z") } } )
```
* Sort records , limit selection 
```
	db.startup_log.find().sort({$natural:-1})
	Sort with a column: db.startup_log.find().sort({startTime:1})
	Sort and limit: db.startup_log.find().sort({startTime:-1}).limit(1);
```
* Results in readable format:
```
	db.startup_log.find().sort({startTime:1}).limit(1).pretty()
```
* Collection stats:
```
    db.PAYROLL_COMPLETE.stats()
```
* All Collections
```
    Show collections 
```
* DB Stats
```
    db.stats().
```
* Replica set info:
```
    db.system.replset.find().pretty()
```
* Replication states: 
```
    Rs.status()
```
* Getting help on a function
```
    db.PAYROLL_COMPLETE.getPlanCache().help()
```
* Command help
```
    https://docs.mongodb.com/manual/reference/operator/aggregation/count/
```
* Mongodb Config file:
```    
    cat /etc/mongod.conf
```
* Connect to mongod without Authentication
```
    mongo --host `hostname` --port 30000
```
* Authenticating after connection
```
    db.getSiblingDB("$external").auth(
        {
            mechanism: "PLAIN",
            user: "myuserName",
            pwd:  "MyPassword"
        }
    )
```
* How to view Log file size.
```
    rs.printReplicationInfo()
    § From Linux Server: grep oplog /etc/mongod.conf
```
* How to update Log file size (Size is in MB):
```
    db.adminCommand(
      {
        replSetResizeOplog: 1,
        size: 10240
      }
    )
```
* mongodb Service Status
```
    sudo service mongod status
```
* Start a Service 
```
    sudo service mongod start
```
* Check all Services running with filter 
```
    ps -ef |grep -i mongo
```
* Server Name:
```
    uname -a
```
* Storage:
```
    df -h
```
