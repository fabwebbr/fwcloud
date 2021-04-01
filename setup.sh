#!/bin/bash
######################################################
# Script básico para gerenciamento de servidores
#  Linux com Apache, MySQL
######################################################

DIR="/usr/local/fwsys"

Install_Lamp(){
    [ ! -f "fw.conf" ] && echo "Antes de instalar os serviços, execute a opção 2 do menu anterior"; clear; 
    /usr/bin/apt update -y
    /usr/bin/apt install apache2 -y
    a2enmod rewrite && a2enmod deflate && a2enmod expires && a2enmod http2 && a2enmod proxy && a2enmod proxy_fcgi && a2enmod ssl
    /usr/bin/systemctl reload apache2
    /usr/bin/apt install mysql-server mysql-client -y
    echo ""
    echo ""
    echo ""
    sleep 2
    clear
    read -p "Defina a senha de root mysql: " senha_mysql
    echo password_mysql=$senha_mysql >> /usr/local/fwsys/fw.conf 
    mysql_secure_installation; N; $senha_mysql; y; y; y; y;
    echo "Instalação ok"
    echo ""
    echo ""
}

Enable_FWSYS(){
    [ -f "$DIR/fw.conf" ] && {
    echo "A configuração já existe"
    exit 
    }
    cd /root/fw/
    mv fwsys /usr/local/
    cd /usr/local/fwsys
    [ ! -f "fw.conf" ] && echo FWSYS="/usr/local/fwsys/" >> $DIR/fw.conf
    echo SITE_DIR="/var/www/" >> $DIR/fw.conf
    for i in `ls $DIR`; do
    ln -s $DIR/$i /usr/bin/$i
    done
    read -p "Qual o e-mail do administrador do servidor? " mailadmin
    echo ADMIN_MAIL="$mailadmin" >> $DIR/fw.conf
    echo BACKUP_DIR="/var/backups" >> $DIR/fw.conf
    exit
}

clear
echo "---------------------------------------------------------"
echo "      Bem vindo!"
echo "O que você deseja fazer?"
echo "1) Instalar Sistema com Apache, PHP e MySQL"
echo "2) Habilitar fwsys"
echo "x) Cancelar"
echo "---------------------------------------------------------"
read -p "O que deseja fazer? " fn
case $fn in
"1") Install_Lamp ;;
"2") Enable_FWSYS ;;
[qQxX]) clear; exit;;
esac

