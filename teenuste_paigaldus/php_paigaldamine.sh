#!/bin/bash

PHP=$(dpkg-query -W -f='${Status}' php8.2 2>/dev/null | grep -c 'ok installed')

# kui PHP muutuja vaartus vordub 0-ga
if [ $PHP -eq 0 ]; then
    # siis ok installed ei ole leidud
    # ja väljastatme vaatav teade ning
    # paigaldame:
    echo "Paigaldame php ja vajalikud lisad"
    apt install php8.2 libapache2-mod-php8.2 php8.2-mysql
    echo "php on paigaldatud"
    
# kui PHP muutuja vaartus vordub 1-ga  
elif [ $PHP -eq 1 ]; then
    # siis ok installed on leitud 1 kord
    # ja teeme ube paigaldatua
    echo "php on juba paigaldatud"
	which php
fi
