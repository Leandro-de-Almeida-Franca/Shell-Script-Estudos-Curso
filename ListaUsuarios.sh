#!/bin/bash
#Listar todos os usuarios do sitema, exibindo suas informações.


MIN_UID=$(grep "^UID_MIN" /etc/login.defs | tr -s "\t" | cut -f2)
MAX_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s "\t" | cut -f2)

OLDIFS=$IFS
IFS=$'\n'

echo -e "USUARIO\t\tUID\t\tDIR HOME\t\tNome ou DESCRIÇÂO"
for i in $(cat /etc/passwd)
do
	USERID=$(echo $i | cut -d ":" -f3)
	if [ $USERID -ge $MIN_UID -a $USERID -le $MAX_UID ]
	then
		USER=$(echo $i | cut -d ":" -f1)
		USERDESC=$(echo $i | cut -d ":" -f5 | tr -d ',')
		USERHOME=$(echo $i | cut -d ":" -f6)
		echo -e "$USER\t\t$USERID\t\t$USERHOME\t\t$USERDESC"
	fi
done
IFS=$OLDIFS
