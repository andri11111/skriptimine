#!/bin/bash
# Andri Tilsen
# skripti nimi kujund
# Trükkida kolmnurga kujund ridade arvuga
#
#Küsib kasutajalt ridade arvu ja ei tee reavahetust
echo -n "Sisesta ridade arv: "
# Salvestab kasutaja vastuse variablesse
read read_arv
#loeb ridu ja loob kolmnurga, väheneb iga rea järel
for ((i=read_arv; i>0; i--)); do
#trükib tärnid reas
    for ((j=0; j<i; j++)); do
#ei tee reavahetust
        echo -n "* "
# lõpteb for teise for tsükkli
    done
#echob reavahetuse pärast rea lõppu
	echo ""
#lõpetab esimese for tsükkli
done


