# php-apache-mysql

**WIP**

Installs 1 php-apache and 1 mysql.

# Vagrant Environment

## Virtual Machines
Use `vagrant up` to start the following VMs:
- php-apache
  - Forwarded Port: 8080 --> 80
- mysql
  - Private IP: 192.168.10.100

# Initializing Chef

Before starting, make sure to create your Chef Infra directory (`.chef`) with your configurations/credentials, then:
```
berks install && berks update && berks upload
```

# Boostrapping nodes

Use `vagrant-ssh` to get SSH credentials.

Bootstrap each node using the respective ports and identity-files.

After boostrapping, go to http://localhost:8080.

```
# Upload roles
knife role from file roles/*.rb

# Create data bag
knife data bag create mysql
knife data bag from file mysql data_bags/mysql/mysql.json

knife bootstrap localhost -p 2222 -U vagrant --sudo \
-i {IDENTITY_FILE} -N php_apache \
--run-list "role[php-apache]"

knife bootstrap localhost -p 2200 -U vagrant --sudo \
-i {IDENTITY_FILE} -N mysql \
--run-list "role[mysql]"
```
