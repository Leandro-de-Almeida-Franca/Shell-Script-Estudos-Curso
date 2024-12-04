#!/bin/bash
#Script para verificar processos rodando


TIME=10

EMAIL=leandro...

if [ $# -eq 0 ]
then
	echo "Favor informar um processo como argumento."
	echo "./MonitoraProcesso.sh <argumento>"
	exit 1
fi

while true
do
	if ps aux | grep $1 | grep -v grep | grep -v $0 > /dev/null
	then
		sleep $TIME
	else
		echo "ATENÇÂO!!!!!! O processo $1 NÂO está em execucação!" | mail -s "[$0] Monitoração do processo $1" $EMAIL
		sleep $TIME
	fi
done

