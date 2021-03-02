#!/bin/bash
cd /var/www/html/

sudo add-apt-repository -y ppa:ondrej/php
sudo apt -y update

sudo apt -y install apache2 php7.4 libapache2-mod-php7.4
sudo apt -y install mysql-server zip
sudo apt -y install php7.4-mbstring php7.4-dom php7.4-mysql

# composer global installation
echo "installation de composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# url rewriting
echo "mise en place de l'url rewriting"
sudo a2enmod rewrite
sudo cp -f ./bashInstall/000-default.conf /etc/apache2/sites-available/000-default.conf
	#sudo nano /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart

# create database
echo "création de la base de donnée"
sudo mysql -p'root' -uroot -e "CREATE DATABASE IF NOT EXISTS laravel;";
	#sudo mysql -uroot -p

echo "mise en place de Laravel"
composer create-project --prefer-dist laravel/laravel laravel

# set the password
echo "enregistrement du mdp de la bbd dans Laravel"
sudo cp -f ./bashInstall/.env /var/www/html/laravel/.env
	#sudo nano ./laravel/.env

echo "fin du script d'installation"