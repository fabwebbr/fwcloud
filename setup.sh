#!/bin/bash
#$FILE=`source fw.conf`

[ -f "fw.conf" ] && {
echo "A configuração já existe"
exit 
}

ShowOptions(){
clear
echo "---------------------------------------------------------"
echo "      Bem vindo!"
echo "O que você deseja fazer?"
echo "1) Instalar Apache, MySQL e PHP"
echo "x) Cancelar"
echo "---------------------------------------------------------"
read -p "O que deseja fazer? " fn
case $fn in
"1") Install_Lamp ;;
[qQxX]) clear; exit;;
esac
}



echo "O arquivo não existe"
read -p "Deseja criar o arquivo? (y/n) " yn
case $yn in
[YyYesyes]) ShowOptions 
;;
[NnNono]) exit;;
esac

