name 'php-apache'
description 'Role for PHP/Apache'
run_list 'recipe[wrapper-php]', 'recipe[wrapper-apache2]', 'recipe[php-app]'
