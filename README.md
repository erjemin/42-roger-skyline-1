# roger-skyline-1 #

Задание (проект) roger-skyline-1 (42 association / 21 school).

## 01. VM Part ##

* Если вы делаете задание дома: Загружаем Oracle VirtualBox 6.x -- *[по ссылке](https://www.virtualbox.org/wiki/Downloads)*.
* Если вы делаете задание дома: Устанавливаем Oracle VirtualBox 6.x v нашу операционную систему.
* Звгружаем ISO-образ установочного CD-диска Debian GNU/Linux. Текущая (последняя) версия -- **debian 10.0.0  amd64 NetInst** -- *[по ссылкеe](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/)*.
* Запускаем Oracle VirtualBox и [следуем инструкциям](00-VM/README.md). 

## 02. Network and Security Part

1. Создаём пользователя ([скрипт A](01-network-and-security/01a-add-user.sh), затем [скрипт B](01-network-and-security/01b-add-user.sh)).
2. Включаем для него sudo ([скрипт A](01-network-and-security/02a-sudo.sh), затем [скрипт B](01-network-and-security/02b-sudo.sh))
3. Настроить сетевой интрефейс -- убрать dhcp и установить сетевую маску ([скрпит](01-network-and-security/03-make-DHCP-of_and-set-mask.sh))
4. Сделать   SSH-доступ с RSA-ключами, перенастроить SSH-порты сервера и запретить логин root через SSH ([скрипт для сервера](01-network-and-security/04a-set-SSH-port-and-lock-root-login.sh) и [скрипт для клиента](01-network-and-security/04b-set-SSH-RSA-security-keys.sh) )