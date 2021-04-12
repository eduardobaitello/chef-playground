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

# Converge

## Locally
```
sudo chef-client
```
## With Knife SSH
```
TBD
```

# Purge all cookbooks from Chef Server
```
knife cookbook bulk delete '.*' -p
```
