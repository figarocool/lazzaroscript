
on 1:LOAD:{
  set %logmaster.version v2.4
  set %logmaster.about run    
}
alias logmaster.about {
  if ($window(@LogMaster) == $null) { set %logmaster.about run | logmaster }
  else {
    clear @LogMaster
    titlebar @LogMaster - Informazioni su Utilità di Gestione File Registro
    window @LogMaster @LogMaster
    aline @LogMaster 4,1 Log Master %logmaster.version  $str($chr(160),76) 8,1By Paul <kbhw@religious.com> $str($chr(160),100)
    aline @LogMaster $chr(160)
    aline -p @LogMaster $str($chr(160),4) Grazie di utilizzare l'Utilità di gestione file registro.  Questa utilità consente di gestire i file registro IRC in modo più semplice e veloce.  Non sarà più necessario eseguire il Blocco Note per aprire ogni singolo file registro.  Con l'Utilità di gestione file registro, è possibile aprire tutti i file registro a colori direttamente da mIRC!
    aline -p @LogMaster $str($chr(160),4) Oltre ad aprire file registro in mIRC, è possibile aprirli in Blocco Note, trovare del testo nel file, rinominare, eliminare e copiare in una cartella differente i file registro..  mIRC v5.31 ha consentito molti altri miglioramenti all'interfaccia, e di aggiungere molti altri comandi a questa versione dell'Utilità.
    aline @LogMaster $chr(160)
    aline @LogMaster $chr(160) 4Caratteristiche della versione %logmaster.version $+ :
    aline -p @LogMaster $str($chr(160),4) o Aggiunti i comandi Aggiorna file registro e Vai a. 
    aline -p @LogMaster $str($chr(160),4) o Menù contestuali dinamici.
    aline -p @LogMaster $str($chr(160),4) o Riorganizzati e compattati i menù contestuali.
    aline -p @LogMaster $str($chr(160),4) o Corretti alcuni piccoli bug.
    aline -p @LogMaster $str($chr(160),4) o Aggiunte righe del file alle statistiche visualizzazione file registro.
    aline @LogMaster $chr(160)
    aline -p @LogMaster $str($chr(160),4) Grazie di utilizzare Utilità di gestione file registro %logmaster.version $+ !! Inviare commenti, suggerimenti, rapporti bug o domande a: 4kbhw@religious.com.
    aline @LogMaster $chr(160)
  }
} 
alias logmaster.help {
  if ($window(@LogMaster) == $null) { halt }
  else {
    clear @LogMaster
    titlebar @LogMaster - Guida
    window @LogMaster @LogMaster
    aline @LogMaster 4,1 Log Master %logmaster.version  $str($chr(160),76) 8,1By Paul <kbhw@religious.com> $str($chr(160),100)
    aline @LogMaster $chr(160)
    aline -p @LogMaster $str($chr(160),4) Questa versione dell'Utilità è semplicissima da usare!  Per visualizzare un file registro, fare doppio clic su di esso nell'elenco laterale.  Per altri comandi (copia, rinominazione, apertura in Blocco Note, e ricerca testo) fare clic su di esso con il pulsante destro del mouse!
    aline @LogMaster $chr(160)
  }
} 
alias logmaster {
  :start
  if ($window(@LogMaster) == $null) {  
    window -l16x @LogMaster @LogMaster Comic Sans MS 14
    window -nls @LogMaster2 Comic Sans MS 14
    set %logmaster.count 1
    :AddLog
    set %logmaster.log $findfile($logdir,*.log,%logmaster.count)
    if (%logmaster.log == $null) goto end
    else {
      aline -l @LogMaster2 $nopath(%logmaster.log)
      inc %logmaster.count 1
    goto addlog }
  }
  else { window -c @Logmaster | goto start }
  :end
  set %logmaster.lines $line(@LogMaster2,0,0)
  set %logmaster.count 1
  :lineadd
  if (%logmaster.count > %logmaster.lines) goto end2
  else {
    aline -l @LogMaster $line(@LogMaster2,%logmaster.count)
    inc %logmaster.count 1
    goto lineadd
  }
  :end2
  if (%logmaster.about == run) { logmaster.about | set %logmaster.about ran | goto end3 }
  aline @LogMaster 4,1 Log Master %logmaster.version  $str($chr(160),76) 8,1By Paul <kbhw@religious.com> $str($chr(160),100)
  aline @LogMaster $chr(160)
  aline -p @LogMaster $str($chr(160),4) Benvenuti ad Utilità di gestione File Registro %logmaster.version $+ !  Per visualizzare un file registro, fare doppio clic du di esso nell'elenco laterale.  E' anche possibile fare clic con il pulsante destro del mouse per accedere ad altri comandi.
  :end3
  iline -l @LogMaster 1 4,1 $chr(160) Log Master %logmaster.version  $str($chr(160),15)
  iline -l @LogMaster 2 8,1 ————————————————— $str($chr(160),175)
  window -c @LogMaster2
}
alias logrefresh {
  :start
  if ($window(@LogMaster) == $null) { logmaster }
  else {
    clear -l @LogMaster
    window -nls @LogMaster2 Arial 11
    set %logmaster.count 1
    :AddLog
    set %logmaster.log $findfile($logdir,*.log,%logmaster.count)
    if (%logmaster.log == $null) goto end
    else {
      aline -l @LogMaster2 $nopath(%logmaster.log)
      inc %logmaster.count 1
    goto addlog }
  }
  :end
  set %logmaster.lines $line(@LogMaster2,0,0)
  set %logmaster.count 1
  :lineadd
  if (%logmaster.count > %logmaster.lines) goto end2
  else {
    aline -l @LogMaster $line(@LogMaster2,%logmaster.count)
    inc %logmaster.count 1
    goto lineadd
  }
  :end2
  iline -l @LogMaster 1 4,1 $chr(160) Log Master %logmaster.version  $str($chr(160),15)
  iline -l @LogMaster 2 8,1 ————————————————— $str($chr(160),175)
  window -c @LogMaster2
}
alias Logview {
  if ($2 == $null) {
    if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
    else {
      set %logmaster.file $logdir $+ $sline(@LogMaster,1)
      clear @LogMaster    
      iline @LogMaster 1 8,1 Log Master %logmaster.version $str($chr(160),15) 4,1 Visualizzato: $sline(@LogMaster,1) ( $+ $lof(%logmaster.file) byte - $lines(%logmaster.file) righe) $str($chr(160),175)
      titlebar @LogMaster - $sline(@LogMaster,1)
      loadbuf -p @LogMaster $logdir $+ $sline(@LogMaster,1)
      aline @LogMaster 4,1 Caricato con successo $calc($line(@LogMaster,0) - 1) di $lines(%logmaster.file) righe. $str($chr(160),175)
      sline @LogMaster 15 
      window @LogMaster @LogMaster2
    }
  }
  else {
    set %logmaster.file $logdir $+ $2
    clear @LogMaster    
    iline @LogMaster 1 8,1 Log Master %logmaster.version $str($chr(160),15) 4,1 Visualizzto: $2 ( $+ $lof(%logmaster.file) byte - $lines(%logmaster.file) righe) $str($chr(160),175)
    titlebar @LogMaster - $2
    loadbuf -p @LogMaster $logdir $+ $2
    sline @LogMaster 15
    window @LogMaster @LogMaster2
  }
}
alias logview.newwindow {
  if ($2 == $null) {
    if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
    else {
      set %logmaster.window @ [ $+ [ $sline(@LogMaster,1) ] ]
      set %logmaster.file $logdir $+ $sline(@LogMaster,1)
      window -x %logmaster.window @LogView Arial 11
      iline %logmaster.window 1 8,1 Log Master %logmaster.version $str($chr(160),15) 4,1 Visualizzato: $sline(@LogMaster,1) ( $+ $lof(%logmaster.file) byte - $lines(%logmaster.file) righe) $str($chr(160),175)
      loadbuf -p %logmaster.window $logdir $+ $sline(@LogMaster,1)
      aline %logmaster.window 4,1 Caricato con successo $calc($line(%logmaster.window,0) - 1) di $lines(%logmaster.file) righe. $str($chr(160),175)
      sline %logmaster.window 15 
    }
  }
  else {
    set %logmaster.window @ [ $+ [ $2 ] ]
    set %logmaster.file $logdir $+ $2
    window -x %logmaster.window @LogView Arial 11
    iline %logmaster.window 1 8,1 Log Master %logmaster.version $str($chr(160),15) 4,1 Visualizzato: $2 ( $+ $lof(%logmaster.file) byte - $lines(%logmaster.file) righe) $str($chr(160),175)
    loadbuf -p %logmaster.window $logdir $+ $2
    aline %logmaster.window 4,1 Caricato con successo $calc($line(%logmaster.window,0) - 1) di $lines(%logmaster.file) righe. $str($chr(160),175)
    sline %logmaster.window 15 
  }
}

menu @LogMaster {
  dclick loglist2
  Visualizza
  .In questa finestra:logview
  .In una nuova finestra:logview.newwindow
  .In Blocco Note:lognotepad
  Trova nel file:logsearch
  -
  Gestione file
  .Elimina:dellog $sline(@LogMaster,1)
  .Copia:copylog
  .Rinomina:remlog
  -
  Aggiorna elenco:logrefresh
  Chiudi finestra:window -c @LogMaster
  -
  Guida:logmaster.help
  Informazioni sull'Utilità:logmaster.about
}
menu @LogMaster2 {
  dclick loglist2
  Visualizza
  .In questa finestra:logview
  .In una nuova finestra:logview.newwindow
  .In Blocco note:lognotepad
  Trova nel file:logsearch
  Aggiorna file:lrefresh
  Vai
  .All'inizio:sline @LogMaster 15
  .Alla fine:sline @LogMaster $line(@LogMaster,0)
  .-
  .Alla riga?:sline @LogMaster $?="Please Enter a Line Number"
  -
  Gestione file
  .Elimina:dellog $sline(@LogMaster,1)
  .Copia:copylog
  .Rinomina:remlog
  -
  Aggiorna elenco:logrefresh
  Chiudi finestra:window -c @LogMaster
  -
  Guida:logmaster.help
  Informazioni sull'Utilità:logmaster.about
}
alias lrefresh {
  if (($window(@Logmaster).title == - Guida) || ($window(@Logmaster).title == - Informazioni su Utilità di Gestione File Registro)) { halt }
  else {
    set %logmaster.title $window(@Logmaster).title
    set %logmaster.title.2 $len(%logmaster.title)
    set %logmaster.title $mid(%logmaster.title,3,%logmaster.title.2)
    logview %logmaster.title
  }
}
alias LogList2 {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
  else logview $sline(@LogMaster,1)
}
menu @Logview {
  Visualizza in Blocco Note:run notepad.exe $logdir $+ $remove($active,@)
  Trova nel file:logsearch.nw
  Aggiorna file:clear $active | logview.newwindow $remove($active,@)
  Vai
  .All'inizio:sline $active 15
  .Alla fine:sline $active $line($active,0)
  .-
  .Alla riga?:sline $active $?="Please Enter a Line Number"

  -
  Chiudi finestra:window -c $active
  -
  Guida:window -a @LogMaster | logmaster.help
  Informazioni sull'Utilità:window -a @LogMaster | logmaster.about
}
menu @Confirm.Delete {
  dclick Confirm.Delete
}
alias Confirm.Delete {
  if ($sline(@Confirm.Delete,1).ln == 1 || $sline(@Confirm.Delete,1).ln == 2 || $sline(@Confirm.Delete,1).ln == 3 || $sline(@Confirm.Delete,1).ln == 4) { halt }
  if ($sline(@Confirm.Delete,1).ln == 5) { remove $logdir $+ %logmaster.log.delete | window -c @Confirm.Delete | dline -l @LogMaster $sline(@LogMaster,1).ln | echo 1,1.8,1Log Master %logmaster.version -4,1 %logmaster.log.delete ELIMINATO!1,1. }
  if ($sline(@Confirm.Delete,1).ln == 6) { window -c @Confirm.Delete }
}
alias copylog {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
  /copy $logdir $+ $sline(@LogMaster,1) $sdir="Selezionare la cartella di destinazione di $sline(@LogMaster,1) :" $+ $sline(@LogMaster,1)
}
alias remlog {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
  else {
    set %logmaster.newname $?="Inserire nuovo nome file:"
    if (%logmaster.newname == $null) { halt }
    else {
      rename $logdir $+ $sline(@LogMaster,1) $logdir $+ %logmaster.newname
      logrefresh
    }
  }
}
alias dellog {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt } 
  else {
    set %logmaster.log.delete $sline(@LogMaster,1)
    window -l @Confirm.Delete 20 20 150 111 @Confirm.Delete Arial 11
    aline @Confirm.Delete 8,1 Si è sicuri di voler $str($chr(160),10)
    aline @Confirm.Delete 8,1 eliminare: $str($chr(160),50)
    aline @Confirm.Delete 8,1 $sline(@LogMaster,1) $+ ? $str($chr(160),100)
    aline @Confirm.Delete 8,1 ------------------------------------ $str($chr(160),10)
    aline @Confirm.Delete 4,1 SI $str($chr(160),50)
    aline @Confirm.Delete 4,1 NO $str($chr(160),50)
  }
}
alias dellog2 {
  set %logmaster.log.delete $remove($active,@)
  window -l @Confirm.Delete 20 20 150 111 @Confirm.Delete2 Arial 11
  aline @Confirm.Delete 8,1 Si è sicuri di voler $str($chr(160),10)
  aline @Confirm.Delete 8,1 eliminare: $str($chr(160),50)
  aline @Confirm.Delete 8,1 %logmaster.log.delete $+ ? $str($chr(160),100)
  aline @Confirm.Delete 8,1 ------------------------------------ $str($chr(160),10)
  aline @Confirm.Delete 4,1 SI $str($chr(160),50)
  aline @Confirm.Delete 4,1 NO $str($chr(160),50)
}
menu @Confirm.Delete2 {
  dclick Confirm.Delete2
}
alias Confirm.Delete2 {
  if ($sline(@Confirm.Delete,1).ln == 1 || $sline(@Confirm.Delete,1).ln == 2 || $sline(@Confirm.Delete,1).ln == 3 || $sline(@Confirm.Delete,1).ln == 4) { halt }
  if ($sline(@Confirm.Delete,1).ln == 5) { remove $logdir $+ %logmaster.log.delete | window -c @Confirm.Delete | logrefresh | echo 1,1.8,1Log Master %logmaster.version -4,1 %logmaster.log.delete ELIMINATO!1,1. }
  if ($sline(@Confirm.Delete,1).ln == 6) { window -c @Confirm.Delete }
}
alias lognotepad {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
  else run notepad.exe $logdir $+ $sline(@LogMaster,1)
}
alias logsearch {
  if ($sline(@LogMaster,1).ln == 1 || $sline(@LogMaster,1).ln == 2 || $sline(@LogMaster,1).ln == $null) { halt }
  if ($window(@Logmaster).title == - $sline(@LogMaster,1)) goto next
  else { logview $sline(@LogMaster,1) | goto next }
  :next
  if ($window(@LogSearch) != $null) /window -c @LogSearch
  window -lx @LogSearch @LogSearch Arial 11
  set %logmaster.file $logdir $+ $sline(@LogMaster,1)
  set %logmaster.log $sline(@LogMaster,1)
  titlebar @LogSearch - %logmaster.log
  set %logmaster.searchstring * [ $+ [ $?="Inserire il testo da trovare:" ] $+ ] *
  if ($! == $null) { 
    aline @LogSearch 4,1 Log Master %logmaster.version  $str($chr(160),150) 8,1Ricercatore $str($chr(160),100)
    aline @LogSearch 8,1 $str($chr(160),20) Ricerca in %logmaster.log per:4,1 Nulla (L'utente ha premuto Annulla) $str($chr(160),500)
  }
  else {
    aline @LogSearch 4,1 Log Master %logmaster.version  $str($chr(160),150) 8,1Ricercatore $str($chr(160),100)
    aline @LogSearch 8,1 $str($chr(160),20) Ricerca in %logmaster.log per:4,1 %logmaster.searchstring  $str($chr(160),500)
    filter -fwn %logmaster.file @LogSearch %logmaster.searchstring
  aline @LogSearch 4,1 Trovato $calc($line(@LogSearch,0) - 2) occorrenze di %logmaster.searchstring in %logmaster.log $str($chr(160),500)   }
}
menu @LogSearch {
  dclick logsearch2
  Vai alla riga:logsearch2
  -
  Chiudi finestra:window -c @LogSearch
  -
  Guida:window -a @LogMaster | logmaster.help
  Informazioni sull'Utilità:window -a @LogMaster | logmaster.about
} 
alias logsearch2 {
  if ($sline(@LogSearch,1).ln == 1 || $sline(@LogLogSearch,1).ln == 2 || $sline(@LogSearch,1).ln == $null) { halt }
  else {
    sline @LogMaster $calc($gettok($sline(@LogSearch,1),1,32) + 10)
    window -a @LogMaster
  }
}
alias logsearch.nw {
  set %logmaster.window $remove($active,@)
  if ($window(@LogSearch) != $null) window -c @LogSearch
  window -lx @LogSearch @LogSearch.nw Arial 11
  set %logmaster.file $logdir $+ %logmaster.window
  titlebar @LogSearch - %logmaster.window
  set %logmaster.searchstring * [ $+ [ $?="Inserire il testo da trovare:" ] $+ ] *
  aline @LogSearch 4,1 Log Master %logmaster.version  $str($chr(160),150) 8,1Ricercatore $str($chr(160),100)
  aline @LogSearch 8,1 $str($chr(160),20) Ricerca di:4,1 %logmaster.searchstring  $str($chr(160),500)
  filter -fwn %logmaster.file @LogSearch %logmaster.searchstring
  aline @LogSearch 4,1 Trovato $calc($line(@LogSearch,0) - 2) occorrenze di %logmaster.searchstring in %logmaster.window $str($chr(160),500) 
}
menu @LogSearch.nw {
  dclick:logsearchnw
  Vai alla riga:logsearchnw
  -
  Chiudi finestra:window -c @LogSearch
  Guida:window -a @LogMaster | logmaster.help
  Informazioni sull'Utilità:window -a @LogMaster | logmaster.about
} 
alias logsearchnw {
  if ($sline(@LogSearch,1).ln == 1 || $sline(@LogSearch,1).ln == 2 || $sline(@LogSearch,1).ln == $null) { halt }
  else {
    set %logmaster.window2 @ $+ %logmaster.window
    sline %logmaster.window2 $calc($gettok($sline(@LogSearch,1),1,32) + 10)
    window -a %logmaster.window2
  }
}
