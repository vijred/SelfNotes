MongoDB info
============

* Connect arbitor
    - `mongo --host Servername.msft.com --port 30001` 
* Connect to a mongodb Server
    - `mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username MyUserName -p --host ServerNameFQDN DBName`
```
mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username `whoami` -p --host `hostname` admin
```
* How to connect mongodb using nonad account like superuser 
```
mongo --port 30000 --username superuser -p --host `hostname`
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
* find all users who have access on db
```
db.system.users.find({},{"_id" : 0, "user": 1, "roles" : 1})
# Single user
use admin
db.system.users.find({"user" : "<AD Username>"},{"_id": 0, "user" : 1,"roles" : 1})
``` 
* Rotate Logs
```
			db.adminCommand( { logRotate : 1 } ) 
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
* How to verify lag
```
rs.printSlaveReplicationInfo()
```
* Take backup of database: 
```
		mongodump --db dbName --out outFile --host "IP:PORT"  --username <user>  --password <pass>
```		
* How backups work on mongodb
    - regular backups works differently on mongoDB compare to traditional databases, refer to documentation @ https://docs.opsmanager.mongodb.com/current/tutorial/nav/backup-use-operations/ 
    - Continues backups are managed through MongoDB ops-manager  
* Active Connections on database: 
```
		db.currentOp ()
```
* Drop a database
```
MongoDB Enterprise dbname:PRIMARY> use dbname
#switched to db dbname
MongoDB Enterprise dbname:PRIMARY> db.dropDatabase()

```
* Export DB (data dump) / Import database 
    -   Sample json to import - Ref: https://media.mongodb.org/zips.json
```
# NOTE:
To Create a new DB from json, import json using mongoimport by providing db name 
sudo mongodump --db DatabaneName --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username `whoami` --host `hostname`
mongorestore --db DatabaseName --noIndexRestore --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username `whoami` --host `hostname` /data/db/dump/location/

# Export all DBs
mongodump --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're exporting from>

# Export single DB
mongodump --db <db_name> --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're exporting from>

# Export single collection
mongodump --db <db_name> --collection=<collection_name> --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're exporting from>

# into .csv or JSON format 
mongoexport --host <host you're exporting from> --authenticationMechanism=PLAIN --authenticationDatabase='$external'  --username <AD username> -p "<AD Password>"  --collection <collection_name> --db <database_name> --out=events.json

# import all DBs
mongorestore  --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're importing to> /location/of/dump/file/generated/from/mongodump/

# Import single DB
mongorestore  --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're importing to> /location/of/dump/file/generated/from/mongodump/

# Import a collection from JSON
mongoimport --host `hostname` --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external'  --username `whoami` -p "<AD Password, skip to prompt>"  --collection <collection_name> --db <database_name> --file=/data/db/dump/events.json

# Import a collection
mongorestore  --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username <AD username> -p "<AD Password>" --host <host you're importing to> /location/of/dump/file/generated/from/mongodump/

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

    -- Find a document with a given column not null
    db.mytablename.find({"columnname":{$exists:true}}).limit(1).pretty()
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
* How to execute a script against mongodb 
```
mongo --port 30000 --authenticationMechanism=PLAIN --authenticationDatabase='$external' --username $(whoami) -p --host $(hostname -f) <database_name> <script_name.js>
```
* Sample Java script to add an index on mongodb
```

db = db.getSiblingDB('myDBName');

print('************Sample Script to be executed on myDBName - Example ************************************');
var startTime = new Date();

db.Collectingname.createIndex(
    {
        'IndexColumnKey.IndexSubcolumn': 1
    },
    {name: 'IndexNamewhatever'}
);

var endTime = new Date();
print('Start time '+ startTime);
print('End time '+ endTime);
print('Total Ellapsed Time: '+ (endTime - startTime));

print('Indexs After Script: ');
printjson(db.collectionname.getIndexes());

```

* How to check if the server is config server or not
```
rs.status().configsvr
```

* What type of environemnts can be configured?
    - Standalone 
    - Replica-set : Primary and multiple secondary servers 
    - sharded cluster : More than one Shard/Replica-set + Config Servers (This can be a Replicaset) + mongoS 

* MongoDB Connection string Samples
    - https://docs.mongodb.com/manual/reference/connection-string/#mongodb-uri 

* Default mongodb config file on a linux server - 
    - /etc/mongod.conf