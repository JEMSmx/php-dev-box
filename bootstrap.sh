#!/bin/bash
set -e

curl -fsSL https://github.com/memiux/cloud/tarball/master | tar --strip 1 -xzC $(mkdir -p ~/.cloud; echo $_)
~/.cloud/vagrant-bootstrap.sh

~/.cloud/install-php.sh
~/.cloud/install-httpd.sh

printf "\n" | pecl install imagick
su vagrant -c 'cd /vagrant && composer.phar install'

# MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password 123"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 123"
apt-get -y install mysql-server

sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
mysql -h 127.0.0.1 -u root -p123 -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '123'; FLUSH PRIVILEGES;"
service mysql restart

service php-fpm start
service httpd start

# /usr/local/sbin/php-fpm --nodaemonize
# /usr/local/bin/httpd -D NO_DETACH
# tail -f /var/log/syslog /var/log/upstart/*.log /var/log/mysql/error.log /tmp/*.log
