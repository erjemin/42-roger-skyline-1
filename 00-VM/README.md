
## A. Inicializaciya ustanovki Debian v Oracle VirtualBox

**01.** Vybiraem punkt `Создать`.

![Vybiraem punkt \"Sozdat'\"](img/screen-01.png)

**02.** Zadayom nazyanie virtual'noj mashine, papku v kotoroj budut hranitsya fajly virtualki (obraz diska, snapshoty i t.p.).

![Zadaem nazyanie virtual'noj mashine, papku v kotoroj budut hranitsya fajly virtualki (obraz diska, snapshoty i t.p.)](img/screen-02.png)

**03.** Zadayom razmer operativnoj pamyati dlya virtual'noj mashiny (dostatochno 768Mb).

![Zadayom razmer operativnoj pamyati dlya virtual'noj mashiny (dostatochno 768Mb)](img/screen-03.png)

**04.** Ukazyvaem, chto nuzhno sozdat' chistyj (novyj) zhestkij disk pod virtualku. 

![Ukazyvaem, chto nuzhno sozdat' chistyj (novyj) zhestkij disk pod virtualku.](img/screen-04.png)

**05.** Zadayom tip fajla (format) virtual'noj mashiny. VHD -- predpochtitelen, esli posle planiruetsya perenosit' virtualku na \"boevoj\" server s Hyper-V.

![Zadayom tip fajla (format) virtual'noj mashiny. VHD -- predpochtitelen, esli posle planiruetsya perenosit' virtualku na \"boevoj\" server s Hyper-V](img/screen-05.png)

**06.** Zadyom, chto nuzhen dinamicheskij virtual'nyj disk (tak razmer fajla pod virtual'nyj disk budet minimal'ym).

![Zadyom, chto nuzhen dinamicheskij virtual'nyj disk (tak razmer fajla pod virtual'nyj disk budet minimal'ym)](img/screen-06.png)

**07.** Zadayom razmer diska virtual'noj mashine -- 8Gb.

![Zadayom razmer diska virtual'noj mashine -- 8Gb.](img/screen-07.png)

**08.** Vybiraem `Настроить`

![Vybiraem `Nastroit'`](img/screen-08.png)

**09.** Vybiraem `Носитель`, chtoby smontirovat' iso-obraz ustanovochnogo diska Debian kak ustrojstvo CD

![Vybiraem `Nositeli`, chtoby smontirovat' iso-obraz ustanovochnogo diska Debian kak ustrojstvo CD](img/screen-09.png)

**10.** Ukazyvaem, mesto raspolozheniya iso-obraza

![Ukazyvaem, mesto raspolozheniya iso-obraza](img/screen-10.png)


**11.** V nastrojkah `Сеть` ustanavlivaem podklyuchenie setevogo adaptera nashej virtual'noj mashiny v rezhime  `Сетевой мост`. Tak nashu virtual'nuyu mashinu budet vidno iz vneshnej seti, i pri nalichii vneshnego DHCP ona smozhet poluchat' IP-adres ot vneshnego DHCP-servera.    

![Ubezhdaemsya, chto v kachestve vtorichnogo mastera IDE ukazan iso-obraz ustanovochnogo diska Debian i zapuskaem virtual'nuyu mashinu knopkoj `Zapustit'`](img/screen-12.png)

**12.** Ubezhdaemsya, chto v kachestve vtorichnogo mastera IDE ukazan iso-obraz ustanovochnogo diska Debian, i zapuskaem virtual'nuyu mashinu knopkoj `Запустить'`. 

![Ubezhdaemsya, chto v kachestve vtorichnogo mastera IDE ukazan iso-obraz ustanovochnogo diska Debian i zapuskaem virtual'nuyu mashinu knopkoj `Zapustit'`](img/screen-11.png)

--------------

## B. Installyaciya Debian 10.0.x

**01.** Na pervom ekrane ustanovki Debian vybiraem punkt `Install`.

![alt](img/VirtualBox-Debian10-01-01.png)

**02.** Выбираем язык утановки `Russian - Руссий`. Dalee ustanovochnaya programmu budet rabotat' na russkom, tak zhe budet vybrana lokal' ustanvki `ru_RU.UTF-8`.
                                                   ![alt](img/VirtualBox-Debian10-01-02.png)
                                                   **03.** Vybiraem stranu mestopolozheniya `Российская Федерация`.

![alt](img/VirtualBox-Debian10-01-03.png)

**04.** Vybiraem lokalizaciyu i raskladuk klaviatury `Русская`. 

![alt](img/VirtualBox-Debian10-01-04.png)

**05.** Vybiraem sposob preklyucheniya yazyka na klaviature `Control+Shift`. 

![alt](img/VirtualBox-Debian10-01-05.png)

**06.** Nachinayut zagruzhat'sya dopolnitel'nye komponenty.

![alt](img/VirtualBox-Debian10-01-06.png)

**07.** Vvodim imya kompbyutera (ono budet prisvoeno v **hosts**).

![alt](img/VirtualBox-Debian10-01-07.png)

**08.** Vvodim domen, v kotorom raspolagaetsya komp'yuter. 

![alt](img/VirtualBox-Debian10-01-08.png)

**09.** Vvoodim root-parol'.

![alt](img/VirtualBox-Debian10-01-09.png)

**10.** Povtoryaem root-parol'.

![alt](img/VirtualBox-Debian10-01-10.png)

**11.** Vvodim polnoe imya pol'zovatelya. 

![alt](img/VirtualBox-Debian10-01-11.png)

**12.** Ukazyvaem login pol'zovatelya.

![alt](img/VirtualBox-Debian10-01-12.png)

**13.** Zadayom parol' pol'zovatelya. 

![alt](img/VirtualBox-Debian10-01-13.png)

**14.** Povtoryaem parol' pol'zovatelya.

![alt](img/VirtualBox-Debian10-01-14.png)

**15.** Zadaem chasovoj poyas, v kotorom nahoditsya komp'yuter.

![alt](img/VirtualBox-Debian10-01-15.png)

**16.** Vybiraem sposob razmetki diska `Авто - использовать весь диск`.

![alt](img/VirtualBox-Debian10-01-17.png)

**17.**  Podtverzhdaem chto hotim razmetit' disk `SCSI3 (0,0,0) (sda) - 8.6 GB ATA VBOX HARDDISK`.

![alt](img/VirtualBox-Debian10-01-18.png)

**18.** Vybiraem skhemu razmetki diska -- `Все файлы в одном раделе (рекомендуется новичкам)`

![alt](img/VirtualBox-Debian10-01-19.png)

**19.** Podtverzhdaem, chto razmetka diska proizvedena verno -- `Закончить разметку и записать изменения на диск`  

![alt](img/VirtualBox-Debian10-01-20.png)

**20.** Podtverzhdaem, chto gotoy proizvesti perezapis' tablicy razmetki razdelov.

![alt](img/VirtualBox-Debian10-01-22.png)

**21.** Proizvoditsya ustanovka yadra.

![alt](img/VirtualBox-Debian10-01-23.png)

**22.** T.k. nash distributiv dlya setevoj ustanovki, otkazyvaemsya ot poiska paketov s dopolnitel'nyh CD- ili DVD-diskov.

![alt](img/VirtualBox-Debian10-01-24.png)

**23.** Vybiraem, kakoj strany hotim ispol'zovat' servera dlya distributivov i repozitoii paketov -- `Российская Федерация`

![alt](img/VirtualBox-Debian10-01-25.png)

**24.** Ukazyvaem s kakogo servera brat' distributivy i ch'i repozitorii podklyuchat'. Samye bystrye dlya Moskvy -- `mirror.corbina.net`.

![alt](img/VirtualBox-Debian10-01-26.png)

**25.** Zadayom HTTP-proxy cherez kotoryj nasha mashina podklyuchena v internet (v nashem sluchae nichego ne ukazyvaem)

![alt](img/VirtualBox-Debian10-01-27.png)

**26.** Nastraivayutsya repozitorii.

![alt](img/VirtualBox-Debian10-01-28.png)

**27.** Podkachivayutsya spiski paketov, dostupnyh k ustanovke.

![alt](img/VirtualBox-Debian10-01-29.png)

**28.** Otkazyvaemsya ot pomoshchi razrabotchikam, zapreshchaya otslezhivat' ustanavlivaemye pakety.

![alt](img/VirtualBox-Debian10-01-30.png)

**29.** Ukazyvaem, kakie pakety hotim ustanovit'. Nam nuzhen minimal'nyj nabor -- `SSH-сервер` i `Стандартные системные утилиты`:

![alt](img/VirtualBox-Debian10-01-31.png)

**30.** Proizvoditsya zagruzka i ustanovka paketov:

![alt](img/VirtualBox-Debian10-01-32.png)

**31.** Soglashaemsya, chto hotim ispol'zovat' sistemnyj zagruzchik GRUB v glavnoj zagruzochnoj zapisi HDD:

![alt](img/VirtualBox-Debian10-01-33.png)

**32.** Ukazyvaem tom, na kotoryj budet proizvedena zapis' zagruzchika. V nashem sluchae `/dev/sda`:

![alt](img/VirtualBox-Debian10-01-34.png)

**33.** Proizvodyatsya final'nye nastrojki sistemy:

![alt](img/VirtualBox-Debian10-01-35.png)

**34.** Sistema Debian ustanovlena i gotova k perezagruzke. Soglashaemsya: 

![alt](img/VirtualBox-Debian10-01-36.png)

**35.** Instrallyator avtomaticheski razmontiruet ustanovochnyj iso-obraz iz virtual'nogo CD-ROM. Budet proizvedena zagruzka sistemy:

![alt](img/VirtualBox-Debian10-01-41.png)

**36.** Logiruemsya pod imenem pol'zovatelya, kotoroe sozdali pri installyacii sistemy:

![alt](img/VirtualBox-Debian10-01-40.png)

**37.** Uznayom IP-adres nashej virtualki:

```bash
ip a
```

Poluchem, chto-to tipa:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:a9:4d:45 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.43/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 24273sec preferred_lft 24273sec
    inet6 fe80::a00:27ff:fea9:4d45/64 scope link
       valid_lft forever preferred_lft forever

```

Otkuda vidim, chto nasha virtual'naya mashina poluchila adres `192.168.1.43`.

Dalee vse ostal'nye nastrojki mozhno vypolnyat' c vneshnej mashiny, cherez SSH. Tak udobnee. Dlya podklyucheniya po SSH ispol'zuem komandu:

```bash
ssh serg@192.168.1.43
```