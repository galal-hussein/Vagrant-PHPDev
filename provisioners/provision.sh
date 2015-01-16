#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -q

# Set Mysql Root Password
echo "Setting Mysql Root Password To ''"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password '
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '

# Install MySQL
sudo apt-get install -qqy -f mysql-server mysql-client

# Install Nginx And PHP-FPM And Git
sudo apt-get install nginx php5-fpm git-core -f -yqq

# Install PHP Libraries
sudo apt-get install php5-mysql php5-curl php5-gd php5-mcrypt php5-memcached -yqq 

# Remove The Old Site Configuration
sudo rm /etc/nginx/sites-available/default

#Add Nginx Configuration File
sudo cat >> /etc/nginx/sites-available/default << EOF
server {
    listen 80;

    root /var/www/app;
    index index.html index.htm index.php;

    access_log /var/log/nginx/site.log;
    error_log  /var/log/nginx/site-error.log error;

    server_name site.com;

    charset utf-8;


    location / {
        try_files \$uri \$uri/ /index.php\$is_args$args;
    }

    location = /favicon.ico { log_not_found off; access_log off; }
    location = /robots.txt  { log_not_found off; access_log off; }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:///var/run/php5-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params; 
	fastcgi_param SCRIPT_FILENAME /var/www/app/\$fastcgi_script_name;
        fastcgi_param PATH_INFO       \$fastcgi_path_info;
        fastcgi_param ENV development;
    }
}
EOF

	
# Change The Document Root Owner
sudo chown www-data.www-data /var/www/app -R

# Restart Nginx
/etc/init.d/nginx restart

# Restart PHP-FPM 
/etc/init.d/php5-fpm restart

exit 0
