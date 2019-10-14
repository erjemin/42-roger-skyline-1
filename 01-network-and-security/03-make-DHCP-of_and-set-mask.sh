#!/bin/bash

# We don’t want you to use the DHCP service of your machine. You’ve got to
# configure it to have a static IP and a Netmask in \30.

# Мы не хотим, чтобы вы использовали службу DHCP вашей машины. Вы должны
# настроить его на статический IP-адрес и маску сети в \30.

# ----------------------------
# Для того чтобы изменить настройки сетевых интерфейсов нужно отредактировать
# системный файл `/etc/network/interfaces`.

echo "1. Отключить службу DHCP (клиент).";
echo "2. Настроить статический IP-адрес.";
echo "3. Установть маску сети в \30.";

export IPADD="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"
export GATEW="$(ip route | awk '(NR == 2)' | awk '{ print $1 }'  | cut -d / -f 1)"
export WAN="$(ip add | grep 'BROADCAST' |  awk '{print $2}' | cut -d ':' -f 1)"

echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";
echo "Для того чтобы изменить настройки сетевых интерфейсов нужно";
echo "отредактировать системный файл `/etc/network/interfaces`.";
echo "В нем есть строка с описанием работы интернет-интрефейса, что-то типа:";
echo "iface enp0s3 inet dhcp";
echo "Нам нужно заменить `dhcp` на `static`, а затем добавить описание";
echo "сетевого подключения:";
echo -e "\taddress\t\t${IPADD}";
echo -e "\tnetmask\t\t255.255.255.252";
echo -e "\tgateway\t\t${GATEW}";
echo -e "\tnameserver\t8.8.8.8";
echo
echo "Затем нужно будет перезапустить сетеволй интерфейс c помощью команды:";
echo "";
echo "sudo -S systemctl restart networking"
echo "";
echo "или отключить а затем включить соответсвующее сетевое соединение:"
echo "";
echo "sudo ifdown $WAN";
echo "sudo ifup $WAN";
echo "";
echo "или перезагрузиться."
echo
read -p "Хотите чтобы скрипт сделал это (возможно, и сломает)? (Y/N):" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

INTRF="$(sudo sed 's/dhcp/static/g' /etc/network/interfaces)"
echo -e "${INTRF}" > /etc/network/interfaces
echo -e "\taddress\t\t${IPADD}"  >> /etc/network/interfaces
echo -e "\tnetmask\t\t255.255.255.252"  >> /etc/network/interfaces
echo -e "\tgateway\t\t${GATEW}"  >> /etc/network/interfaces
echo -e "\tnameserver\t8.8.8.8"  >> /etc/network/interfaces

echo "";
echo "Полезное чтение: https://serveradmin.ru/nastroyka-seti-v-debian/";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";

sudo -S systemctl restart networking
#
# А еще надежнее просто отключить соответсвующее сетевое соединение и после включить назад
# sudo ifdown $WAN
# sudo ifup $WAN
#

exit
