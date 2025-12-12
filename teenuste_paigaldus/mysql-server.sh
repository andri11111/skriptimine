#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt update
apt install -y gnupg ca-certificates debconf-utils wget

echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.0" | debconf-set-selections

echo "mysql-apt-config mysql-apt-config/select-tools select Disabled"    | debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-product select Ok"       | debconf-set-selections

echo "mysql-community-server mysql-community-server/root-pass password qwerty"     | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections

echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

wget -O /tmp/mysql-apt-config_0.8.36-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.36-1_all.deb
dpkg -i /tmp/mysql-apt-config_0.8.36-1_all.deb

apt update
apt install -y mysql-server

systemctl enable --now mysql

echo "Valmis: Oracle MySQL 8.0 on installidud. Root-parool: qwerty"
mysql --version || true
