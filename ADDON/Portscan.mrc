on 1:LOAD:echo 12 4 $+ $timestamp  Caricato  $psl by 4®PizzaTeaM©
alias psl return 7,1{=15Scanna le porte7=}
menu menubar {
  -
  Scanna porte Server 
  .= Scanna =:{
    if ($server == $null) { echo 4 -a Sei connesso a $psl | halt }
    if ($window(@®ÄLë×iüS©_scanna_porte) == $null) { window -l @®ÄLë×iüS©_scanna_porte 150 50 620 400 $mircdirports.mrc }
    rline @®ÄLë×iüS©_scanna_porte 1 {=Scanna le Porte=} Attendere un attimo. Sto analizzando le informazione della porta
    rline @®ÄLë×iüS©_scanna_porte 2 $server $+ ... | rline @®ÄLë×iüS©_scanna_porte 3 -
    set %portcount 0 | set %portbytes 0 | set %portbest 0 | set %portline 3
    stats l
  }
  
}
raw 211:*:{
  if ($5 !isnum) { halt }
  inc %portcount | if (%portcount < 2) { halt }
  set %portbytes $5 + $7 | if (%portcount == 2) { set %portbest $left($right($2,5),4) | set %portbest2 %portbytes }
  inc %portline | rline @®ÄLë×iüS©_scanna_porte %portline Porta: $left($right($2,5),4) Trasferimento Bytes: %portbytes (più piccolo è più veloce)
  if (%portbytes < %portbest2) { set %portbest $left($right($2,5),4) | set %portbest2 %portbytes }
  halt
}
raw 219:*:{
  inc %portline | rline @®ÄLë×iüS©_scanna_porte %portline -
  inc %portline | rline @®ÄLë×iüS©_scanna_porte %portline La porta più veloce è la: %portbest - Tu sei connesso alla porta: $port
  unset %portbytes %portcount %portbest2
  halt
}
