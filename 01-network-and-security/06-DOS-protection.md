# DOS protection / Защита от DoS

You have to set a DOS (Denial Of Service Attack) protection on your open ports of your VM.

Вы должны установить защиту DOS (атака отказа в обслуживании) на открытые порты вашей виртуальной машины.

---------

DoS и DDoS-атака -- это агрессивное внешнее воздействие на сервер, проводимое с целью перегрузить егозапросами, и доведения его до отказа или брутфорс-взлома (brute force -- грубая сила, например подбор паролей перебором и т.п.).

Если атака проводится с одиночного компьютера -- ее называют DoS (Denial of Service), если с нескольких, распределенных в сети, компьютеров — DDoS (Distributed Denial of Service).

Защиту от DoS отлично обеспечивает пакет `fail2ban`. Уствановим его:

```bash
sudo apt-get install fail2ban
```  

Служба fail2ban будет запущена автоматически. Проверим это: 

```bash
sudo service fail2ban status
```

И в ответ получим что-то типа:
```txt
● fail2ban.service - Fail2Ban Service
   Loaded: loaded (/lib/systemd/system/fail2ban.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-10-16 18:37:08 MSK; 4min 12s ago
     Docs: man:fail2ban(1)
 Main PID: 1817 (fail2ban-server)
    Tasks: 3 (limit: 846)
   Memory: 17.3M
   CGroup: /system.slice/fail2ban.service
           └─1817 /usr/bin/python3 /usr/bin/fail2ban-server -xf start

окт 16 18:37:08 web001 systemd[1]: Starting Fail2Ban Service...
окт 16 18:37:08 web001 systemd[1]: Started Fail2Ban Service.
окт 16 18:37:08 web001 fail2ban-server[1817]: Server ready
окт 16 18:37:09 web001 systemd[1]: /lib/systemd/system/fail2ban.service:12: PIDFile= references path below legacy directory /var/run/, up
```

По умолчанию, у `fail2ban` довольно развесистые правила. Они находятся в каталоге fail2ban/ в файле `/etc/fail2ban/jail.conf`.




https://debian.pro/179

кастомный fail2ban
https://habr.com/ru/post/238303/

Как альтернатву fail2ban можно использовать Denyhosts (http://denyhosts.sourceforge.net/). 
