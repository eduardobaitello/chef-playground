# Boostrap Nodes

## Without Runlist
```
knife bootstrap ${IP_ADDRESS} -p ${PORT} -U ${USER} --sudo
-i ${IDENTITY_FILE}
-N ${NODE_NAME}
```

## With Runlist
```
knife bootstrap ${IP_ADDRESS} -p ${PORT} -U ${USER} --sudo
-i ${IDENTITY_FILE}
-N ${NODE_NAME}
--run-list "recipe[${COOKBOOK_NAME}]"
```

# Runlists

## Add runlists
```
knife node run_list add ${NODE_NAME} "recipe[${COOKBOOK_NAME1}],recipe[${COOKBOOK_NAME2}]"
```

## Set runlists
```
knife node run_list set ${NODE_NAME} "recipe[${COOKBOOK_NAME1}],recipe[${COOKBOOK_NAME2}]"
```

# Converge Nodes
## Manual list
```
knife ssh ${IP_ADDRESS} 'sudo chef-client' \
--manual-list -p ${PORT} -x ${USER} -i ${IDENTITY_FILE}
```
## All nodes (search pattern)
```
knife ssh "*:*" 'sudo chef-client' \
-x ${USER} -i ${IDENTITY_FILE}
```
## By role (search pattern)
```
knife ssh "role:web" 'sudo chef-client' \
-x ${USER} -i ${IDENTITY_FILE}
```
# Berks
## Install, update and upload cookbooks/dependencies 
```
berks install && berks update && berks upload
```

# Purge all cookbooks from Chef Server
```
knife cookbook bulk delete '.*' -p
```
