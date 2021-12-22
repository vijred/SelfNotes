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

* Soem example of YAML
  - https://github.com/vijred/SelfNotes/blob/master/Technologies-NonDB/Ansible/YAML.md


* What is Playbook
  - Playbook is a single YAML file wiht set of activities/Tasks

* what is Task
  - Task is defined activity like run a script or install a package etc on a given host. 

* What is a module
  - A module is a reusable, standalone script that Ansible runs on your behalf, either locally or remotely. Modules interact with your local machine, an API, or a remote system to perform specific tasks like changing a database password or spinning up a cloud instance

* example of modules 
  - command, script, yum, service , etc . Reference: https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html 

* Can a playbook contain 2 plays?
  - yes, playbook can contain list of plays. It can be treated as list of dictionaries, example dictionary with properties name, hosts, and tasks 

* Order of proiperties in a dictionary matter? 
  - No Order of properties does NOT matter in a dictionary , however order matters in list/array

* How to run the tasks on multiple servers in parallel
  - inventory file can contain groups, running tasks against group executes the tasks against all servers in the group in parallel 

* Ansible.windows namespace reference 
  - https://docs.ansible.com/ansible/latest/collections/ansible/windows/index.html
  
