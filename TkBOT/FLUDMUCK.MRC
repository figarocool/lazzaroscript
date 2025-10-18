;*******     FLOOD PROTECTION -- (c) the #LazZaro ops
;*******     Generic Flood Protection without timers
;*******     Usable against all kinds of flooding
;*******     
;*******     Syntax of identifier : $fludd(address,type,T,MAX)
;*******              - address : address or nick of the person who's events you wanna track
;*******              - type : the type of event, can be any name, however names like text,action,nick,ctcp seem logical
;*******              - MAX in T : the maximum number of events in T seconds that will be allowed
;*******              


on 1:CONNECT {
  .remini flood.ini $me
}

on 1:DISCONNECT {
  .remini flood.ini $me
}

on @10:text:*:#: {
  if ($dont($chan,$fulladdress) == $true) { return }
  if (%textflood. [ $+ [ $chan ] ] == ON) || (%textflood.all == ON) {
    if ($fludd($address,text,%set.tf.sec,%set.tf.max) == $true) {
      ban -u [ $+ [ %set.ban.textflood ] ] $chan $nick 3
      kick $chan $nick Shut Up! on $chan
    }
  }
}

on @10:action:*:#: {
  if ($dont($chan,$fulladdress) == $true) { return }
  if (%textflood. [ $+ [ $chan ] ] == ON) || (%textflood.all == ON) {
    if ($fludd($address,text,%set.tf.sec,%set.tf.max) == $true) {
      ban -u [ $+ [ %set.ban.textflood ] ] $chan $nick 3
      kick $chan $nick Shut Up! Action flood on $chan
    }
  }
}    

ctcp +10:*: {
  if ($me isop $target) {
    if ($dont($target,$fulladdress) == $true) { halt }
    if (%ctcp. [ $+ [ $target ] ] == ON) || (%ctcp.all == ON) {
      if ($fludd($address,ctcp,%set.chanctcp.sec,%set.chanctcp.max) == $true) {
        ban -u [ $+ [ %set.ban.chanctcp ] ] $target $nick 3
        kick $target $nick No More CTCP on $target Please!
      }
    }
  }
  :end
}

on @10:nick {
  ;This assumes you have an updated Internal Address List at all times
  if ($fludd($address($newnick,3),nick,10,2) == $true) {
    set %counter 1
    set %total $comchan($newnick,0)
    :start
    if (%counter <= %total) {
      set %nickchan $comchan($newnick,%counter)
      if ($me isop %nickchan) && ($dont(%nickchan,$address($newnick,5)) != $true) && ((%nick. [ $+ [ %nickchan ] ] == ON) || (%nick.all == ON)) {
        ban -u [ $+ [ %set.ban.nick ] ] %nickchan $newnick 3
        kick %nickchan $newnick Don't Change your Nick too Often
      }
      inc %counter
      goto start
    }
    unset %counter %total
  }
}

alias fludd {
  if ($lof(flood.ini) > 32000) { remove flood.ini }
  
  ;setting of a dummy variable that makes later evaluation of complex variables easier
  set %fl $1 $+ . $+ $2
  
  ;reads the values from the ini file
  set %darray $readini flood.ini $me %fl
  
  ;add time of latest event the the array
  %newtime = $calc($ctime + $3 + 0. [ $+ [ $r(100,999) ] ] )
  set %darray $addtok(%darray,%newtime,94)
  unset %newtime
  
  ;delete all the times of events that are outside the timeflood window
  :reset
  set %dummy2 $gettok(%darray,1,94)
  if (%dummy2 != $null) && (%dummy2 < $ctime) {
    set %darray $remtok(%darray,%dummy2,94)
    goto reset
  }    
  unset %dummy2
  
  ;check to see if there's a flood going on
  if ($gettok(%darray,0,94) > $4)  {
    remini flood.ini $me %fl
    unset %darray
    return $true
  }  
  else { 
    writeini flood.ini $me %fl %darray
    unset %darray
    return $false
  }
  
}


alias flood.help {
  set %h.win @FloodProt Help
  window -c %h.win
  window %h.win 156 60 531 248 Arial 15
  aline -c5 %h.win Generic Channel Flood Protection © 1998 the #LazZaro ops
  aline -c5 %h.win --------------------------------------------------------------------------
  aline -c10 %h.win This script contains an identifier and examples that will allow 
  aline -c10 %h.win you to use generic channel flood protection
  aline -c10 %h.win  
  aline -c10 %h.win The syntax of the identifier is : $chr(36) $+ fludd(address,type,T,MAX)
  aline -c10 %h.win - address : address or nick of the person who's events you wanna track
  aline -c10 %h.win - type : the type of event, can be any name (ctcp, text, moo)
  aline -c10 %h.win - MAX in T : the maximum number of events in T seconds that will be allowed
  aline -c10 %h.win Examples in the script itself
  aline -c10 %h.win  
  aline -c10 %h.win For questions : LazZaro.s@tiscalinet.it
  unset %h.win
}
