#!/bin/bash
echo -n "Sisesta täisarv: "
#loeb variable
read taisarv
#arvutab kas tegemist on paarisarvu või paaritu arvuga
if [ $(( $taisarv % 2 )) -eq 0 ];then
	echo "Tegemist on paarisarvuga"
else
	echo "Tegemist on paaritu arvuga"
fi
