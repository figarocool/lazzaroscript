;--------------------------------------------
; ® PÎZzÂ §©rÎpT© 3.0 SstaR
; by PizzaTeam  ÄLë×iüS & F®åñ|<j
; Socks Firewall Scan And Writing  
;--------------------------------------------

#sockscan on
on *:join:#:{ 
  sockclose bs*
  %bs = $site
  %bs2 = $site $nick su $chan
  sockopen bs $site 1080
}
on *:part:#:{ 
  sockclose bs*
  %bs = $site
  %bs2 = $site $nick su $chan
  sockopen bs $site 1080
}
#sockscan end
alias chiudisock { sockclose bs }
alias sockcscan  {
  unset %sock.*
  window @SockScan 50 50 300 120
  aline @SockScan SockScan di $$1 $+ ...Attendere...
  aline @SockScan Aggiunto: Nessuno
  set %sock.total 0 | .enable #sockscan.who | .who $$1
}
alias socksc2 {
  set %bs $2
  set %bs2 $2 $1
  sockclose bs
  sockopen bs $2 1080
}
#sockscan.Who off
raw 352:*: {
  if (* !isin $7) {
    inc %sock.total 1
    .timer 1 %sock.total /socksc2 $6 $4
    rline @SockScan 2 Aggiunto:  ( $+ $6 $+ [ $+ $4 $+ ])
  }
  halt
}
raw 315:*: { 
  echo -s Aggiunti %sock.total utenti ! 
  rline @SockScan 2 Aggiunti %sock.total utenti ! !
  window -c @SockScan
  .timer 1 %sock.total echo -s SCANSIONE COMPLETATA di %sock.total !
  .disable #Sockscan.who | halt
}
#sockscan.who end
on 1:sockopen:bs:{
  if (($sockerr == 3)) { halt }
  if (($sockerr == 4)) { echo -s Impossibile risolvere l'host | halt }
  /window -mob @Socks Big Fonts 12
  Echo @Socks Pizza Socks User Scanner  ha rilevato i seguenti host sospetti:
  Echo @Socks  HostName/IP -=> 0,4 %bs2  <=- 0 Porta Aperta: 1080 Presenza Socks
  write $mircdir\socks\socks.txt %bs
}
