#!/bin/bash

# resynchronize package index files
apt-get -y update

# get database password from parameter
dbpass = $1

# suppress configuration dialogs
export DEBIAN_FRONTEND=noninteractive

# set the MySQL root password
echo mysql-server mysql-server/root_password password $dbpass | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $dbpass | debconf-set-selections

# install LAMP default stack
apt-get -y install apache2 mysql-server php php-mysql

# write some code to show PHP info
echo \<center\>\<h1\>Server LAMP Test\</h1\>\<br/\>\</center\> > /var/www/html/phpinfo.php
echo \<\?php phpinfo\(\)\; \?\> >> /var/www/html/phpinfo.php

# restart the Apache server
apachectl restart