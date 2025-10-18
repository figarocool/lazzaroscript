; +----------------------------------------------+
; -     mIRC LAzZaro      
; -   By Stefano Basile -
;-    
; +----------------------------------------------+
;
; mIRC Link Looker Popups
;
menu menubar {
 Link Looker
  .About:echo 5 -a _--'+(8,1m10IRC 8L10ink 8L10ooker 8v101.1 8B10y 8D10ude <8matt4@8snip.net10>)+'--_
  .Search: {
    if ($server == $null) { echo 4 -a ERRORE: Devi essere connesso a un IRC Server per eseguire questo comando! | halt }
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    window -c @Risultati
    window -l @Risultati @Risultati
    aline 5 @Risultati mIRC Link Looker Auto Popup Window (Ricerca Server Splittati)
    aline 5 @Risultati Ricerca effettuata il $adate alle $linklook.rtime
    aline 5 @Risultati Usando la lista $+ %linklook.slist $+  in $linklook.slogfile(dir)
    aline 2 @Risultati -
    if ($exists($linklook.slogfile(dir)) == $false) { aline 4 @Risultati ERRORE: Il file log/list del Server deve essere creato prima di procedere! | halt }
    if (%linklook.slist == $null) { aline 4 @Risultati ERRORE: Il file log/list del Server deve essere creato prima di procedere ! | halt }
    set %linklook.tmp $readini $linklook.slogfile(dir) %linklook.slist Creato
    if (%linklook.tmp == $null) { aline 4 @Risultati ERRORE: La lista del server  $+ %linklook.slist $+  non esiste in $linklook.slogfile(dir) | halt }
    if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
    .remote on
    set %linklook.searching on
    links
  }
  .Server Log
  ..Nome del File: {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    set %linklook.tmp2 $?="Inserisci il nome del file"
    set %linklook.tmp $mircdir $+ %linklook.tmp2
    if (%linklook.tmp2 == $null) { halt }
    if (%linklook.tmp2 == linklook.cfg || %linklook.tmp2 == servtmp.txt || %linklook.tmp2 == servtmp2.txt) { echo 4 -a ERRORE: Non posso usare linklook.cfg, servtmp.txt, e/o servtmp2.txt come file del log server | halt }
    if ($exists(%linklook.tmp) == $true) && ($linklook.servlog(%linklook.tmp) != $true) { echo 4 -a ERRORE: Il file che hai inserito già esiste e non è un valido Server Log File. Impossibile cambiare i nomi dei file. | halt }
    if (%linklook.tmp2 == $linklook.slogfile) { echo 4 -a ERRORE: Il Server Log File che hai specificato è già caricato | halt }
    set %linklook.slogfile %linklook.tmp2
    echo 6 -a Server Log File cambiato in: %linklook.tmp
  }
  ..Stato: {
    window -c @LinkLookerStato
    window -l @LinkLookerStato
    aline 5 @LinkLookerStato mIRC Link Looker Auto Popup Window (Status Report)
    aline 2 @LinkLookerStato -
    aline 6 @LinkLookerStato Caricato Server Log: 12 $+ $linklook.slogfile(dir)
    aline 6 @LinkLookerStato Caricata Server List:  12 $+ %linklook.slist
    aline 6 @LinkLookerStato Config File:  12 $+ $mircdir $+ linklook.cfg
    aline 6 @LinkLookerStato Temp File 1:  12 $+ $mircdir $+ servtmp.txt
    aline 6 @LinkLookerStato Temp File 2:  12 $+ $mircdir $+ servtmp2.txt
    aline 2 @LinkLookerStato -
    if ($server != $null) { aline 5 @LinkLookerStato Sei attualmente connesso al server $server sulla porta $port }
    aline 5 @LinkLookerStato Stai eseguendo mIRC Link Looker v1.1 by Dude e tradotto da AlexiuS
  }
  ..Lista del Server
  ...Vedi {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    window -c @Risultati
    window -c @ServerLists
    if ($readini $mircdir $+ linklook.cfg $linklook.slogfile List1 == $null) { echo 4 -a ERRORE: Non ci sono Server Lists in $linklook.slogfile(dir) | halt }
    window -xl @ServerLists
    set %linklook.h 0
    if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
    :begin
    inc %linklook.h 1
    set %linklook.tmp $readini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ]
    if (%linklook.tmp == $null) { goto end }
    aline 6 @ServerLists %linklook.tmp 2-=- 5 $+ $readini $linklook.slogfile(dir) %linklook.tmp Creato
    write $mircdir $+ servtmp.txt %linklook.tmp
    goto begin
    :end
    set %linklook.tmp2 $?="Inserisci il nome della Server List  (eg: NewNet)"
    if (%linklook.tmp2 == $null) { window -c @ServerLists | halt }
    if ($read -s $+ %linklook.tmp2 $mircdir $+ servtmp.txt == $null) { window -c @ServerLists | echo 4 -a ERRORE: Nome della Server List non valido | halt }
    window -c @ServerLists
    window -l @Risultati @Risultati
    aline 5 @Risultati mIRC Link Looker Auto Popup Window (Listing Servers)
    aline 5 @Risultati Ricerca Effettuata il $adate alle $linklook.rtime
    aline 5 @Risultati Usando  $+ %linklook.tmp2 $+  Server List in $linklook.slogfile(dir)
    aline 2 @Risultati -
    set %linklook.i 0
    set %linklook.n 0    
    :begin2
    inc %linklook.i 1
    if ($readini $linklook.slogfile(dir) %linklook.tmp2 Server [ $+ [ %linklook.i ] ] == $null) { aline 6 @Risultati Trovati %linklook.n Server(s) | aline 6 @Risultati Operazione Completata | halt }
    inc %linklook.n 1
    aline 12 @Risultati Server - $readini $linklook.slogfile(dir) %linklook.tmp2 Server [ $+ [ %linklook.i ] ]
    goto begin2
  }
  ...Carica {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    window -c @ServerLists
    if ($readini $mircdir $+ linklook.cfg $linklook.slogfile List1 == $null) { echo 4 -a ERRORE: Non ci sono Server Lists in $linklook.slogfile(dir) | halt }
    window -xl @ServerLists
    set %linklook.h 0
    if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
    :begin
    inc %linklook.h 1
    set %linklook.tmp $readini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ]
    if (%linklook.tmp == $null) { goto end }
    aline 6 @ServerLists %linklook.tmp 2-=- 5 $+ $readini $linklook.slogfile(dir) %linklook.tmp Creato
    write $mircdir $+ servtmp.txt %linklook.tmp
    goto begin
    :end
    set %linklook.tmp2 $?="Inserisci il nome della Server List  (eg: NewNet)"
    if (%linklook.tmp2 == $null) { window -c @ServerLists | halt }
    if ($read -s $+ %linklook.tmp2 $mircdir $+ servtmp.txt == $null) { window -c @ServerLists | echo 4 -a ERRORE: Nome della Server List non valido | halt }
    if (%linklook.tmp2 == %linklook.slist) { window -c @ServerLists | echo 4 -a ERRORE: La Server List che hai specificato è già caricata | halt }
    set %linklook.slist %linklook.tmp2
    window -c @ServerLists
    echo 6 -a Caricata  $+ %linklook.slist $+  Server List in $linklook.slogfile(dir)
  }
  ...Crea: {
    if ($server == $null) { echo 4 -a ERRORE: Devi essere connesso a un IRC Server per eseguire questo comando! | halt }
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    set %linklook.tmp $?="Inserisci il nome del IRC Network (eg: NewNet):"
    if (%linklook.tmp == $null) { halt }
    set %linklook.slist %linklook.tmp
    window -c @Risultati
    window -l @Risultati @Risultati
    aline 5 @Risultati mIRC Link Looker Auto Popup Window (Creazione nuova Server List)
    aline 5 @Risultati Ricerca effettuata il $adate alle $linklook.rtime
    set %linklook.h 0
    :begin
    inc %linklook.h 1
    set %linklook.tmp2 $readini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ]
    if (%linklook.tmp2 == $null) { goto proceed }
    goto begin
    :proceed
    if ($exists($linklook.slogfile(dir)) == $false) { write $linklook.slogfile(dir) mIRC Link Looker Server Log }
    set %linklook.tmp3 $readini $linklook.slogfile(dir) %linklook.slist Creato
    if (%linklook.tmp3 != $null) {
      remini $linklook.slogfile(dir) %linklook.slist
      writeini $linklook.slogfile(dir) %linklook.slist  Creato Creato il $adate alle $linklook.rtime
      aline 5 @Risultati Overwriting Existing  $+ %linklook.slist $+  Server List in $linklook.slogfile(dir)
    }
    else {
      writeini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ] %linklook.slist
      writeini $linklook.slogfile(dir) %linklook.slist Creato Creato il $adate alle $linklook.rtime
      aline 5 @Risultati Sto Creando  $+ %linklook.slist $+  Server List in $linklook.slogfile(dir)
    }
    aline 2 @Risultati -
    .remote on
    set %linklook.n 0
    set %linklook.createlist on
    links
  }
  ...Update: {
    if ($server == $null) { echo 4 -a ERRORE: Devi essere collegato ad un IRC Server per eseguire questo comando! | halt }
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    window -c @Risultati
    window -l @Risultati @Risultati
    aline 5 @Risultati mIRC Link Looker Auto Popup Window (Server List Update)
    aline 5 @Risultati Ricerca effettuata il $adate alle $linklook.rtime
    aline 5 @Risultati Updating  $+ %linklook.slist $+  Server List in $linklook.slogfile(dir)
    aline 2 @Risultati -
    if ($exists($linklook.slogfile(dir)) == $false) { aline 4 @Risultati ERRORE: il file log/list deve essere creato prima di procedere! | halt }
    if (%linklook.slist == $null) { aline 4 @Risultati ERRORE:  il file log/list deve essere creato prima di procedere! | halt }
    set %linklook.tmp $readini $linklook.slogfile(dir) %linklook.slist Creato
    if (%linklook.tmp == $null) { aline 4 @Risultati ERRORE: Server List  $+ %linklook.slist $+  non esiste in $linklook.slogfile(dir) | halt }
    if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
    if ($exists($mircdirservtmp2.txt) != $false) { .remove $mircdir $+ servtmp2.txt }
    .remote on
    set %linklook.update on
    links
  }
  ...Cancella: {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    window -c @ServerLists
    if ($readini $mircdir $+ linklook.cfg $linklook.slogfile List1 == $null) { echo 4 -a ERRORE: Non c'è nessuna Server List in $linklook.slogfile(dir) | halt }
    window -xl @ServerLists
    set %linklook.h 0
    if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
    :begin
    inc %linklook.h 1
    set %linklook.tmp $readini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ]
    if (%linklook.tmp == $null) { goto end }
    aline 6 @ServerLists %linklook.tmp 2-=- 5 $+ $readini $linklook.slogfile(dir) %linklook.tmp Creato
    write $mircdir $+ servtmp.txt %linklook.tmp
    goto begin
    :end
    set %linklook.tmp2 $?="Inserisci il nome della Server List  (eg: NewNet)"
    if (%linklook.tmp2 == $null) { window -c @ServerLists | halt }
    if ($read -s $+ %linklook.tmp2 $mircdir $+ servtmp.txt == $null) { window -c @ServerLists | echo 4 -a ERRORE: Nome della Server List non valido | halt }
    remini $linklook.slogfile(dir) %linklook.tmp2
    remini $mircdir $+ linklook.cfg $linklook.slogfile
    write -ds $+ %linklook.tmp2 $mircdir $+ servtmp.txt
    set %linklook.h 0
    :begin2
    if (%linklook.h >= $lines($mircdirservtmp.txt)) { window -c @ServerLists | echo 6 -a Cancellata  $+ %linklook.tmp2 $+  Server List da $linklook.slogfile(dir) | halt }
    inc %linklook.h 1
    set %linklook.tmp3 $read -l $+ %linklook.h $mircdir $+ servtmp.txt
    writeini $mircdir $+ linklook.cfg $linklook.slogfile List [ $+ [ %linklook.h ] ] %linklook.tmp3
    goto begin2
  }
}
menu @Risultati {
  Connetti: {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    set %linklook.tmp Split Server Trovato -
    set %linklook.tmp2 Server Aggiunto -
    set %linklook.tmp3 Nuovo Server Aggiunto-
    set %linklook.tmp4 Server -
    if (%linklook.tmp isin $sline(@Risultati,1)) { 
      set %linklook.port $?="Inserisci la porta del Server  (eg: 7000)"
      if (%linklook.port == $null) { halt }
      server $mid($sline(@Risultati,1),24,9999) %linklook.port
      echo 6 -s STO CONNETTENDO: $mid($sline(@Risultati,1),24,9999) sulla porta %linklook.port
    }
    elseif (%linklook.tmp2 isin $sline(@Risultati,1)) {
      set %linklook.port $?="Inserisci la porta del Server  (eg: 7000)"
      if (%linklook.port == $null) { halt }
      server $mid($sline(@Risultati,1),15,9999) %linklook.port
      echo 6 -s STO CONNETTENDO: $mid($sline(@Risultati,1),15,9999) sulla porta %linklook.port
    }
    elseif (%linklook.tmp3 isin $sline(@Risultati,1)) {
      set %linklook.port $?="Inserisci la porta del Server  (eg: 7000)"
      if (%linklook.port == $null) { halt }
      server $mid($sline(@Risultati,1),19,9999) %linklook.port
      echo 6 -s STO CONNETTENDO: $mid($sline(@Risultati,1),19,9999) sulla porta %linklook.port
    }
    elseif (%linklook.tmp4 isin $sline(@Risultati,1)) {
      set %linklook.port $?="Inserisci la porta del Server  (eg: 7000)"
      if (%linklook.port == $null) { halt }
      server $mid($sline(@Risultati,1),9,9999) %linklook.port
      echo 6 -s STO CONNETTENDO: $mid($sline(@Risultati,1),9,9999) sulla porta %linklook.port
    }
    else { beep 1 }
  }
  Renomina: {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    set %linklook.tmp Split Server Trovato
    set %linklook.tmp2 Server Aggiunto -
    set %linklook.tmp3 Aggiunto Nuovo Server -
    set %linklook.tmp4 Server -
    if (%linklook.tmp isin $sline(@Risultati,1)) { 
      set %linklook.newname $?="Inserisci nuovo Nome (eg: us.undernet.org)"
      if (%linklook.newname == $null) { halt }
      linklook.ren $mid($sline(@Risultati,1),24,9999) %linklook.newname
    }
    elseif (%linklook.tmp2 isin $sline(@Risultati,1)) {
      set %linklook.newname $?="Inserisci nuovo Nome (eg: us.undernet.org)"
      if (%linklook.newname == $null) { halt }
      linklook.ren $mid($sline(@Risultati,1),15,9999) %linklook.newname
    }
    elseif (%linklook.tmp3 isin $sline(@Risultati,1)) {
      set %linklook.newname $?="Inserisci nuovo Nome (eg: us.undernet.org)"
      if (%linklook.newname == $null) { halt }
      linklook.ren $mid($sline(@Risultati,1),19,9999) %linklook.newname
    }
    elseif (%linklook.tmp4 isin $sline(@Risultati,1)) {
      set %linklook.newname $?="Inserisci nuovo Nome (eg: us.undernet.org)"
      if (%linklook.newname == $null) { halt }
      linklook.ren $mid($sline(@Risultati,1),9,9999) %linklook.newname
    }
    else { beep 1 }
  }
  Delete: {
    if (%linklook.searching == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.createlist == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    if (%linklook.update == on) { echo 4 -a ERRORE: Impossibile rispondere alla richiesta. Occupato dalla richiesta precedente | halt }
    set %linklook.tmp Split Server Trovato
    set %linklook.tmp2 Aggiunto Server -
    set %linklook.tmp3 Aggiunto nuovo Server -
    set %linklook.tmp4 Server -
    if (%linklook.tmp isin $sline(@Risultati,1)) { 
      linklook.del $mid($sline(@Risultati,1),24,9999)
    }
    elseif (%linklook.tmp2 isin $sline(@Risultati,1)) {
      linklook.del $mid($sline(@Risultati,1),15,9999)
    }
    elseif (%linklook.tmp3 isin $sline(@Risultati,1)) {
      linklook.del $mid($sline(@Risultati,1),19,9999)
    }
    elseif (%linklook.tmp4 isin $sline(@Risultati,1)) {
      linklook.del $mid($sline(@Risultati,1),9,9999)
    }
    else { beep 1 }
  }
}
;
; mIRC Link Looker RAW Procedures
;
raw 364:*: {
  if (%linklook.createlist == on) { inc %linklook.n 1 | aline 12 @Risultati Server Aggiunto - $2 | writeini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.n ] ] $2 }
  elseif (%linklook.update == on) { write $mircdir $+ servtmp.txt $2 }
  elseif (%linklook.searching == on) { write $mircdir $+ servtmp.txt $2 }
}  
raw 365:*: {
  if (%linklook.createlist == on) {
    aline 6 @Risultati Aggiunti %linklook.n Server(s)
    aline 6 @Risultati Operazione Completata
    set %linklook.createlist off
    halt
  }
  elseif (%linklook.update == on) { 
    set %linklook.update off
    linklook.update
    halt
  }
  elseif (%linklook.searching == on) {
    set %linklook.searching off
    linklook.splitsearch
    halt
  }
}
;
; mIRC Link Looker Aliases
;
alias linklook.splitsearch {
  set %linklook.i 0
  set %linklook.splits 0
  :begin
  inc %linklook.i 1
  if ($readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.i ] ] == $null) { aline 6 @Risultati Trovati %linklook.splits Possibili Split Server(s) | aline 6 @Risultati Operazione Completata | halt }
  set %linklook.stmp $readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.i ] ]
  set %linklook.stmp2 $read -s $+ %linklook.stmp $mircdir $+ servtmp.txt
  if (%linklook.stmp2 == $null) { inc %linklook.splits 1 | aline 12 @Risultati Split Server Trovato - %linklook.stmp }
  goto begin
}
alias linklook.update {
  set %linklook.i 0
  set %linklook.n 0
  :begin
  inc %linklook.i 1
  if ($readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.i ] ] == $null) { set %linklook.a 0 | goto begin2 }  
  write $mircdir $+ servtmp2.txt $readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.i ] ]
  goto begin
  :begin2
  if (%linklook.a >= $lines($mircdirservtmp.txt)) { aline 6 @Risultati Aggiunti %linklook.n Server(s) | aline 6 @Risultati Operazione Completata | halt }
  inc %linklook.a 1
  set %linklook.stmp $read -l $+ %linklook.a $mircdir $+ servtmp.txt
  set %linklook.stmp2 $read -s $+ %linklook.stmp $mircdir $+ servtmp2.txt
  if (%linklook.stmp2 == $null) { inc %linklook.n 1 | writeini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.i ] ] %linklook.stmp | inc %linklook.i 1 | aline 12 @Risultati Aggiunto nuovo Server - %linklook.stmp }
  goto begin2
}
alias linklook.ren {
  set %linklook.h 0
  :begin
  inc %linklook.h 1
  if ($readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.h ] ] == $null) { echo 4 -a ERRORE: $1 non esiste nella  $+ %linklook.slist $+  Server List. | halt }
  if ($readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.h ] ] == $1) { goto proceed }
  goto begin
  :proceed
  writeini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.h ] ] $2
  echo 6 -a Rinominato $1 in $2 in  $+ %linklook.slist $+  Server List
}
alias linklook.del {
  set %linklook.h 0
  if ($exists($mircdirservtmp.txt) != $false) { .remove $mircdir $+ servtmp.txt }
  if ($exists($mircdirservtmp2.txt) != $false) { .remove $mircdir $+ servtmp2.txt }
  write $mircdir $+ servtmp2.txt $readini $linklook.slogfile(dir) %linklook.slist Creato
  :begin
  inc %linklook.h 1
  set %linklook.tmp $readini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.h ] ]
  if (%linklook.tmp == $null) { goto proceed }
  write $mircdir $+ servtmp.txt %linklook.tmp
  goto begin
  :proceed
  set %linklook.tmp2 $read -s $+ $1 $mircdir $+ servtmp.txt
  if (%linklook.tmp2 != $null) { write -ds $+ $1 $mircdir $+ servtmp.txt }
  else { echo 4 -a ERRORE: $1 non esiste nella  $+ %linklook.slist $+  Server List. | halt }
  remini $linklook.slogfile(dir) %linklook.slist
  set %linklook.h 0
  writeini $linklook.slogfile(dir) %linklook.slist Creato $read -l1 $mircdir $+ servtmp2.txt
  :begin2
  if (%linklook.h >= $lines($mircdirservtmp.txt)) { echo 6 -a Rimosso $1 da  $+ %linklook.slist $+  Server List | halt }
  inc %linklook.h 1
  set %linklook.tmp3 $read -l $+ %linklook.h $mircdir $+ servtmp.txt
  writeini $linklook.slogfile(dir) %linklook.slist Server [ $+ [ %linklook.h ] ] %linklook.tmp3
  goto begin2
}
;
; mIRC Link Looker Custom Identifiers
;
alias linklook.rtime {
  set %linklook.realtime $time
  set %linklook.hour $token(1,58,%linklook.realtime)
  set %linklook.type am  
  if (%linklook.hour = 0) set %linklook.hour 12 
  if (%linklook.hour > 12) { set %linklook.hour %linklook.hour - 12 | set %linklook.type pm }
  if (%linklook.hour = 12) set %linklook.type pm
  set %linklook.min $token(2,58,%linklook.realtime)
  set %linklook.realtime %linklook.hour $+ : $+ %linklook.min %linklook.type
  unset %linklook.hour | unset %linklook.min | unset %linklook.type | return %linklook.realtime
}
alias linklook.servlog {
  set %linklook.tmp3 $read -l1 $1
  set %linklook.tmp4 mIRC Link Looker Server Log
  if (%linklook.tmp3 != %linklook.tmp4) { return $false }
  else { return $true }
}
alias linklook.slogfile {
  if ($1 == dir) {
    if (%linklook.slogfile == $null) { return $mircdir $+ servlist.ini }
    else { return $mircdir $+ %linklook.slogfile }
  }
  else {
    if (%linklook.slogfile == $null) { return servlist.ini }
    else { return %linklook.slogfile }
  }
}
;
; mIRC Link Looker Version Reply and ON CONNECT Procedures
;
on 1:connect:set %linklook.createlist off | set %linklook.update off | set %linklook.searching off
