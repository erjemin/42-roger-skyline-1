#!/bin/bash

# You have to set the rules of your firewall on your server only with the
# services used outside the VM.

# Вы должны установить правила брандмауэра на своем сервере только
# с сервисами, используемыми вне виртуальной машины.

echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";

# Установим пакет iptables (если он уже установлен, попытка повторной уствновки "проскочит"
sudo -S apt-get install iptables
sudo -S apt-get install iptables-persistent

# Объявление переменных
export IPT  ="/usr/sbin/iptables"
export WAN  ="$(ip add | grep 'BROADCAST' |  awk '{print $2}' | cut -d ':' -f 1)"
export WAN_IP   ="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"
export WAN_IP6  ="$(ip ad | grep 'inet6 ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"

# Очистка всех цепочек iptables
$IPT -F
$IPT -F -t nat
$IPT -F -t mangle
$IPT -X
$IPT -t nat -X
$IPT -t mangle -X

# Установим политики по умолчанию (DROP) для трафика, не соответствующего
# ни одному из правил
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP

# Разрешаем локальный траффик для loopback
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# Разрешаем пинги
$IPT -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Разрешаем исходящие соединения самого сервера
$IPT -A OUTPUT -o $WAN -j ACCEPT

# Состояние ESTABLISHED говорит о том, что это не первый пакет в соединении.
# Пропускать все уже инициированные соединения, а также дочерние от них.
# Так мы разрешим использование текущего порта на который настроен и
# открыт, в настощий момент, SSH.
$IPT -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
# Разрешить новые, а так же уже инициированные и их дочерние соединения
$IPT -A OUTPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
# Разрешить форвардинг для уже инициированных и их дочерних соединений
$IPT -A FORWARD -p all -m state --state ESTABLISHED,RELATED -j ACCEPT

# Включаем фрагментацию пакетов. Необходимо из-за разных значений MTU
$IPT -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

# Отбрасывать все пакеты, которые не могут быть идентифицированы
# и поэтому не могут иметь определенного статуса.
$IPT -A INPUT -m state --state INVALID -j DROP
$IPT -A FORWARD -m state --state INVALID -j DROP

# Приводит к связыванию системных ресурсов, так что реальный
# обмен данными становится не возможным, обрубаем
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
$IPT -A OUTPUT -p tcp ! --syn -m state --state NEW -j DROP

# Открываем порт для SSH на тот случай, если скрипт будет запущен
# не из терминала по SSH, а непосредственно из консоли виртуального
# серверв (!!!не забудьте указать свой порт, который вы указали для SSH ранее!!!)
$IPT -A INPUT -i $WAN -p tcp --dport 2002 -j ACCEPT
# Открываем порт для web сервера (для http)
$IPT -A INPUT -i $WAN -p tcp --dport 80 -j ACCEPT
# Открываем порт для web сервера (для https)
$IPT -A INPUT -i $WAN -p tcp --dport 443 -j ACCEPT

# Записываем правила в файл
/sbin/iptables-save > /etc/iptables_rules

# sudo apt-get install iptables-persistent

## Step 8
# Execute iptables.sh script to configure iptables rules
# ./iptables.sh

# apt-get install iptables
# /usr/sbin/iptables -?

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";