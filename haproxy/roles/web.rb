name 'web'
description 'Web Server Role'
run_list 'recipe[workstation]', 'recipe[apache]', 'recipe[wrapper-chef-client]'
default_attributes 'apache-test' => {
  'attribute1' => 'hello from apache server',
  'attribute2' => 'just a test',
}
