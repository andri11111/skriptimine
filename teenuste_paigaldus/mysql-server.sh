#!/bin/bash

# 'set -e' aktiveerib Bash'i vearežiimi: kui mõni järgmine käsk tagastab
# veakoodi (ehk lõppeb mittekuluga 0), siis skript lõpetatakse KOHE.
# See on eriti oluline paigaldusskriptide puhul, sest:
#   - välditakse olukorda, kus skript jätkab tööd poolikult paigaldatud
#     või vigase konfiguratsiooni peal;
#   - probleem ilmneb kohe, mitte alles järgmiste käskude juures;
#   - tagab skripti ennustatavuse ja süsteemi stabiilsuse.
#
# Ilma 'set -e' käsuta võivad vead jääda märkamatuks ja skript jätkaks justkui
# kõik oleks korras, mis võib põhjustada raskeid ja nähtamatuid vigu süsteemis.

set -e    ##ei ole kohustuslik

# Määrame paigalduse mitteküsimuste režiimi.
# See tähendab, et apt ja dpkg ei näita ühtegi graafilist küsimust
# (sinine ekraan), vaid kasutavad ette antud vastuseid.
export DEBIAN_FRONTEND=noninteractive

# Uuendame paketiandmebaasi ja paigaldame vajalikud tööriistad:
#  - gnupg         → vajalik võtmete töötlemiseks
#  - ca-certificates → tagab HTTPS usaldusväärsuse
#  - debconf-utils → võimaldab saata ettevalmistaud vastuseid (debconf-set-selections)
#  - wget          → vajalik MySQL APT konfiguratsioonipaketi allalaadimiseks
apt update
apt install -y gnupg ca-certificates debconf-utils wget

# --- 1.(dpkg -i)Valmistame vastused mysql-apt-config paketi küsimustele automaatselt ---
# Esimene vastus: valime APT repositooriumist MySQL versiooni "mysql-8.0".
# Tavaliselt küsiks dpkg seda interaktiivse sinise menüü kaudu, kuid meie anname
# vastuse ette, et paigaldus oleks täielikult automaatne.
echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.0" | debconf-set-selections

##ning lülitame välja(select Disable) installeerida ülejäänud asjad(tools/src), et me soovime installida ainult MySQL-server
echo "mysql-apt-config mysql-apt-config/select-tools select Disabled"    | debconf-set-selections
# Teine vastus: kinnitame valiku ("Ok").
# Ilma selleta jääks dpkg ootama kasutaja “OK” sisestust.
echo "mysql-apt-config mysql-apt-config/select-product select Ok"       | debconf-set-selections

# --- 2.(apt install mysql-server) Vastame MySQL serveri paigalduse (mysql-community-server)ja root-parooli küsimustele ---
# Oracle MySQL 8.0 nõuab root-kontole kohe paigaldamise ajal parooli määramist.
# Siin määrame parooliks "qwerty", et paigalduse ajal seda ei küsitaks.
echo "mysql-community-server mysql-community-server/root-pass password qwerty"     | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections

# --- 3. Valime kasutatava autentimisplugina ---
# MySQL 8 kasutab vaikimisi uut ('caching_sha2_password') krüptograafilist
# paroolisüsteemi. Interaktiivne menüü küsiks, kas soovime “recommended” varianti.
# Siin anname ette vastuse “Use Strong Password Encryption (RECOMMENDED)”.
# See tagab ühilduvuse modernsete klienditeekidega ja väldib käsitsi kinnitust.
echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

# --- 4. Laeme alla ja paigaldame MySQL ametliku APT konfiguratsioonipaketi ---
# See pakett lisab /etc/apt/sources.list.d kataloogi Oracle'i ametliku repositooriumi
# ning paigaldab võtmed, mille abil apt saab pakette verifitseerida.
wget -O /tmp/mysql-apt-config_0.8.36-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.36-1_all.deb
dpkg -i /tmp/mysql-apt-config_0.8.36-1_all.deb

# --- 5. Uuendame paketiinfot ja paigaldame MySQL Serveri ---
# Pärast repositooriumi lisamist peab apt uuendama allikad (apt update).
# Seejärel paigaldame Oracle MySQL Server 8.0, kusjuures debconf vastused
# võimaldavad paigaldusel toimuda täielikult automaatselt.
apt update
apt install -y mysql-server

# --- 6. Lubame MySQL teenusel automaatselt käivituda ja käivitame selle kohe ---
# See tagab, et MySQL töötab nii praegu kui ka pärast süsteemi taaskäivitamist.
systemctl enable --now mysql

echo "Valmis: Oracle MySQL 8.0 on installidud. Root-parool: qwerty"
mysql --version || true
