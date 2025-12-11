#!/bin/bash
echo -n "Sisesta aja väärtus(23): "
read aeg
if [[ $aeg -ge 6 && $aeg -lt 12 ]];then
	echo "Tere hommikust!"
elif [[ $aeg -ge 12 && $aeg -lt 18 ]];then
	echo "Tere päevast"
elif [[ $aeg -ge 18 && $aeg -lt 22 ]];then
	echo "Tere õhtust"
elif [[ $aeg -ge 22 && $aeg -lt 24 ]] || [[ $aeg -ge 0 && $aeg -lt 6 ]];then
	echo "Head ööd!"
else 
	echo "vale sisend"
fi
