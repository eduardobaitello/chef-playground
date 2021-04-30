#
# Cookbook:: wrapper-mysql
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Add MySQL Community repo
yum_repository 'mysql80-community' do
  description 'MySQL 8.0 Community Server'
  baseurl 'http://repo.mysql.com/yum/mysql-8.0-community/el/7/$basearch/'
  gpgkey 'http://repo.mysql.com/RPM-GPG-KEY-mysql'
  action :create
end

# Install mysql
mysql_root_pass = data_bag_item('mysql', 'root_password')

mysql_service 'default' do
  port '3306'
  version '8.0'
  initial_root_password mysql_root_pass['password']
  action [:create, :start]
end

# Create database for PHP application

# PHP databag
php_databag = data_bag_item('mysql', 'php')

mysql_database php_databag['database'] do
  host '127.0.0.1'
  user 'root'
  password mysql_root_pass['password']
  action :create
end

# Create user for PHP application
mysql_user php_databag['username'] do
  password php_databag['password']
  host '%'
  action :create
  # Control connection credentials
  ctrl_host '127.0.0.1'
  ctrl_user 'root'
  ctrl_password mysql_root_pass['password']
end

# Grant permissions for php_user
mysql_user php_databag['username'] do
  password php_databag['password']
  database_name php_databag['database']
  host '%'
  privileges [:select,:update,:insert,:create]
  action :grant
  # Control connection credentials
  ctrl_host '127.0.0.1'
  ctrl_user 'root'
  ctrl_password mysql_root_pass['password']
end
