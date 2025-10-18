;  For Mirc5.xx  i-mail lazZaro.s@tiscalinet.it You can find me on IRCNET on #LazZaro---
;Enjoy Yourself-----AstaLaVista-------Use LAzZaro ScRipT   Non Esiste sito internet -------------------------------------------



ctcp 1:VERSION:echo -a VERSION ricevuto da $nick $+ ! $+ $address !

on *:PART:%takechan:{ 
  if (($nick(0,$chan) == 2) && ($me !isop $chan) && ($me != $nick)) { 
    .raw PART $chan $crlf JOIN $chan
    echo 4 -s *** %sd Canale 6VUOTO !!! Provo a Prendermi l'OP Su6 $chan !
    %ddesd /echo 6 -a *** %sd ATTENZIONE: Il4 %sd Ha Fatto Un °(4TAKEOVER)° Su4 $chan !
    .timer 1 5 .mode $chan +stn
  }
}
on *:QUIT:%takechan:{ 
  if (($nick(0,%takechan) == 2) && ($me !isop %takechan) && ($me != $nick)) { 
    .raw PART %takechan $crlf JOIN %takechan
    echo 4 -s *** %sd Canale 6VUOTO !!! Provo a Prendermi l'OP Su6 %takechan !
    %ddesd /echo 6 -a *** %sd ATTENZIONE: Il4 %sd Ha Fatto Un (4TAKEOVER) Su4 %takechan !
    .timer 1 5 .mode &takrchan +stn
  }
}
on 1!:OP:%takechan: {
  if ($opnick == $me) {
    %ddesd /echo 6 -a *** %sd ATTENZIONE:Il 4pÎzZÅ §ø£dîë® Sta effettuando un (4TAKEOVER) Su4 $chan !
    .timer 1 15 mode $chan +stn
    %mass = ""
    %i = 0
    :incl
    inc %i
    if ($opnick(%i,#) == $me) { inc %i }
    if ($opnick(%i,#) == $null) {
      if ($len(%mass) > 0) mode # -ooo %mass
      halt
    }
    %mass = %mass $opnick(%i,#)
    if (3 // %i) {
      mode # -ooo %mass
      %mass = ""
    }
    goto incl
  }
}
ON 1:START:/echo -a 6pÎzZÅ §ø£dîë® ®ë@dý tø t@këøvë°R°
