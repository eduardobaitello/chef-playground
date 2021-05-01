#
# Cookbook:: wrapper-php
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

apt_update 'update' do
  action :update
end

# Installs PHP
include_recipe 'php::default'

# Install php-mysql module for PHP
package 'php-mysql'
