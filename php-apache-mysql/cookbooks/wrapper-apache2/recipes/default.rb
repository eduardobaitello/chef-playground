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

# Install php module
apache2_mod_php 'default'

# Disable "php7.4" module to prevent conflicts with "php" module
apache2_module "php7.4" do
  action :disable
end
