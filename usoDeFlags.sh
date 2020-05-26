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
	
	echo -e "\033[01;37;42mChave ligada\033[00m"
}

setFgAndBgFlagOff () {
	
	echo -e "\033[01;37;41mChave desligada\033[00m"
}

checkFlagStatus () {
	
	if [ $FLAG -eq 0 ]
	then
		setFgAndBgFlagOff
	else
		setFgAndBgFlagOn
	fi
}

systemBoot () {

	local MARKING=">"

	for progress in $(seq 1 20)
	do
		clear
		echo "Processo de inicialização do sistema: $MARKING"
		sleep 1
		MARKING+=">"
	done

	FLAG=1
}

completionSystem () {
	
	local MARKING=">"

	for progress in $(seq 1 10)
	do
		clear
		echo "Processo de finalização do sistema: $MARKING"
		sleep 1
		MARKING+=">"
	done

	FLAG=0	
}

until [ $CHOICE -eq 0 ]
do
	clear
	echo
	echo "Estado atual da chave: $FLAG"
	echo
	echo "Liga ou Desliga Sistema"
	echo
	echo "	1-Liga"
	echo "	2-Desliga"
	echo
	echo "	0-Sair"
	echo
	read -p "Escolha a opção desejada: " CHOICE
	echo

	case $CHOICE in
	
		1) systemBoot
			clear
			checkFlagStatus
			sleep 3
			continue
			;;
	
		2) completionSystem
			clear
			checkFlagStatus
			sleep 3
			continue
			;;	

		0) echo "-- FIM --"
			break
			;;

		*) echo "Opção inválida. Tente novamente."
			sleep 1
			continue
			;;

	esac

done
