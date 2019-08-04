#!/bin/bash

# We don’t want you to use the DHCP service of your machine. You’ve got to
# configure it to have a static IP and a Netmask in \30.

# Мы не хотим, чтобы вы использовали службу DHCP вашей машины. Вы должны
# настроить его на статический IP-адрес и маску сети в \30.

# ----------------------------
# Для того чтобы изменить настройки сетевых интерфейсов нужно отредактировать
# системный файл `/etc/network/interfaces`.


echo "Для того чтобы изменить настройки сетевых интерфейсов нужно";
echo "отредактировать системный файл `/etc/network/interfaces`.";
echo "В нем есть строка с описанием работы интернет-интрефейса, что-то типа:";
echo "`iface enp0s3 inet dhcp`";
echo "Нам нужно заменить `dhcp` на `static`, а затем добавить его описание:";
echo -e "\taddress\tнаш._ip.ад_.рес";
echo -e "\tnetmask\t255.255.255.252";
echo -e "\tgateway\tтек.ущая.маска.подсети";
echo -e "\tnameserver\t8.8.8.8";
echo
echo "Затем нужно будет перезапустить сетеволй интерфейс c помощью команды:";
echo "`sudo -S systemctl restart networking`"
echo "или перезагрузиться."
echo
read -p "Хотите чтобы скрипт сделал это (но, возможно, и сломает)? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo sed 's/dhcp/static/g' /etc/network/interfaces
sudo echo -e "\taddress\tнаш._ip.ад_.рес\n" >> /etc/network/interfaces
sudo echo -e "\tnetmask\t255.255.255.252\n" >> /etc/network/interfaces
sudo echo -e "\tgateway\tтек.ущая.маска.подсети\n" >> /etc/network/interfaces
sudo echo -e "\tnameserver\t8.8.8.8\n" >> /etc/network/interfaces
sudo systemctl restart networking

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";
exit
