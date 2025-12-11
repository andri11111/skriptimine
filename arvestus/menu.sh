#!/bin/bash
# Andri Tilsen
# nimi menu
# Toidumenüü väljastamine ja söögi kirjeldus
#
#echob valikud numbritena
echo "Vali oma söögi number:"
echo "1) liha ja kartulid"
echo "2) kala ja krõpsud"
echo "3) supp ja salat"

#küsib mille kasutaja valib
echo -n "Tee oma valikd  (1 või 2 või 3): " 
#paneb variablesse mille kasutaja valis
read valik
#kui valik on võrdne 1-ga, siis echotakse talle vastav  sõõgi kirjeldus
if [ $valik = 1 ];then
	echo "Väga maitsev, aga jälgi oma tervist!"
	echo "Head isu"
#kui valik ei ole 1 ja on 2 siis echotakse talle vastav  sõõgi kirjeldus
elif [ $valik = 2 ];then
	echo "Brititoit on maitsev!"
	echo "Head isu!"
#kui valik ei ole 1 ja on 3 siis echotakse talle vastav  sõõgi kirjeldus
elif [ $valik = 3 ];then
	echo "Nii tervislik ja igav..."
	echo "Head isu"
#kui pole valitud 1,2,3 siis kasutatakse else ja õeldakse et peab valima pakutud numbri
else
	echo "Vale valik! vali 1, 2 või 3"
#lõpetab if statementi
fi


