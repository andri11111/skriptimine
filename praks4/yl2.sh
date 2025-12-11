#!/bin/bash
echo -n "Mitu reisijat on grupis ja mitu kohta on bussis (Näiteks: 22 66): "
#loeb variable
read reisijad bussikohad
#jagab reisijad bussikohtadega ära
tais=$(($reisijad / $bussikohad))
#arvutab jäägi
yle=$(($reisijad % $bussikohad))
#kontrollib kas ülejäänud on rohkem kui 0, kui on siis lisab ühe bussi juurde
if test $yle -gt 0
then
	tais=$(($tais + 1))
fi
echo "Kokku on vaja $tais taisbussi"
