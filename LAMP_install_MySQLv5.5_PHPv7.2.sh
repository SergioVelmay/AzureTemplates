#!/bin/bash

# resynchronize package index files
apt-get -y update

# get database password from parameter
dbpass = $1

# suppress configuration dialogs
export DEBIAN_FRONTEND=noninteractive

# set the MySQL 5.5 root password
echo mysql-server-5.5 mysql-server/root_password password $dbpass | debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install LAMP with MySQL 5.5 and PHP 7.2
apt-get -y install apache2 mysql-server-5.5 php7.2 php7.2-mysql

# write some code to show PHP info
echo \<center\>\<h1\>Server LAMP PHP 7.2 Test\</h1\>\<br/\>\</center\> > /var/www/html/phpinfo.php
echo \<\?php phpinfo\(\)\; \?\> >> /var/www/html/phpinfo.php

# restart the Apache server
apachectl restart