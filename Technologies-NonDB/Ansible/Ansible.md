Ansible
=======

* How to replace a string on a given file 
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




  
  FAQ
  ------
  * YAML - What is difference between Dictionary and List(Array) or List of Dictionaries(Map), value key pair 
    - 
```
List is ordered collection 
 - SampleList1
 - SampleList2
 - SampleList3

Dictionary is unordered   
 -  SampleDictionary1: Value1
    Property2: Value2
    PropertyofDictionary3: 
      Property1ofdictionary3: value4
      Property2ofdictionary3: value5
 -  SampleDictionary1: Value10
    Property2: Value20
    PropertyofDictionary3: 
      Property1ofdictionary3: value40
      Property2ofdictionary3: value50
 -  SampleDictionary1: Value11
    Property2: Value12
    PropertyofDictionary3: 
      Property1ofdictionary3: value14
      Property2ofdictionary3: value15

```

* How to comment a TAML file
  * anything starting with # is a comment - `#`

* Sample Inventory File , how to use groups 
  - 
```
# Sample Inventory File

# Web Servers
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!

# Database Servers
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Password123!

[web_servers]
web1
web2
web3

[db_servers]
db1

[all_servers:children]
web_servers
db_servers
```  

* How to check Ansible version or if Ansible isntalled as expected
  - `ansible --version`

* Ansible way of hello world, pingtest  
  - 
```
cat > inventory.txt
target1 ansible_host=192.168.56.102 ansible_ssh_pass=osboxes.org
target2 ansible_host=192.168.56.103 ansible_ssh_pass=osboxes.org
^C 
ansible target1 -m ping -i inventory.txt
```
* What is Ansible default configuration file
  - `/etc/ansible/ansible.cfg`


