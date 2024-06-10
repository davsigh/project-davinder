#!/bin/bash
sudo apt update
sudo apt install -y python3 python3-pip
pip3 install flask flask_sqlalchemy flask_login pymysql
