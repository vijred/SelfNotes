Ansible commands
---------------

* List all Ansible modules
    -   `ansible-doc -l`

* Show documentation of service module
    -   `ansible-doc service`

* How to get Ansible command help 
    -   `ansible --help` or `ansible-playbook --help`

* How to run ansible command without using playbook
    -   `ansible <hosts> -a <command> -i inventoryfile.txt` - Example:  `ansible localhost -a date` , `ansible target1 -m ping -i inventory.txt` , `ansible all -m ping -i inventory.txt`

* what is all in host name
    -   all is created by ansible with all hosts in inventory file 

* Example of same playbook and how to run
    -   
```
[osboxes@ansiblecontroller Project1]$ cat playbook02.yaml
-
  name: Test connectivity
  hosts: all
  tasks:
    - name: execute ping 
      ping:
-
  name: 'cat something'
  hosts: all
  tasks:
    - name: cat a file 
      command: cat filename.txt chdir=/etc
-
  name: 'copy a file to all servers from controller'
  hosts: all
  tasks:
    - name: copy a file
      copy: 
        src = /tmp/smaplefilename.txt
        dst = /tmp/smaplefilename.txt

-
    name: 'Execute a script on all web server nodes'
    hosts: web_nodes
    tasks: 
        - name: 'Execute install_script script'
          script: /tmp/install_script.sh
        -
            name: 'start httpd services'
            service: name=httpd state=started          
        -
            name: 'Update entry into /etc/resolv.conf'
            lineinfile:
                path: /etc/resolv.conf
                line: 'nameserver 10.1.250.10'
```
```
ansible-playbook  playbook02.yaml -i inventory.txt
```
```
[osboxes@ansiblecontroller Project1]$ cat inventory.txt
target1 ansible_host=192.168.56.102 ansible_ssh_pass=osboxes.org
target2 ansible_host=192.168.56.103 ansible_ssh_pass=osboxes.org

# All Nodes
[all_nodes]
target1
target2
```
* Sample inventory file
    -   
```
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=server3.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!

# Database Servers
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Password123!
```


* How to understand Ansible Playbook output
    -   `PLAY [Playbookname]` - This indicates name of the playbook being executed
    -   `TASK [gathering facts]` - Inventory infomration
    -   `TASK [Task name]` - Name of the task being executed, summary of the change 
    -   `PLAY RECAP`    -   detailed information of the PLAYBOOK, indicates if end result is OK or not, If Changed or not, connectivity and faiure information 


* ansible module categories 
    -   system
    -   Commands
    -   Files
    -   Database
    -   Cloud
    -   Windows
    -   More...

* What is expect
    -   This prompts for user input for a givne variable 

* What is free_form 
    -   The command module takes a free form string as a command to run but there is no actual parameter named free form.

* idempotency
    -   an operation is idempotency if result of performing once fetches same results as performing the operation repeatedly.
    -   Example: If a service is started, it will be same state attempting to start it again and again


* Variables in ansible 
    -   variable can be defined as property and it will be used using `'{{variablename}}'` , this can also be used like `source: this {{variablename}} is my tol`
```
[osboxes@ansiblecontroller Project1]$ cat playbook04.yaml
-
  name: copy file sample playbook
  hosts: all
  vars:
    var2: 'local variable value'
  tasks:
    - name: copy smaple file samplefileincontroller.txt from controller to target
      copy:
        src: /tmp/samplefileincontroller.txt
        dest: /tmp/samplefileincontroller.txt
    - name: 'test task for {{var1}}'
      debug:
        msg: 'This message indicates value of variable var1 - {{ var1 }} , local varialbe value is - {{ var2 }}'

[osboxes@ansiblecontroller Project1]$ cat inventory2.txt
target1 ansible_host=192.168.56.102 ansible_ssh_pass=osboxes.org var1=/tmp/target1file.txt
target2 ansible_host=192.168.56.103 ansible_ssh_pass=osboxes.org var1=/tmp/target2file.txt

# All Nodes
[all_nodes]
target1
target2
[osboxes@ansiblecontroller Project1]$

```

* Putting useful variables in a signle variable file for consumption is called templating 

* condiitons in ansible 


* loop in ansible . Note: loop and with_items are almost same! . with_files, with_urls, with_mongodb are samples 
```
-
  name: copy file sample playbook
  hosts: all
  vars:
    var3:
      - displayname: vj
        displaynow: true
      - displayname: jv
        displaynow: true
      - displayname: sm
        displaynow: false
  tasks:
    - name: 'sample task for loop and condition'
      debug:
        msg: 'Display this name now - {{ item.displayname }}'
      when: item.displaynow == true and ansible_host == '192.168.56.102'
      loop: '{{ var3 }}'

    - name: 'sample loop and or condition - 2'
      debug:
        msg: 'Display this name now from loop 2 - {{ item.displayname }}'
      loop:
        -  displayname: vijay
           dispalynow: true
        -  { displayname: vijay2, dispalynow: true }
```

* how to capture results from one task and use it in next 
    -    use register - 
```
...
  tasks
    - command: service httpd status 
      register: result

    - name: display only if error
      debug
        msg: "Efrror info"
      when: result.stdout.find('down') != -1
```

* what is the purpose of Roles in Ansible 
    -   Join multiple tasks together 
    -   better organize with folder structure: tasks, vars, defaults, handlers, templates 

* Where to search for existing roles or share new ones
    -   Ansible Galaxy 

* How to create new folder structure for new roles project 
    -   `ansible-galaxy init mysql`

* default location of roles
    -   Roles folder in the same folder as playbook.yaml
    -   /etc/ansible/roles 
    -   roles_path in ansible configuration file (/etc/ansible/ansible.cfg) 

* how to pass additional parameters to Ansible playbook while executing - 
    -   add additional input parameter `-e`, provide details `variablename=variablevalue`. Example: `-e "vault_token=xyzxyzsaf variable2=ThisisTestVariableForVar2"`

* How to redirect all ansible logs to a file. 
  - Sample :  
```
ANSIBLE_LOG_PATH=<<path_to_the_logfile>>
eg: ANSIBLE_LOG_PATH=/home/vj/mywork_$(date "+%Y%m%d%H%M%S").log

an example for adding replica member:
sudo ANSIBLE_LOG_PATH=/tmp/vjAnsibleLogs_$(date "+%Y%m%d%H%M%S").log ansible-playbook /opt/ansible/xyz/playbooks/myplaybook.yml -e "input_file=/home/myinputfile.yml"
```

* what is `set_fact`
  - when set_fact is used, those facts are in the context of host. These facts can be re-used in different plays as necessary. 


* What is `assert`
  - This is to validate given conditions , used at playbook level and can be used on Windows server as well 
```
- assert: { that: "ansible_os_family != 'RedHat'" }

- assert:
    that:
      - "'foo' in some_command_result.stdout"
      - number_of_the_counting == 3

- name: After version 2.7 both 'msg' and 'fail_msg' can customize failing assertion message
  assert:
    that:
      - my_param <= 100
      - my_param >= 0
      - testvariable | default('') != ""
    fail_msg: "'my_param' must be between 0 and 100"
```     

* How to set a runtime fact, example - 
  - 
```
  hosts: localhost
    # Set Up Playbook Run-Time Facts
    - name: "vj_test_gg_on_windows_install - Set Up Playbook Run-Time Facts"
      set_fact:
        run_id: "{{ 9999999999999999999999 | random | to_uuid }}"  # Generate a Unique Run ID
```
