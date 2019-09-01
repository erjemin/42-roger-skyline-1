#!/bin/bash

# You have to change the default port of the SSH service by the one of your
# choice. SSH access HAS TO be done with publickeys. SSH root access
# SHOULD NOT be allowed directly, but with a user who can be root.

# Вы должны изменить порт по умолчанию службы SSH на тот, который вы выберете.
# SSH-доступ ДОЛЖЕН быть сделан с помощью публичнных ключей. Root-доступ по SSH
# НЕ ДОЛЖЕН быть разрешен напрямую (через-root), но с пользователем,
# который может быть пользователем root.

echo "ЭТОТ СКРИПТ НУЖНО ЗАПУСКАТЬ НА КЛИЕНТЕ.";
echo "";
echo "1. Создем и обмениваемся RSA-ключами с сервером";
echo "   ------------------------------------------------------------------";
echo "   Создает RSA-ключи коменда 'ssh-keygen'. По умолчанчанию, приватная";
echo "   часть RSA-ключа шифрования в папке '~/.ssh/id_rsa', открытая часть";
echo "   ключа -- в '~/.ssh/id_rsa.pub'.  Нужно добавить наш открытый ключ";
echo "   с клиента на сервер, в файл '~/.ssh/authorized_keys':";
echo "";
echo '   cat ~/.ssh/id_rsa.pub | ssh [user]@[ip_address_server] \ ';
echo '       "cat >> ~/.ssh/authorized_keys"';
echo "";
echo "";

read -p "Хотите чтобы скрипт сделал это (возможно, и сломает)? (Y/N):" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

ssh-keygen
cat ~/.ssh/id_rsa.pub | ssh web@192.168.1.35 "cat >> ~/.ssh/authorized_keys"

echo "";
echo " _._     _,-'\"\"\`-._";
echo "(,-.\`._,'(       |\\\`-/|";
echo "    \`-.-' \\ )-\`( , o o)";
echo "          \`-    \\\`_\`\"'-  Mi-mi-mi... Ok!";
echo "";