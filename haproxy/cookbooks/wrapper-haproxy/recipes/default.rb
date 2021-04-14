#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

# Using hardcoded IPs
# haproxy_backend 'servers' do
#   server [
#     'web1 192.168.10.43:80 maxconn 32',
#     'web2 192.168.10.44:80 maxconn 32',
#   ]
#   # https://github.com/sous-chefs/haproxy/issues/274
#   # notifies :reload, 'haproxy_service[haproxy]', :immediately
# end

# Using search for dynamic nodes
all_web_nodes = search('node', 'role:web')

servers = []

all_web_nodes.each do |web_node|
  server = "#{web_node['hostname']} #{web_node['ipaddress']}:80 maxconn 32"
  servers.push(server)
end

haproxy_backend 'servers' do
  server servers
end

haproxy_service 'haproxy' do
  subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
end
