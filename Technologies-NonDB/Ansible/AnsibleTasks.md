More information about Ansible Tasks 
------------------------------------

* Example of Ansible etcd lookup 
```
      vars: 
        env: myenv
        app_name: myapp
        component_name: funapp
      set_fact:
        etcdlookuppath: 'mypathsource/{{ env }}/applications/{{ app_name }}/components/{{ component_name }}/paths'


    - name: "since Ansible 2.5 you can set server options inline"
      ansible.builtin.debug:
        msg: 
          - "{{ lookup('etcd',etcdlookuppath, version='v2', url='http://etcdserver.contoso.com') }}"
```

