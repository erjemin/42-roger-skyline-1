#!/bin/bash

# You have to set a protection against scans on your VM’s open ports.

# Вы должны установить защиту от сканирования на открытых портах вашей
# виртуальной машины.


echo "Настройка защиты от сканирования: с помощью portsentry";
echo "";
echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";

## Объявление переменных ===========================================================
## IPT    -- расположение iptables (обычно /usr/sbin/iptables')
export IPT="$(sudo -S which iptables)"
## WAN_IP -- IP-адрес нашей машины
export WAN_IP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"
## WAN_IPP -- IP-адрес нашей машины с подсеткой
export WAN_IPP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}')"
## SSH_CONNECT_IP -- IP-адрес с которого осуществелно текущее SSH-соединение
export SSH_CONNECT_IP="$(sudo netstat -tnpa | grep 'ESTABLISHED.*sshd' | awk '{print $5}'  | cut -d ':' -f 1)"
#export SSH_CONNECT_IP="$(w | awk '{print $3}' | awk '(NR == 3)')"
export DT="$(date +%Y-%m-%d_%k:%M:%S)"

sudo -S apt-get install portsentry
echo "";
echo "УСТАНОВЛЕН portsentry";
echo "";

echo "Создаем файл конфигураций.";
echo "";

if [[ -f "/etc/portsentry/portsentry.conf" ]]; then
  sudo -S cp /etc/portsentry/portsentry.conf /etc/portsentry/portsentry.conf_$DT.old
  echo "Старый конфиг ==> '/etc/portsentry/portsentry.conf'";
  echo "скопирован в  ==> '/etc/portsentry/portsentry.conf_$DT.old'.";
  echo "";
fi

echo "==новый /etc/portsentry/portsentry.conf=======================";
echo "########################" > /etc/portsentry/portsentry.conf
echo "# Конфигурации портов  #" >> /etc/portsentry/portsentry.conf
echo "########################" >> /etc/portsentry/portsentry.conf
echo "TCP_PORTS=\"1,11,15,79,111,119,143,540,635,1080,1524,2000,5742,6667,12345,12346,20034,31337,32771,32772,32773,32774,40421,49724,54320\"" >> /etc/portsentry/portsentry.conf
echo "UDP_PORTS=\"1,7,9,69,161,162,513,635,640,641,700,32770,32771,32772,32773,32774,31337,54321\"" >> /etc/portsentry/portsentry.conf
echo "#######################################################" >> /etc/portsentry/portsentry.conf
echo "# Расширенные опции обнаружения скрытого сканирования #" >> /etc/portsentry/portsentry.conf
echo "#######################################################" >> /etc/portsentry/portsentry.conf
echo "ADVANCED_PORTS_TCP=\"1024\"" >> /etc/portsentry/portsentry.conf
echo "ADVANCED_PORTS_UDP=\"1024\"" >> /etc/portsentry/portsentry.conf
echo "ADVANCED_EXCLUDE_TCP=\"113,139\"" >> /etc/portsentry/portsentry.conf
echo "ADVANCED_EXCLUDE_UDP=\"520,138,137,67,161\"" >> /etc/portsentry/portsentry.conf
echo "##########################" >> /etc/portsentry/portsentry.conf
echo "# Конфигурационные файлы #" >> /etc/portsentry/portsentry.conf
echo "##########################" >> /etc/portsentry/portsentry.conf
echo "IGNORE_FILE=\"/etc/portsentry/portsentry.ignore\"" >> /etc/portsentry/portsentry.conf
echo "HISTORY_FILE=\"/var/lib/portsentry/portsentry.history\"" >> /etc/portsentry/portsentry.conf
echo "BLOCKED_FILE=\"/var/lib/portsentry/portsentry.blocked\"" >> /etc/portsentry/portsentry.conf
echo "##################################" >> /etc/portsentry/portsentry.conf
echo "# Разное: Параметры конфигурации #" >> /etc/portsentry/portsentry.conf
echo "##################################" >> /etc/portsentry/portsentry.conf
echo "RESOLVE_HOST=\"0\"" >> /etc/portsentry/portsentry.conf
echo "#######################" >> /etc/portsentry/portsentry.conf
echo "# Опции игнорирования #" >> /etc/portsentry/portsentry.conf
echo "#######################" >> /etc/portsentry/portsentry.conf
echo "BLOCK_UDP=\"1\"" >> /etc/portsentry/portsentry.conf
echo "BLOCK_TCP=\"1\"" >> /etc/portsentry/portsentry.conf
echo "###################" >> /etc/portsentry/portsentry.conf
echo "# Сброс маршрутов #" >> /etc/portsentry/portsentry.conf
echo "###################" >> /etc/portsentry/portsentry.conf
echo "KILL_ROUTE=\"$IPT -I INPUT -s \$TARGET\$ -j DROP && $IPT -I INPUT -s \$TARGET\$ -m limit --limit 3/minute --limit-burst 5 -j LOG --log-level DEBUG --log-prefix 'Portsentry: dropping: '\"" >> /etc/portsentry/portsentry.conf
echo "##########################" >> /etc/portsentry/portsentry.conf
echo "# TCP Обертки (Wrappers) #" >> /etc/portsentry/portsentry.conf
echo "##########################" >> /etc/portsentry/portsentry.conf
echo "KILL_HOSTS_DENY=\"ALL: \$TARGET\$\"" >> /etc/portsentry/portsentry.conf
echo "###################################" >> /etc/portsentry/portsentry.conf
echo "# Значение триггеров сканирования #" >> /etc/portsentry/portsentry.conf
echo "###################################" >> /etc/portsentry/portsentry.conf
echo "SCAN_TRIGGER=\"2\"" >> /etc/portsentry/portsentry.conf
echo "###################################" >> /etc/portsentry/portsentry.conf
echo "# Секция заголовка (banner) порта #" >> /etc/portsentry/portsentry.conf
echo "###################################" >> /etc/portsentry/portsentry.conf
echo "PORT_BANNER=\"                       .-.    КОШКА-ПАРАНОИДОШКА:" >> /etc/portsentry/portsentry.conf
echo "                       | |    НЕ ЛЮБИТ STEALTH-SCAN" >> /etc/portsentry/portsentry.conf
echo "                       | |    И ЛОВИТ ИХ ПО УГЛАМ!" >> /etc/portsentry/portsentry.conf
echo "     /\\---/\\   _,---._ | |" >> /etc/portsentry/portsentry.conf
echo "    /-   -  \\,'       \`. ;" >> /etc/portsentry/portsentry.conf
echo "   ( O   O   )           ;" >> /etc/portsentry/portsentry.conf
echo "    '.=o=__,'            \\" >> /etc/portsentry/portsentry.conf
echo "    /         _,--.__  _  \\" >> /etc/portsentry/portsentry.conf
echo "   /  _ )   ,'      -.  -. \\" >> /etc/portsentry/portsentry.conf
echo "  / ,' /  ,'          \\ \\ \\ \\" >> /etc/portsentry/portsentry.conf
echo " / /  / ,'            (,_)(,_)" >> /etc/portsentry/portsentry.conf
echo "(,;  (,,)\"" >> /etc/portsentry/portsentry.conf
echo "# EOF" >> /etc/portsentry/portsentry.conf
cat /etc/portsentry/portsentry.conf
echo "";
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
echo "";
echo "=============================================================";
echo "";
sudo service portsentry restart
echo "РЕСТАРТ portsentry";
echo "";
echo "=============================================================";
echo "";
echo "СТАТУС portsentry";
echo "";
sudo service portsentry status
echo "";
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
