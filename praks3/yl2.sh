#!/bin/bash
#skript kokkadele

echo -n "Sisesta aluskandiku pikkus ja laius sentimeetrites(Näide: 40 30):"
read kandiku_pikkus kandiku_laius
echo -n "Sisesta küpsise pikkus ja laius sentimeetrites(Näide: 4 3):"
read kypsise_pikkus kypsise_laius
echo -n "Sisesta tordi kihtide arv(Näide 3):"
read kihid
echo -n "Mitu küpsist ühes pakis:"
read kypsised_pakis

#arvutused
kandiku_pindala=$(( $kandiku_pikkus * $kandiku_laius ))
kypsiste_pindala=$(( $kypsise_pikkus * $kypsise_laius ))
kypsiste_arv_kihis=$(( $kandiku_pindala / $kypsiste_pindala ))
kypsiste_arv_kokku=$(( $kypsiste_arv_kihis * $kihid ))
kypsiste_pakkide_arv=$(( $kypsiste_arv_kokku / $kypsised_pakis ))
ky_juurde_arv=$(( $kypsiste_arv_kokku % $kypsised_pakis))

if [ $ky_juurde_arv -ne 0 ];then
	echo "Sinule läheb vaja $kypsiste_pakkide_arv pakki ja $ky_juurde_arv küpsist juurde! Järelikult sul vaja osta $(( $kypsiste_pakkide_arv + 1)) pakki!"
else
	echo "Sinule läheb vaja $kypsiste_pakkide_arv pakki"
fi

