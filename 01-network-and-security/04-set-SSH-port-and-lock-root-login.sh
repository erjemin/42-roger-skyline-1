#!/bin/bash

# You have to change the default port of the SSH service by the one of your
# choice. SSH access HAS TO be done with publickeys. SSH root access
# SHOULD NOT be allowed directly, but with a user who can be root.

# Вы должны изменить порт по умолчанию службы SSH на тот, который вы выберете.
# SSH-доступ ДОЛЖЕН быть сделан с помощью публичнных ключей. Root-доступ по SSH
# НЕ ДОЛЖЕН быть разрешен напрямую (через-root), но с пользователем,
# который может быть пользователем root.

echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ С ПРАВАМИ АДМИНИСТРАТОРА (ИЗ ПОД SUDO).";
echo "";
echo "1. Переключаем SSH-сервер с порта 22 (по умолчанию) на порт 2002.";
echo "   -----------------------------------------------------------------";
echo "   Чтобы поменять порт, который слушает SSH-сервер нужно в системном";
echo "   конфигурационном файле '/etc/ssh/sshd_config' указать необходимый";
echo "   порт (по умолчению значение закоментировано '#Port 22'),  и запи-";
echo "   сать, например, вот так -- 'Port 2002'.";
echo "";
echo "2. Запретить пользователю root вход через SSH.";
echo "  ------------------------------------------------------------------";
echo "  Вход root через SSH в текущей версии Debian запрещен по умолчанию.";
echo "  Но можно запретить это явно. Для этого в том же системном конфигу-";
echo "  рационном файле  '/etc/ssh/sshd_config'  нужно устноавить значение";
echo "  'PermitRootLogin' в 'no' (по умолчанию срока назначения закоменти-";
echo "  рована '#PermitRootLogin prohibit-password').";
echo "";
echo "3. Перезапустить SSH-сервер, чтобы установки выступиои в силу.";
echo "  ------------------------------------------------------------------";
echo "  Выполнить компанду 'sudo service sshd restart'.";
echo "";
echo "";
echo "";

read -p "Хотите чтобы скрипт сделал это (возможно, и сломает)? (Y/N):" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

INTRF="$(sudo sed -e 's/#Port 22/Port 2002/g' -e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config)"
echo -e "${INTRF}" > /etc/ssh/sshd_config
sudo service sshd restart

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";