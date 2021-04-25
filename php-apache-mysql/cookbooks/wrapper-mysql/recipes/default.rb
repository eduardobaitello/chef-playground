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
mysql_pass = data_bag_item('mysql', 'root_password')

mysql_service 'default' do
  port '3306'
  version '8.0'
  initial_root_password mysql_pass['password']
  action [:create, :start]
end

# Create database for PHP application

# PHP database name
php_db = 'php_db'

mysql_database php_db do
  host '127.0.0.1'
  user 'root'
  password mysql_pass['password']
  action :create
end

# PHP user password
php_pass = data_bag_item('mysql', 'php_password')

# Create user for PHP application
mysql_user 'php_user' do
  password php_pass['password']
  host '%'
  action :create
  # Control connection credentials
  ctrl_host '127.0.0.1'
  ctrl_user 'root'
  ctrl_password mysql_pass['password']
end

# Grant permissions for php_user
mysql_user 'php_user' do
  database_name php_db
  host '%'
  privileges [:select,:update,:insert]
  action :grant
  # Control connection credentials
  ctrl_host '127.0.0.1'
  ctrl_user 'root'
  ctrl_password mysql_pass['password']
end
