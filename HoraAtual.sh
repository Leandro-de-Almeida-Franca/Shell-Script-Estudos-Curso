#!/bin/bash
#Script para verificar a hora

HORA=$(date +%H)
MIN=$(date +%M)

# Define se e tarde ou noite
if [ $HORA -ge 06 -a $HORA -lt 12 ]
then
	echo "Bom Dia!"
elif [ $HORA -ge 12 -a $HORA -lt 18 ]
then
	echo "Boa Tarde!"
else
	echo "Boa Noite!"
fi
# Transfoma em PM ou AM
if [ $HORA -ge 12 ]
then
	AMPM=PM
else
	AMPM=AM
fi
# Reduz a hora
if [ $HORA -gt 12 ]
then HORA=$(expr $HORA - 12)
fi
echo
echo "A hora atual é: $HORA:$MIN: $AMPM"
