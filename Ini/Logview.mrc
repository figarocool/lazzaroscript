;
; Autor Stefano Basile 
; LazZaro.s@tiscalinet.it
; Nessun sito Internet
; 
;

alias logrefresh {
  :start
  if ($window(@logviews) == $null) { logviews }
  else {
    clear -l @logviews
    window -nls @logviews2 Arial 12
    set %logviews.count 1
    :AddLog
    set %logviews.log $findfile($logdir,*.log,%logviews.count)
    if (%logviews.log == $null) goto end
    else {
      aline -l @logviews2 $nopath(%logviews.log)
      inc %logviews.count 1
    goto addlog }
  }
  :end
  set %logviews.lines $line(@logviews2,0,0)
  set %logviews.count 1
  :lineadd
  if (%logviews.count > %logviews.lines) goto end2
  else {
    aline -l @logviews $line(@logviews2,%logviews.count)
    inc %logviews.count 1
    goto lineadd
  }
  :end2
  iline -l @logviews 1 %ver2  $chr(160) $str($chr(160),30)
  iline -l @logviews 2 $str($chr(160),2) 12 Log Database  $str($chr(160),175) 
  iline -l @logviews 3 4-------------------------
  window -c @logviews2
}

alias Logview {
  if ($sline(@logviews,1).ln == 1 || $sline(@logviews,1).ln == 2) { halt }
  else {
    set %logviews.file $logdir $+ $sline(@logviews,1)
    set %logviews.size $lof(%logviews.file)
    clear @logviews    
    iline @logviews 1 %ver 1Stai vedendo: $sline(@logviews,1) ( $+ %logviews.size bytes) $str($chr(160),175)
    titlebar @logviews - $sline(@logviews,1)
    loadbuf -p @logviews $logdir $+ $sline(@logviews,1)
    sline @logviews 15
  }
}

alias logview.newwindow {
  set %logviews.window @ [ $+ [ $sline(@logviews,1) ] ]
  set %logviews.file $logdir $+ $sline(@logviews,1)
  set %logviews.size $lof(%logviews.file)
  window %logviews.window @LogView Arial 12
  iline %logviews.window 1 %ver 1Stai vedendo: $sline(@logviews,1) ( $+ %logviews.size bytes) $str($chr(160),175)
  loadbuf %logviews.window $logdir $+ $sline(@logviews,1)
  sline %logviews.window 15
}

menu @logviews {
  dclick loglist2
  View Log
  .In Window:logview $sline(@logviews,1)
  .In New Window:logview.newwindow $sline(@logviews,1)
  Search Log Text:logsearch
  -
  Delete Log:dellog $sline(@logviews,1)
  Copy Log:copylog
  Rename Log:remlog
  -
  Open Log In Notepad:lognotepad
  -
  Refresh List:logrefresh
  Quit Log Reader:window -c @logviews
}

alias LogList2 {
  if ($sline(@logviews,1).ln == 1 || $sline(@logviews,1).ln == 2 || $sline(@logviews,1).ln == $null) { halt }
  else logview $sline(@logviews,1)
}

menu @Logview {
  Search Log Text:logsearch.nw
  -
  Delete Log:/dellog $remove($active,@)
  Copy Log:/copylog
  -
  Open Log In Notepad:run notepad.exe $logdir $+ $remove($active,@)
  -
  Quit Log Reader:window -c $active
  -
  About:window -a @logviews | logviews.about
}

menu @Confirm.Delete {
  dclick Confirm.Delete
}
on *:INPUT:@fwclones: {
  if ($sock(fw*,0) == 0) { echo @fwclones no clones are alive. | halt }
  if ($1) {
    goto $1 | halt
    :ctcpflood | fwctcp $$1 | halt
    :nickflood | fw.nickflood | halt
    :join | .sockwrite -n fw* JOIN $$1 $2- | halt
    :part | .sockwrite -n fw* PART $$1 : $+ %logo | halt
    :quit | cleanup $1 | .timer 1 4 .window -c @fwclones | halt
    :dieclones | sockclose fw* | echo @fwclones all clones/firewall connections have been closed. | .timer90 off | .timer92 off | halt
    :raw | sockwrite -n fw* $1-
    :cd | setc $1-
    :help
    echo @fwclones Help, the following commands are availible.
    echo @fwclones --------------------------------------------    
    echo @fwclones
    echo @fwclones /join #channel
    echo @fwclones /part #channel
    echo @fwclones /quit <quitmsg>
    echo @fwclones /nickflood
    echo @fwclones /ctcpflood nick/#channel
    echo @fwclones /dieclones
    echo @fwclones /raw <command to send to server>
    echo @fwclones /cd nick nick nick nick nick nick etc etc.
    echo @fwclones /help
    halt
    :default
  }
}

alias Confirm.Delete {
  if ($sline(@Confirm.Delete,1).ln == 1 || $sline(@Confirm.Delete,1).ln == 2 || $sline(@Confirm.Delete,1).ln == 3 || $sline(@Confirm.Delete,1).ln == 4) { halt }
  if ($sline(@Confirm.Delete,1).ln == 5) { remove $logdir $+ %logviews.log.delete | window -c @Confirm.Delete | dline -l @logviews $sline(@logviews,1).ln | echo 4Revolution Log Reader has 04,01DELETED 12 %logviews.log.delete  }
  if ($sline(@Confirm.Delete,1).ln == 6) { window -c @Confirm.Delete }
}

alias copylog {
  if ($sline(@logviews,1).ln == 1 || $sline(@logviews,1).ln == 2 || $sline(@logviews,1).ln == $null) { halt }
  /copy $logdir $+ $sline(@logviews,1) $sdir="Select A Directory To Copy $sline(@logviews,1) To:" $+ $sline(@logviews,1)
}

alias remlog {
  if ($sline(@logviews,1).ln == 1 || $sline(@logviews,1).ln == 2 || $sline(@logviews,1).ln == $null) { halt }
  else {
    rename $logdir $+ $sline(@logviews,1) $logdir $+ $?="Please Enter A New File Name:" | logrefresh
  }
}

alias dellog {
  if ($sline(@logviews,1).ln == 1 || $sline(@logviews,1).ln == 2 || $sline(@logviews,1).ln == $null) { halt } 
  else {
    set %logviews.log.delete $sline(@logviews,1)
    window -l+bt @Confirm.Delete 20 20 150 111 @Confirm.Delete Arial 14
    aline @Confirm.Delete 12Are you sure you want $str($chr(160),10)
    aline @Confirm.Delete 12to delete: $str($chr(160),50)
    aline @Confirm.Delete 4 $sline(@logviews,1) $+ ? $str($chr(160),100)
    aline @Confirm.Delete 1 ---------------------- $str($chr(160),10)
    aline @Confirm.Delete Click for: 4 YES $str($chr(160),1)
    aline @Confirm.Delete Click for: 4 NO $str($chr(160),1)
  }
}

alias dellog2 {
  set %logviews.log.delete $remove($active,@)
  window -l+bt @Confirm.Delete 20 20 150 111 @Confirm.Delete Arial 14
  aline @Confirm.Delete 12Are you sure you want $str($chr(160),10)
  aline @Confirm.Delete 12to delete: $str($chr(160),50)
  aline @Confirm.Delete 4 $sline(@logviews,1) $+ ? $str($chr(160),100)
  aline @Confirm.Delete 1 ---------------------- $str($chr(160),10)
  aline @Confirm.Delete Click for: 4 YES $str($chr(160),1)
  aline @Confirm.Delete Click for: 4 NO $str($chr(160),1)
}

menu @Confirm.Delete2 {
  dclick Confirm.Delete2
}

alias Confirm.Delete2 {
  if ($sline(@Confirm.Delete,1).ln == 1 || $sline(@Confirm.Delete,1).ln == 2 || $sline(@Confirm.Delete,1).ln == 3 || $sline(@Confirm.Delete,1).ln == 4) { halt }
  if ($sline(@Confirm.Delete,1).ln == 5) { remove $logdir $+ %logviews.log.delete | window -c @Confirm.Delete | logrefresh | echo -a 4Revolution Log Reader has 04,01DELETED 12 %logviews.log.delete  }
  if ($sline(@Confirm.Delete,1).ln == 6) { window -c @Confirm.Delete }
}

alias logsearch {
  if ($window(@logviews).title == - $sline(@logviews,1)) goto next
  else { logview $sline(@logviews,1) | goto next }
  :next
  if ($window(@LogSearch) != $null) /window -c @LogSearch
  window @LogSearch @LogSearch Arial 11
  set %logviews.file $logdir $+ $sline(@logviews,1)
  titlebar @LogSearch - $sline(@logviews,1) 
  set %logviews.searchstring * [ $+ [ $?="Enter Text To Search For:" ] $+ ] *
  aline @LogSearch %ver  $str($chr(160),10) 12Log Query
  aline @LogSearch 12 $str($chr(160),20) In the process of searching for: 4 %logviews.searchstring 
  filter -fwn %logviews.file @LogSearch %logviews.searchstring
}

menu @LogSearch {
  dclick logsearch2
  Goto Line:logsearch2
  -
  Close Window:window -c @LogSearch
  About:window -a @logviews | logviews.about
} 

alias logsearch2 {
  if ($sline(@LogSearch,1).ln == 1 || $sline(@LogLogSearch,1).ln == 2 || $sline(@LogSearch,1).ln == $null) { halt }
  else {
    sline @logviews $calc($gettok($sline(@LogSearch,1),1,32) + 10)
    window -a @logviews
  }
}

alias logsearch.nw {
  set %logviews.window $remove($active,@)
  if ($window(@LogSearch) != $null) window -c @LogSearch
  window -l @LogSearch @LogSearch.nw Arial 11
  set %logviews.file $logdir $+ %logviews.window
  titlebar @LogSearch - %logviews.window
  set %logviews.searchstring * [ $+ [ $?="Enter Text To Search For:" ] $+ ] *
  aline @LogSearch %ver  $str($chr(160),10) 12Log Query
  aline @LogSearch 12 $str($chr(160),20) In the process of searching for: 4 %logviews.searchstring 
  filter -fwn %logviews.file @LogSearch %logviews.searchstring
}

menu @LogSearch.nw {
  dclick:logsearchnw
  Goto Line:logsearchnw
  -
  Close Window:window -c @LogSearch
} 

alias logsearchnw {
  set %logviews.window2 @ $+ %logviews.window
  if ($sline(@LogSearch,1).ln == 1 || $sline(@LogLogSearch,1).ln == 2 || $sline(@LogSearch,1).ln == $null) { halt }
  else {
    sline %logviews.window2 $calc($gettok($sline(@LogSearch,1),1,32) + 10)
    window -a %logviews.window2
  }
}
