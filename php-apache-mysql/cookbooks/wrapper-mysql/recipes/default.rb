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
mysql_database 'php-app' do
  host '127.0.0.1'
  user 'root'
  password mysql_pass['password']
  action :create
end
