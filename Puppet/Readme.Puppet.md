Puppet Basics
=============


* How to run Puppet Agent on a server
    - `puppet agent -t ` -- Run puppet agent on a given server 
    - `/opt/puppetlabs/bin/puppet agent -t --debug --verbose` -- Run puppet in Debug mode 
* How to restart puppet agent on Linux 
    - 
```
sudo systemctl stop puppet
sudo systemctl start puppet
```
* How to find if puppet service is running on Linux mchine
    - `ps -ef | grep puppet`
* How to restart puppet agent on Windows Server
    - Restart the Service `Puppet`
* check facts on Server
    - facter 
* Puppet config file location example
    - https://gitstuff.myorgms.com/projects/PUPMOD/repos/puppet_masters/browse/files/master_sync


* Execute Powershell file:

        scheduled_task { 'Mypowershell':
            ensure      => present,
            require     => File[ 'C:/location/mypowershell.ps1' ],
            name        => 'myPoewrshell',
            enabled     => true,
            command     => "${::Env_Directory}/system32/WindowsPowerShell/v1.0/powershell.exe",
            working_dir => "${::Env_Directory}\\Folder\\Subfolder",
            arguments   => '-NoLogo -NonInteractive -file myPowershellFile.ps1',
            trigger     => {
                schedule         => 'daily',
                every            => 1,
                start_time       => '06:00',
                minutes_interval => '360',
            }


* Create/ Update Registry:

        registry_value { 'HKLM\Cluster\myThreshold':
            ensure => present,
            type   => 'dword',
            data   => $::myThreshold,
        }


* Download latest github files 

        vcsrepo { 'azuresupportscripts':
                    ensure   => latest,
                    path     => 'C:/myPowershellFiles',
                    provider => git,
                    source   => 'https://github.com/vijred/Powershell.git',
                    revision => 'master',
                }


* Sample Template

        # This file is managed by Puppet.
        # If chagnes are needed - please use the xyz puppet module
        # Direct changes will be overwritten by Puppet

        <% if @environment == 'production' -%>
        myservers-: xyz
        <% elsif @environment == 'np' -%>
        ldap_servers: ldaps://ldap.microsoft.com 
        <% else %>
        ldap_servers: ldaps://notmicrosoft.com
        <% end -%>

* Sample Template file usage 

        '/etc/myconffile.conf':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('pupmodulename/myconffile.conf.erb'),
        notify  => Service['restartthisserice'],
        require => Package['package-sasl','package2-sasl-ldap'];

        # Create an alias example
        file { '/etc/profile.d/sample_alias.sh':
        ensure =>  present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/mymodule/sample_alias.sh',
        }


* Few useful commands to know the commands 
    ```
        puppet help
        puppet help resource | more 
        puppet resource --types | wc -l
        puppet describe user | more
        puppet describe --providers
    ```

* puppet valite
    -   `puppet parser validate demo.pp`

* Puppet dry run 
    -   `puppet apply demo.pp --noop`

* How to run puppet code
    -   `sudo puppet apply demo.pp `

* Sample pp to create a user
    ```
    user { "vjtestuser1":
            ensure => "present",
            uid => "7777",
            shell => "/bin/sh",
            group => "vjtestuser1"
    }
    ```

*   Puppet Classes 
    -   Puppet classes to use reusable and organized structure 
    -   Sample code
    ```
    class vjdemoclass1{
        file { "/home/vj/file1.txt":
            ensure => "present",
            content => "Test file from pupper",
        }
    }
    include vjdemoclass1
    ```
 
*   Puppet manifests 
    -   find the config using `puppet config print`
    -   Default main manifest location `/etc/puppetlabs/code/environments/production/manifests/`

* Additional Topics of interest to learn
    -   Variables - Ex: `class "Class Name"{ $varName = <value> }`
    -   Facts (Built in variables)  -   `facter` is key value pair
    -   classe
    -   Modules - collection of resources and classes are moduels / manifests. This is well defined folder structure 
    -   Roles and Profiles  -   
    -   HIERA is puppet key value configuration file 
    -   Puppet Forge (Community) `https://forge.puppet.com`
