#!/bin/bash
# Andri Tilsen
# info
# Tervitab kasutajat ja väljastab tänase kuupäeva ja kellaaja
#${USER^} muudab variable väärtuse esimese tähe suureks
TERVITUS_NIMI="${USER^}"
#echob tervituse
echo "Tere, $TERVITUS_NIMI!"
#
#Kuupäeva väljastamine date+
date +"Täna on %d.%m.%Y kell %H:%M"
