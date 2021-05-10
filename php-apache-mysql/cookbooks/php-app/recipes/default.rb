#
# Cookbook:: php-app
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Install mysql client
package 'mysql-client-core-8.0'

# PHP databag
php_databag = data_bag_item('mysql', 'php')

# Create PHP application table
mysql_database 'employees' do
  host '192.168.10.100'
  user php_databag['username']
  password php_databag['password']
  sql "USE #{php_databag['database']};
      CREATE TABLE IF NOT EXISTS employees (
      id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(100) NOT NULL,
      address VARCHAR(255) NOT NULL,
      salary INT(10) NOT NULL
      );"
  action :query
end

# Make sure default index.html is absent
file '/var/www/html/index.html' do
  action :delete
end

# Copy PHP Application files
template '/var/www/html/config.php' do
  source 'config.php.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    db_server: '192.168.10.100',
    db_username: php_databag['username'],
    db_password: php_databag['password'],
    db_name: php_databag['database']
  )
end

remote_directory '/var/www/html' do
  source 'php_app'
  files_owner 'root'
  files_group 'root'
  files_mode '0644'
  action :create
end
