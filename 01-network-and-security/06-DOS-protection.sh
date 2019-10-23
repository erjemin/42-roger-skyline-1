#!/bin/bash

## You have to set a DOS (Denial Of Service Attack) protection on your
## open ports of your VM.

## Вы должны установить защиту DOS (атака отказа в обслуживании) на открытые
## порты вашей виртуальной машины.

echo "Настройка защиты от DOS-атак: с помощью fail2ban";
echo "";
echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";

## Установим пакет fail2ban (если он уже установлен, попытка повторной уствновки "проскочит")
sudo -S apt-get install fail2ban

## Объявление переменных ===========================================================
## WAN_IP -- IP-адрес нашей машины
export WAN_IP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}' | cut -d '/' -f1)"
## WAN_IPP -- IP-адрес нашей машины с подсеткой
export WAN_IPP="$(ip ad | grep 'inet ' | awk '(NR == 2)' | awk '{print $2}')"
## SSH_CONNECT_IP -- IP-адрес с которого осуществелно текущее SSH-соединение
export SSH_CONNECT_IP="$(sudo netstat -tnpa | grep 'ESTABLISHED.*sshd' | awk '{print $5}'  | cut -d ':' -f 1)"
#export SSH_CONNECT_IP="$(w | awk '{print $3}' | awk '(NR == 3)')"
## SSH_PORT -- текущий порт SSH
export SSH_PORT="$(sudo netstat -tnpa | grep 'ESTABLISHED.*sshd' | awk '{print $4}'  | cut -d ':' -f 2)"
export DT="$(date +%Y-%m-%d_%k:%M:%S)"

echo "";
echo "УСТАНОВЛЕН fail2ban";
echo "";
echo "Создаем файл конфигураций.  Не надо редактировать главный";
echo "настроечный файл jail.conf, для этого предусмотрены файлы";
echo "с расширением *.local,  которые подключатся автоматически";
echo "и имеют высший приоритет.";
echo "";

if [[ -f "/etc/fail2ban/jail.local" ]]; then
  sudo -S cp /etc/fail2ban/jail.local /etc/fail2ban/jail.local_$DT.old
  echo "Старый конфиг ==> '/etc/fail2ban/jail.local'";
  echo "скопирован в  ==> '/etc/fail2ban/jail.local_$DT.old'.";
  echo "";
fi

echo "== новый конфиг /etc/fail2ban/jail.local =====================";
echo "[DEFAULT]" > /etc/fail2ban/jail.local
echo "#email, на который присылать уведомления" >> /etc/fail2ban/jail.local
echo -e "destemail\t= root" >> /etc/fail2ban/jail.local
echo "# подключить прафила бана из '/etc/fail2ban/action.d/iptables-multiport.conf'" >> /etc/fail2ban/jail.local
echo -e "banaction\t= iptables-multiport" >> /etc/fail2ban/jail.local
echo "# исключаем из потенциального бана ip мащины и текущего ssh-подключения" >> /etc/fail2ban/jail.local
echo -e "ignoreip\t= $WAN_IP $SSH_CONNECT_IP" >> /etc/fail2ban/jail.local
echo "## или исключаем из потенциального бана всю подсеть" >> /etc/fail2ban/jail.local
echo -e "# ignoreip\t= $WAN_IPP" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "#### правила для SSH ####" >> /etc/fail2ban/jail.local
echo "[sshd]" >> /etc/fail2ban/jail.local
echo -e "enabled\t\t= true" >> /etc/fail2ban/jail.local
echo -e "port\t\t= ssh,$SSH_PORT" >> /etc/fail2ban/jail.local
echo "# подключить правила фильтрации из '/etc/fail2ban/filter.d/sshd.conf'" >> /etc/fail2ban/jail.local
echo -e "filter\t\t= sshd" >> /etc/fail2ban/jail.local
echo "# какой лог наблюдаем (на тот случай, если он не по умолчанию)" >> /etc/fail2ban/jail.local
echo -e "logpath\t\t= /var/log/auth.log" >> /etc/fail2ban/jail.local
echo "# баним на 20 минут (60*20=1200)" >> /etc/fail2ban/jail.local
echo -e "bantime\t\t= 1200" >> /etc/fail2ban/jail.local
echo "число попыток (5) и получаешь бан!" >> /etc/fail2ban/jail.local
echo -e "maxretry\t= 5" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
cat /etc/fail2ban/jail.local

# перезапустим fail2ban
sudo service fail2ban restart

# покажем (проверим) статус fail2ban
echo "==STATUS fail2ban============================================";
sudo service fail2ban status
echo "";

# покажем статус действий и фильтрацияfail2ban для SSHD
# с задержкой, т.к. правила фильрациимогли еще не успеть запуститься
read -n 1 -p "Нажмите любую клавишу для продолжения..."
echo "";
echo "";
echo "==STATUS fail2ban SSHD=======================================";
sudo fail2ban-client status sshd
echo "";
echo "=============================================================";

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";

