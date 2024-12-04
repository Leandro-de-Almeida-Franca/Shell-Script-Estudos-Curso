#!/bin/bash
#
#Script com diversas funcoes que fazem o tratamento de dados em datas

DATA=$(echo $2 | tr -d "/")
VAL1=$(echo $DATA | cut -c-2)
VAL2=$(echo $DATA | cut -c3-4)
ANO=$(echo $DATA | cut -c5-8)

RetornaFormato () {
	if [ $VAL1 -le 12 -a $VAL1 -eq $VAL2 ] # Dia = Mes = Formato BR
	then
		return 0
	elif [ $VAL1 -gt 12 -a $VAL2 -le 12 ] #Formato BR
	then
		return 0
	elif [ $VAL1 -le 12 -a $VAL2 -gt 12 ] #Formato US
	then
		return 1
	elif [ $VAL1 -le 12 -a $VAL2 -le 12 ] #Formato Indefinido, mas válido
	then
		return 2
	else
		return 3
	fi
}

InverteDiaMes () {
	RetornaFormato $1
	local FORMATO=$?
	if [ $FORMATO -ne 3 ]
	then
		echo "$VAL2/$VAL1/$ANO"
	else
		echo "Formato de Data Invalido"
	fi
}

IncluiiBarra () {
	RetornaFormato $1
	local FORMATO=$?
	if [ $FORMATO -ne 3 ]
	then
		echo "$VAL1/$VAL2/$ANO"
	else
		echo "Formato de Data Invalido"
	fi
}

DataExtenso () {
	RetornaFormato $1
	local RETURN_FORM=$?
	case $RETURN_FORM in
		0)
			local DIA=$VAL1
			local MES=$VAL2
			;;
		1)
			local DIA=$VAL2
			local MES=$VAL1
			;;
		2)
			local FORMATO=0
			until [ "$FORMATO" = 1 -o "$FORMATO" = 2 ]
			do
				echo
				echo "Impossível determinar o padrão de data."
				echo "1 - BR (DD/MM/YYYY)"
				echo "2 - US (MM/DD/YYYY)"
				read -p "Informe o formato (1 ou 2): " FORMATO
				case $FORMATO in
					1)
						local DIA=$VAL1
						local MES=$VAL2
						;;
					2)
						local DIA=$VAL2
						local MES=$VAL1
						;;
					*)
						echo "Opção Invalida"
						;;
				esac
			done
			echo
			;;
		3)
			echo "Opação de Data Invalido"
			exit 3
			;;
	esac

	case $MES in
		01)
		       	local MESEXT=Janeiro
			;;
		02)
		       	local MESEXT=Fevereiro
			;;
		03)
		       	local MESEXT=Março
			;;
		04)
		       	local MESEXT=Abril
			;;
		05)
		       	local MESEXT=Maio
			;;
		06)
		       	local MESEXT=Junho
			;;
		07)
		       	local MESEXT=Julho
			;;
		08)
		       	local MESEXT=Agosto
			;;
		09)
		       	local MESEXT=Setembro
			;;
		10)
		       	local MESEXT=Outubro
			;;
		11)
		       	local MESEXT=Novembro
			;;
		12)
		       	local MESEXT=Dezembro
			;;
	esac
echo "$DIA de $MESEXT de $ANO"
}

################################
# INICIO DO FLUXO DO SCRIPT    #
################################
case $1 in
	"-f")
		RetornaFormato $2
		echo $?
		;;
	"-i")
		InverteDiaMes $2
		;;
	"-b")
		IncluiiBarra $2
		;;
	"-e")
		DataExtenso $2
		;;
	"--help")
		echo "Uso $0 <opção> <data>"
		echo
		echo "Data nos formatos DDMMYYYY ou MMDDYYYY, com ou sem /"
		echo
		echo "Opções: "
		echo "-f = Retorna 0 para BR, 1 para US e 2 quando impossível determinar, 3 Inválido"
		echo "-i = Inverte formato BR para US e US para BR. Inclui as barras"
		echo "-b = Inclui Barras de data. Exemplo: de 13081981 para 13/08/1981"
		echo "-e = Exibe a data em formato extenso. Exemplo de 13081981 para 13 de Agosto de 1981"
		;;
	*)
		echo "Uso indevido. Use $0 --help"
		;;
esac
