;####################################################
;####%                                     Lag.mrc for mIRC 5.x                                                %###
;###################################################

alias Lgchk { .timer222 0 %Lag.mrc.secs Lagchk }
alias Lagchk { %Lag.mrc.tmp = $ticks | .raw Lag-test }
alias Lagon { echo -a 12(10Lag.mrc12) 14is now 4on | %Lagchk = on | Lgchk }
alias Lagoff { echo -a 12(10Lag.mrc12) 14is now 4off | %Lagchk = off | .timer222 off }
alias shoLag { echo -a 10Lag check 14Server: 12 $+ $server $+  10Lag: 14 $+ %Lag.mrc $+  }
alias Lagset { if $1 == $null { echo -a 12(10Lag.mrc12) 14syntax: /12Lagset <seconds> | halt } | else { %Lag.mrc.secs = $1 | echo -a 14set auto Lag check to %Lag.mrc.secs $+ 14secs | if %Lagchk == on { Lgchk } | halt } }
alias unLag { echo -a 12(10Lag.mrc12) 14unLagging yEW! | .unload -rs $mircdiraddon\Lag.mrc | %ver = $remove(%ver,+ Lag.mrc v1.0 DoeL) | unset %Lag.mrc* %tmp %Lagchk | .timer222 off | echo -a 12(10Lag.mrc12) 14unLagged completed!! | echo -a 12(10Lag.mrc12) 14ThanKz fOR uziNg mEYE aDDON!! -DoeL | halt }
alias Lagver me eR33t wit Lag.mrc v1.0 DoeL 
alias Laghelp {   
  echo -a .14----12(10Lag.mrc12) v1.0 14help center-----------  
  echo -a $chr(124) /12Lagchk : 14test yEWR Lag  
  echo -a $chr(124) /12Lagon  : 14turn Lag check on  
  echo -a $chr(124) /12Lagoff : 14turn Lag check off  
  echo -a $chr(124) /12Lagset : 14secs between autocheck  
  echo -a $chr(124) /12Lagver : 14show version to channel
  echo -a $chr(124) /12UnLag  : 14unload dis sheeeit  
  echo -a $chr(124) /12Laghelp: 14¿¿¿  
  echo -a '14-----------------------------------------
}
raw 421:* {   if $2 == Lag-test {
    %Lag.mrc = $ticks - %Lag.mrc.tmp
    if $len(%Lag.mrc) == 3 { %Lag.mrc = . $+ %Lag.mrc $+ secs | shoLag | halt }
    if $len(%Lag.mrc) < 3 { %Lag.mrc = .0 $+ %Lag.mrc $+ secs | shoLag | halt }
    if $len(%Lag.mrc) > 3 { %tmp = $len(%Lag.mrc) - 3 | %Lag.mrc = $mid(%Lag.mrc,1,%tmp) $+ . $+ $mid(%Lag.mrc,%tmp,3) $+ secs | shoLag | halt }
  }
}

on 1:LOAD: {   
 
  
  /echo -a 15,15.....................................................              
  /echo -a 15,15....12,15_/15,15................................4v1.015,15.4DoeL15,15......
  /echo -a 15,15...12,15_/15,15......12,15_/_/15,15..12,15_/_/15,15........12,15_/_/_/_/15,15.12,15_/_/_/15,15.12,15_/_/_/15,15..
  /echo -a 15,15..12,15_/15,15.....12,15_/_ _/15,15.12,15_/15,15..12,15__15,15..12,15__15,15..12,15_/15,15.12,15_/15,15.12,15_/15,15.12,15_/15,15.....12,15_/15,15.......
  /echo -a 15,15..12,15_/_/15,15..12,15_/15,15..12,15_/15,15..12,15/_/_/15,15..12,15/_/15,15.12,15_/15,15....12,15_/15,15.12,15_/15,15.....12,15_/_/_/15,15....
  /echo -a 15,15..................................................... 
  /echo -a 12(10Lag.mrc12) v1.0 14Loaded successfully!...  
  echo -a 12(10Lag.mrc12) v1.0 14auto Lag check set to 60 secs (default)  
  echo -a 12(10Lag.mrc12) v1.0 /12Laghelp 14getting help for usin this aDDON  
  %Lag.mrc.secs = 60  
  %Lagchk = on  
  Lgchk 
}
on 1:CONNECT: { if %Lagchk == on { Lgchk } }
