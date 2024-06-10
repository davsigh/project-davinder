#!/bin/bash
sudo apt update
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo mysql -e "CREATE DATABASE ecommerce;"
sudo mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ecommerce.* TO 'admin'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"
