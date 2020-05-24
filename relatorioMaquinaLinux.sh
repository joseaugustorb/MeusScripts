#!/bin/bash

#################################################################
#								#
# Informações básicas de hardware e de sistema Linux       	#
#							   	#
# Nome: relatorioMaquinaLinux.sh			   	#
#							   	#
# Autor: José Augusto Biaggio				   	#
#							   	#
# Data: 24/05/2020					   	#
#							   	#
# Descrição: relatório com informações básicas de hardware 	#
# 	e sistema. Essas informações podem ser acessadas   	#
#	pela GUI dos sistemas Linux GNOME: Configurações->	#
# 	Detalhes->Sobre						#
#								#
# Uso: sudo ./relatorioMaquinaLinux.sh				#
#								#
#################################################################

NOMEDODISPOSITIVO=$(cat /etc/hostname)
MEMORIAPRINCIPAL=$(sed -n 1p /proc/meminfo | sed 's/ //g' | cut -d":" -f2)
PROCESSADOR=$(grep "model name" /proc/cpuinfo | sort -u | sed 's/\t//g' | cut -d":" -f2)
GRAFICOS=$(lspci | grep "VGA" | cut -d":" -f3)
GNOME=$(gnome-shell --version | awk {'print $3'})
TIPODOSO=$(file /bin/bash | awk {'print $3'})
DISCO=$(fdisk -l /dev/sda | grep "Disco /dev/sda" | awk {'print $3'} )

echo "============================================================="
echo "Nome do dispositivo: $NOMEDODISPOSITIVO"
echo "Memória Principal: $MEMORIAPRINCIPAL"
echo "Processador: $PROCESSADOR"
echo "Gráficos: $GRAFICOS"
echo "GNOME: $GNOME"
echo "Tipo do SO: $TIPODOSO"
echo "Disco: $DISCO GB"
echo "============================================================="

