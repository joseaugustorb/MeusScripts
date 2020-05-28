#!/bin/bash

#########################################################
#							#
# Simula processos de ligar e desligar um sistema	# 
#		com o uso de flags.			#
#							#
# Nome: usoDeFlags.sh					#
#							#
# Autor: José Augusto Biaggio				#
#							#
# Data: 26/05/2020					#
#							#
# Descrição: script feito com o intuito de praticar	#
#	o conceito de chaves(flags). Esse script	#
#	realiza a simulação de ligar e desligar um	#
#	sistema, observando o comportamento da flag	#
#	quando alguma dessas ações ocorrem.		#
# 							#
# Uso: ./usoDeFlags.sh					#
#							#
#########################################################

FLAG=0	# chave do sistema (0 desliga, 1 liga)
CHOICE=1

setFgAndBgFlagOn () {
	
	setFgAndBgOfAnyString 01 37 42 "Chave ligada"
}

setFgAndBgFlagOff () {
	
	setFgAndBgOfAnyString 01 37 41 "Chave desligada"
}

setFgAndBgOfAnyString () {
		
	STRING=$@	# "$@" parâmetro que armazena em forma de string todos os parâmetros ($1, $2, ...) passados ao chamar a função

	COUNTCHARACTERS=$(echo "$STRING" | sed 's/[a-z A-Z]\+//g' | wc --chars) 	# sed usado para remover letras alfabéticas, minúsculas e maiúsculas

	if [ "$COUNTCHARACTERS" = 3 ]
	then
		echo -e " \033[$1m $2 \033[00m "
		
	elif [ "$COUNTCHARACTERS" = 5 ]
	then
		echo -e " \033[$1;$2m $3 \033[00m "
	
	elif [ "$COUNTCHARACTERS" = 7 ]
	then
		echo -e " \033[$1;$2;$3m $4 \033[00m "
	fi
}

changesFgAndBgFlag () {
	
	if [ $FLAG -eq 0 ]
	then
		setFgAndBgFlagOff
	else
		setFgAndBgFlagOn
	fi
}

systemBoot () {

	local MARKING=">"
	local PORCENT=0

	for progress in $(seq 0 20)
	do
		clear
		echo -e " Processo de inicialização do sistema: \033[01;33m$MARKING\033[00m $PORCENT%"
		sleep 1
		PORCENT=$(expr $PORCENT + 5)
		MARKING+=">"
	done

	FLAG=1
}

completionSystem () {
	
	local MARKING=">"
	local PORCENT=0

	for progress in $(seq 0 10)
	do
		clear
		echo -e " Processo de finalização do sistema: \033[01;33m$MARKING\033[00m $PORCENT%"
		sleep 1
		PORCENT=$(expr $PORCENT + 10)
		MARKING+=">"
	done

	FLAG=0	
}

checkFlagStatus () {

	if [ $FLAG -eq 1 ]
	then
		setFgAndBgOfAnyString 01 37 42 "Chave ligada"
	else
		setFgAndBgOfAnyString 01 37 41 "Chave desligada"
	fi
}

checkIfFlagStatusOn () {
	
	if [ $FLAG -eq  1 ]
	then	
		setFgAndBgOfAnyString 01 37 43 "O sistema já está ligado"
	else	
		systemBoot	
		changesFgAndBgFlag
	fi
}

checkIfFlagStatusOff () {
	
	if [ $FLAG -eq  0 ]
	then
		setFgAndBgOfAnyString 01 37 43 "O sistema já está desligado"
	else	
		completionSystem
		changesFgAndBgFlag
	fi
}

until [ $CHOICE -eq 0 ]
do
	clear 
	echo
	echo " Estado atual da chave:$(checkFlagStatus)"
	echo
	echo " Liga ou Desliga Sistema"
	echo
	echo "	 1-Liga"
	echo "	 2-Desliga"
	echo
	echo "	 0-Sair"
	echo
	read -p " Escolha a opção desejada: " CHOICE
	echo

	case $CHOICE in
	
		1) clear
			checkIfFlagStatusOn
			sleep 3
			continue
			;;
	
		2) clear
			checkIfFlagStatusOff
			sleep 3
			continue
			;;	

		0) echo " -- FIM --"
			echo
			break
			;;

		*) echo "Opção inválida. Tente novamente."
			sleep 1
			continue
			;;

	esac
done
