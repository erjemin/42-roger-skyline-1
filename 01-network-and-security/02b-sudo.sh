#!/bin/bash

# Use sudo, with this user, to be able to perform operation requiring special
# rights.

# Используйте sudo с этим пользователем, чтобы иметь возможность выполнять
# операции, требующие специальных прав.

# ----------------------------
# Для того чтобы добвыить пользователя `web` в sudoers (sudo) нужно добавить
# системный файл `/etc/sudoers` запись `web   ALL=(ALL:ALL) ALL`.

# --ЧАСТЬ B-------root--------
echo "---- Добавляем строчку:";
echo -e "---- "\nweb\tALL=(ALL:ALL) ALL\n";
echo "---- В системный файл:";
echo "---- /etc/sudoers";

sudo echo -e "\nweb\tALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";
echo "---- Выходим из root-режима";
echo "---- Ведите в команду 'exit' для выхода из root.";
echo "---- Из скрипта эта команда не сработает!";
exit
