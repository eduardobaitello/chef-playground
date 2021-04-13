# haproxy

Installs HAProxy and 2 Apache servers.

# Vagrant Environment

## Virtual Machines
Use `vagrant up` to start the following VMs:
- web1
  - Private IP: 192.168.10.43
- web2
  - Private IP: 192.168.10.44
- load-balancer
  - Forwarded Port: 9000 --> 80

## Provisioning Script
All VMs runs a provisioning script that:
- Installs and starts `ntp` package
- Installs Chef Client v16.12

# Cookbooks

## apache
- Installs and start Apache.
- Create `/var/www/html` with templating using Ohai values.

## workstation
- Uses vagrant-ohai plugin to modify `node['ipaddress']` and match with Vagrant file.
- Create `/etc/motd` with templating using Ohai values.

## wrapper-haproxy
- Include [haproxy](https://supermarket.chef.io/cookbooks/haproxy) cookbook as dependency
- Installs and start HAProxy
- Configures HAProxy with _web1_ and _web2_ server

## wrapper-chef-client
Import [chef-client](https://supermarket.chef.io/cookbooks/chef-client) cookbook to update nodes every 5m~10m.

# Initializing Chef

Before starting, make sure to create your Chef Infra directory (`.chef`) with your configurations/credentials, then:
```
berks install && berks update && berks upload
```


# Bootstrapping nodes

_NOTE: Use either **With runlists** or **With roles**._

Use `vagrant-ssh` to get SSH credentials.

Bootstrap each node using the respective ports and identity-files. Example:

## With runlists
```
knife bootstrap localhost -p 2222 -U vagrant --sudo \
-i {IDENTITY_FILE} -N web1 \
--run-list --run-list "recipe[workstation],recipe[apache],recipe[wrapper-chef-client]"

knife bootstrap localhost -p 2200 -U vagrant --sudo \
-i {IDENTITY_FILE} -N web2 \
--run-list --run-list "recipe[workstation],recipe[apache],recipe[wrapper-chef-client]"

knife bootstrap localhost -p 2201 -U vagrant --sudo \
-i {IDENTITY_FILE} -N load-balancer \
--run-list --run-list "recipe[wrapper-haproxy]"
```

Go to http://localhost:9000 and the HAProxy should be listening, proxying to _web1_ and _web2_ servers.

## With roles
```
# Upload all roles
knife role from file roles/*.rb

knife bootstrap localhost -p 2222 -U vagrant --sudo \
-i {IDENTITY_FILE} -N web1 \
--run-list --run-list "role[web]"

knife bootstrap localhost -p 2200 -U vagrant --sudo \
-i {IDENTITY_FILE} -N web2 \
--run-list --run-list "role[web]"

knife bootstrap localhost -p 2201 -U vagrant --sudo \
-i {IDENTITY_FILE} -N load-balancer \
--run-list --run-list "role[load-balancer]"
```

Go to http://localhost:9000 and the HAProxy should be listening, proxying to _web1_ and _web2_ servers.
