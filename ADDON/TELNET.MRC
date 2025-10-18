on 1:SOCKOPEN:telnet*:{
  if (($sockerr == 3)) { aline @Telnet *** Impossibile connettersi all'host. | halt } 
  if (($sockerr == 4)) { aline @Telnet *** Risoluzione host fallita: $sock($sockname).ip $+ : $+ $sock($sockname).port | halt } 
  else {
    if (%tn.host == $null) { aline @Telnet *** Connessione effettuata: $sock($sockname).ip $+ : $+ $sock($sockname).port | halt }
    else {
      aline @Telnet *** Connessione effettuata: $sock($sockname).ip $+ : $+ $sock($sockname).port
    }
    set %tn.r telnet
    titlebar @Telnet - $sock($sockname).ip $+ : $+ $sock($sockname).port
  }
}
on 1:SOCKLISTEN:telnet!:{
  set %tn.r tnet $+ $rand(1,10000)
  sockaccept %tn.r
  ; sockwrite -n %tn.r Connection started...
  ; .timer 1 2 sockwrite -n %tn.r Your host: $sock($sockname).ip connected at port $sock($sockname).port
  titlebar @Telnet - $sock($sockname).ip $+ : $+ $sock($sockname).port
  aline @Telnet *** connessione aperta da: $sock($sockname).ip $+ : $+ $sock($sockname).port
}
on 1:SOCKREAD:tnet*: {
  if ($sockerr > 0) { return }
  sockread %temp
  if ($sockbr == 0) return
  if (%temp == $null) %temp = -
  if (%temp != $null) {  
    echo @Telnet < $+ $sock($sockname).ip $+ : $+ $sock($sockname).port $+ > $strip(%temp)
  }
}
on 1:SOCKREAD:telnet: {
  if ($sockerr > 0) { return }
  sockread %temp
  if ($sockbr == 0) return
  if (%temp == $null) %temp = -
  if (%temp != $null) {  
    echo @Telnet < $+ $sock($sockname).ip $+ : $+ $sock($sockname).port $+ > $strip(%temp)
  }
}
on 1:SOCKCLOSE:tnet*: {
  aline @Telnet *** Connessione chiusa: $sock($sockname).ip
  titlebar @Telnet - Nessuna connessione attiva
  halt
}
on 1:SOCKCLOSE:telnet: {
  aline @Telnet *** Connessione chiusa: $sock($sockname).ip
  titlebar @Telnet - Nessuna connessione attiva
  halt
}
on 1:INPUT:{
  if ($active == $window(@Telnet)) {
    if ($left($1,1) !== /) {
      if ($portfree(%tn.port) == $true) || (%tn.port == $null) { aline @Telnet *** Nessuna connessione attiva | halt }
      else {
        .sockwrite -n %tn.r $strip($1-)
        echo @Telnet -> $strip($1-)
        halt
      }
    }
  }
}
on 1:CLOSE:@Telnet: sockclose telnet! | sockclose tnet* | sockclose telnet | unset %tn.*
alias ctelnet { sockclose telnet! | sockclose tnet* | sockclose telnet | unset %tn.*  }
alias telnet {
  ctelnet
  window -c @Telnet
  if ($1 == $null) { echo -a mTelnet - /telnet <-[l/t/b]> <Host> <porta> | echo -a Parametri mTelnet: l - ascolto / t - connessione / b - entrambi  | halt }
  else {
    window -e @Telnet 50 50 500 300 @Telnet Fixedsys 9
    set %tn.host $2 | set %tn.port $3
    if (-l isin $1) { open.listen }
    if (-t isin $1) { open.connection }
    if (-b isin $1) { open.listen | open.connection }
  }
}
alias mtn return mTelnet (v1b5) by ^manson^ -- takes you anywhere you want to be...
alias open.listen socklisten telnet! %tn.port | aline @Telnet telnet in ascolto sulla porta  $+ %tn.port $+ 
alias open.connection sockopen telnet %tn.host %tn.port

menu @Telnet {
  Pubblicizza: .sockwrite -n %tn.r $mtn | echo @Telnet -> $mtn
  -
  Ripristina: window -r @Telnet
  Sul desktop: window -d @Telnet
  Ingrandisci: window -x @Telnet
  Riduci a icona: window -n @Telnet
  Chiudi: window -c @Telnet 
  -
  Chiudi tutte le connessioni: ctelnet | echo @Telnet *** chiuse tutte le connessioni.
}
