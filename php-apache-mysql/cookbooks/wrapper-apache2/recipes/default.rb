#
# Cookbook:: wrapper-apache2
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# service['apache2'] is defined in the apache2_default_install resource but other resources are currently unable to reference it.
# To work around this issue, define the following helper in your cookbook:
service 'apache2' do
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true
  action :nothing
end

# Install Apache
apache2_install 'default'

# Enable modules need by PHP FPM
apache2_module 'proxy'
apache2_module 'proxy_fcgi'
apache2_module 'setenvif'

# Enable PHP FPM config
execute 'enable_fpm_conf' do
  command 'a2enconf php7.4-fpm'
  notifies :restart, 'service[apache2]', :immediately
end
