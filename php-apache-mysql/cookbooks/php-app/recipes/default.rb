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
