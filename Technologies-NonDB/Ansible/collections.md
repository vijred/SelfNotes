Collections that can be used in ansible 
=======================================


* gather_facts (ansible.builtin.gather_facts)
    -   Collects facts about the server using builtin module (ansible.builtin.setup) 
    -   example
```
# Sample Play
- name: "My Play name"
  hosts: localhost
  gather_facts: false
```

