name 'load-balancer'
description 'Load Balancer role'
run_list 'recipe[wrapper-haproxy]'
default_attributes 'load-balancer-test' => {
  'attribute1' => 'hello from haproxy',
}
