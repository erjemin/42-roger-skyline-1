#!/bin/bash

# You have to set a protection against scans on your VM’s open ports.

# Вы должны установить защиту от сканирования на открытых портах вашей
# виртуальной машины.


echo "Настройка защиты от сканирования: с помощью portsentry";
echo "";
echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";

## Объявление переменных ===========================================================
## WAN_IP -- IP-адрес нашей машины
export WAN_IP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"
## WAN_IPP -- IP-адрес нашей машины с подсеткой
export WAN_IPP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}')"
## SSH_CONNECT_IP -- IP-адрес с которого осуществелно текущее SSH-соединение
export SSH_CONNECT_IP="$(sudo netstat -tnpa | grep 'ESTABLISHED.*sshd' | awk '{print $5}'  | cut -d ':' -f 1)"
#export SSH_CONNECT_IP="$(w | awk '{print $3}' | awk '(NR == 3)')"

echo "Настройки iptables и route управляют блокировками по портами, но";
echo "не предупреждает о UDP- и stealth-сканирований, которые обычно";
echo "предшествуют реальным атакам.";
echo "";
echo "Для определения и реакции на сканирования портов предназначен";
echo "пакет PortSentry (ранее назависимый разработч, а сейчас Cisco).";
echo "PortSentry в реальном времени обнаруживает сканирование";
echo "и отработать по одному из следующих сценариев:";
echo "  • Заносит информацию об инциденте в системный log-журнал";
echo "    '/var/log/syslog' -- сценарий по умолчанию.";
echo "  • Сканировующий хост заносится в файл '/etc/host.deny' для";
echo "    TCP Wrappers.";
echo "  • Перенастроить компьюьтер и перенаправлять весь трафик";
echo "    атакующего на несуществующий компьютер.";
echo "  • Перенастроить компьютер и блокировать атакующего пакетным";
echo "    фильтром.";
echo "";
sudo -S apt-get install portsentry

echo "==новый /etc/portsentry/portsentry.ignore.static=============";
echo "# /etc/portsentry/portsentry.ignore.static" > /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# Не трогайте 127.0.0.1 и 0.0.0.0 чтобы балалайка заработала!" >> /etc/portsentry/portsentry.ignore.static
echo "# Укажите разместите здесь хосты, которые вы никогда не будут" >> /etc/portsentry/portsentry.ignore.static
echo "# блокироваться. Включая IP-адреса всех локальных интерфейсов" >> /etc/portsentry/portsentry.ignore.static
echo "# на защищаемом хосте --  типа виртуальный хост, мультихоминг" >> /etc/portsentry/portsentry.ignore.static
echo "# (подключение к нескольким сетям) и т.п." >> /etc/portsentry/portsentry.ignore.static
echo "# Не трогайте 127.0.0.1 и 0.0.0.0 чтобы балалайка заработала!" >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# После запуска portsentry(8) через /etc/init.d/portsentry" >> /etc/portsentry/portsentry.ignore.static
echo "# этот файл будет объединен с portsentry.ignore." >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# PortSentry может также поддерживать полные маски сетей для" >> /etc/portsentry/portsentry.ignore.static
echo "# сетей. Формат:" >> /etc/portsentry/portsentry.ignore.static
echo "# <IP Address>/<Netmask>" >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# Напрмиер:" >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# 192.168.2.0/24" >> /etc/portsentry/portsentry.ignore.static
echo "# 192.168.0.0/16" >> /etc/portsentry/portsentry.ignore.static
echo "# 192.168.2.1/32" >> /etc/portsentry/portsentry.ignore.static
echo "# и так далее..." >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "# Если вы не указали маску сети, она должна быть 32-битной." >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "#" >> /etc/portsentry/portsentry.ignore.static
echo "127.0.0.1/32" >> /etc/portsentry/portsentry.ignore.static
echo "0.0.0.0" >> /etc/portsentry/portsentry.ignore.static
echo "$WAN_IP" >> /etc/portsentry/portsentry.ignore.static
echo "#$WAN_IPP" >> /etc/portsentry/portsentry.ignore.static
echo "$SSH_CONNECT_IP" >> /etc/portsentry/portsentry.ignore.static
cat /etc/portsentry/portsentry.ignore.static
echo "=============================================================";

sudo service portsentry restart
sudo service portsentry status
echo "=============================================================";

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";


# Я всегда рекомендую вам использовать пакетный фильтр, потому что это
# http://rus-linux.net/MyLDP/BOOKS/mourani/ch10_3.html
# Чтобы изменить поведение, отредактируйте файл /etc/portsentry/portsentry.conf.
#    Вероятно, следует также посмотреть:
#     /etc/default/portsentry (параметры запуска демона)
#     /etc/portsentry/portsentry.ignore.static (игнорируемые хосты/интерфейсы)
