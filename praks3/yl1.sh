#!/bin/bash
echo -n "Sisesta oma ees- ja perenimi: "
read eesnimi perenimi
if  [ -z "$eesnimi" ] || [ -z "$perenimi" ]; then
	echo "Viga: Palun sisesta nii ees- kui ka perenimi."
	exit
fi
echo "Tere tulemast, $eesnimi $perenimi!"
