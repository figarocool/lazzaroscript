; LazZaro FTP
; By Stefano Basile

alias ftp start $1-
alias ftpc.version return 1.0
alias -l start {
  if $os = 3.1 { echo -a *** Windows 95/98/NT required | halt } | if $version < 5.5 { echo -a *** mIRC 5.5+ required | halt } 
  set -u %^s 1
  :l
  if ($window($w(%^s)) != $null) { inc %^s | goto l } | listini $f w n $w(%^s) | sd $w(%^s) log $d(g,log)
  set -u %^p $iif(@ftp* iswm $a, [ $calc(( [ $window($a).x ] + 25) % ( [ $window(-3).w ] - [ $window($a).w ] )) ]  [ $calc(( [ $window($a).y ] + 25) % ( [ $window(-3).h ] - [ $window($a).h ] )) ] ,$iif($=($d(g,pos)),$d(g,pos),25 25))
  window -fapkSl30 -t1,24,100 +fnt $w(%^s) %^p 250 335 @ftpc Ms Sans Serif 10 | set %ftpc. $+ $w(%^s) m 0 0 | cs * $+ $w(%^s)
  sd $w(%^s) qc $1- | u $w(%^s) | info -n $w(%^s) | dr -nf $w(%^s) $colour(background) 1 0 221 248 90 | dl -rn $w(%^s) $rgb(frame) 1 0 221 250 221 | info $w(%^s) FTP client by vague | titlebar $w(%^s)
  bms $w(%^s) | sel $w(%^s) | sd $w(%^s) pd $iif($d(g,pd),$d(g,pd),$getdir) | sd $w(%^s) gd $iif($d(g,gd),$d(g,gd),$scriptdir) | parse $w(%^s) $1-
}
alias -l frq cs ?. $+ $1 | if ($2) sd $1 ld $d($1,$2) | sm $1 f | urd $1 | ll $1
alias -l ` { sm $1 z | transu $1 }
alias -l transu {
  dr -rnf $1 $g2cf 1 0 45 248 140 | pbar -n $1 22 60 202 12 $d($1,ttb) $iif($d($1,ttb) < $d($1,tb),0,$d($1,tb)) $+ .
  set -u %^rm $calc($d($1,ttb) - $d($1,tb)) | set -u %^sp $iif($calc($ctime - $d($1,ts)) != 0,$calc($d($1,tb) / ($ctime - $d($1,ts)) / 1024),n/a) | mtext $1 22 45 $nopath($d($1,lf)) $iif($mk($1) = get,from,to) $d($1,a) | if (%^sp = 0) set -u %^sp n/a
  mtext $1 22 78 $´($d($1,tb)) of $iif($d($1,ttb) < $d($1,tb),unknown,$´($d($1,ttb))) transfered; $round(%^sp,2) $+ kb/s average;-; $iif(%^sp != n/a,$duration($calc($ctime - $d($1,ts))),No time) elapsed; $iif(($d($1,ttb) < $d($1,tb)) || (%^sp = n/a),unknown,$duration($int($calc((%^rm / 1024) / %^sp)))) remaining;-; $d($1,tdone) files done, $d($1,tleft) waiting 
  drawdot $1
}
alias -l spt {
  set %^i 15
  :l
  if ($width($left($2-,%^i),MS Sans Serif,13,0,0) < $1) { inc %^i | if ($left($2-,%^i) != $2-) goto l } | return $left($2-,%^i) $+ $iif($left($2-,%^i) != $2-, [ ..;.. $+ [ $mid($2-, $calc(%^i + 1) ,999) ] ] )
}
alias -l ll {
  clear -l $1 | uld $1 | drawdot $1 | if ($=($d($1,ld))) aline -l $1 $sdr(..) | aline -l $1 $sdr(.)
  if ($-($d($1,ld))) {
    set %^i 65
    :l3 
    if ($exists( [ [ $chr(%^i) ] $+ :/ ] )) aline -l $1 $sdr( [ [ $chr(%^i) ] $+ : ] ) | inc %^i | if (%^i < 91) goto l3
  }
  else {
    if ($d($1,frq) != d) {
      set %^i 1
      :l1
      set -u %^f $findfile($d($1,ld),*,%^i,1) | if ($=(%^f)) { aline -l $1 $sfl($lof(%^f),$nopath(%^f)) | inc %^i | goto l1 }
    }
    set %^i 1
    :l2 
    set -u %^f $finddir($d($1,ld),*,%^i,1) | if (%^f) { aline -l $1 $sdr($gettok(%^f,$numtok(%^f,92),92)) | inc %^i | goto l2 }
} }
alias -l sel if ($=($2)) { sd $1 sel $2- | sd g sel $2- } | else { if ($line($1,0,1)) sline -l $1 1 | if ($=($d(g,sel))) if ($fline($1,$d(g,sel),0,1)) sline -l $1 $fline($1,$d(g,sel),1,1) | if ($=($d($1,sel))) if ($fline($1,$d($1,sel),0,1)) sline -l $1 $fline($1,$d($1,sel),1,1) }
alias -l parse {
  if ($fline($1,$2-,1,1)) con $1 $2-
  elseif ($=($2-)) {
    sd $1 u | sd $1 a | sd $1 pw | sd $1 p | if (@ isin $2) { set -u %^a $gettok($2,$wildtok($2,*,0,64),64) | set -u %^b $gettok($2, [ 1- $+ [ $calc($wildtok($2,*,0,64) - 1) ] ] ,64) }
    else { set -u %^a $2 | set %^b } | sd $1 u $gettok(%^b,2-,58) | sd $1 $iif(: isin %^b,pw,u) $gettok(%^b,1,58) | sd $1 a $gettok($gettok(%^a,1,58),1,47) | sd $1 d $gettok($gettok(%^a,1,58),2-,47) | if ($d($1,d)) sd $1 d / $+ $d($1,d) | sd $1 p $gettok(%^a,2,58) | if ($d($1,p) !isnum) sd $1 p 21 | con $1
} }
alias -l div dl -rn $1 $g2cs 1 $2 3 $2 24 | dl -rn $1 $g2ch 1 $calc($2 + 1) 3 $calc($2 + 1) 24
alias -l u {
  g2.reset $1 | dr -rnf $1 $g2cf 1 0 0 250 220 | dl -rn $1 $g2ch 1 0 28 250 28 | dl -rn $1 $g2cs 1 0 27 250 27 | set -u %^ti 1
  :l1
  set %^a $gui($1,_,_,%^ti) | if (%^a) { dd -n $1 %^a | inc -u %^ti | goto l1 } | dl -rn $1 $g2cs 1 1 220 250 220 | div $1 30 | div $1 190 | div $1 134 | set -u %^ti 1
  :l2
  if (%^ti < 10) { set -u %^a $"($1,%^ti) | brun $1 %^a | inc -u %^ti | goto l2 } | if ($m($1) = t) { mtext $1 17 45 User: $iif($=($d($1,u)),$d($1,u),n/a) ;Bookmark: $iif($=($d($1,bm)),$d($1,bm),n/a) ;Server: $d($1,a) ;Port: $d($1,p) ;Default directory: $iif($=($d($1,d)),$d($1,d),n/a) } | dl -rn $1 $g2cs 1 249 0 249 450 | drawdot $1
}
alias -l dd $3 $1 $2 $5-
alias -l mtext {
  set %^i 1 | set -u %^a $3
  :l
  if ($gettok($4-,%^i,59)) { if ($gettok($4-,%^i,59) = -) inc -u0 %^a 8 | else { drawtext -rnc $1 $g2ct $fn" 13 $2 %^a $calc(238 - $2) 99 $gettok($4-,%^i,59)) | inc -u0 %^a 14 } | inc %^i | goto l }
}
alias -l end sd g pos $window($1).x $window($1).y | dun $1 | cs * $+ $1 | .timer $+ $1 $+ .NOOP off | unlistini $f w n $1 | remini $f $1 | set %ftpc. $+ $1 | close -@ $1 |  g2.reset $1
alias -l con {
  if ($sock($1)) dcon $1 | if ($=($2)) { sd $1 bm $2- | sel $1 $2- | sd $1 a $d($k($2-),a) | sd $1 p $d($k($2-),p) | sd $1 u $d($k($2-),u) | sd $1 pw $d($k($2-),pw) | sd $1 d $d($k($2-),d) }
  else sd $1 bm | sd $1 try n | sockopen $1 $d($1,a) $d($1,p) | sockmark $1 n | c2 $1 Connecting to $d($1,a) ( $+ $d($1,p) $+ ) | .timerdcon $+ $1 off | sm $1 t | info $1 Connecting to $d($1,a) ( $+ $d($1,p) $+ ) | g2.reset $1
}
alias -l dcon dun $1 | cs * $+ $1 | sc $1 0 | sl $1 0 | .timer $+ $1 $+ .NOOP off | .timerdcon $+ $1 -om 1 0  sm $1 m $chr(124) info $1 Disconnected | titlebar $1 | c1 $1 Disconnected | sd $1 rd | bms $1 | sel $1
on *:sockclose:@ftp* { dcon $sn }
on *:sockopen:@ftp* { if ($sockerr) { .timer -om 1 0 sm $sn m $chr(124) info $sn Connection attempt failed | g2.reset $sn | err $sn Connection attempt failed } | titlebar $sn ?@ $+ $d($sn,a) | sd $sn at 0 }
on *:sockread:@ftp* {
  if ($sockerr) { err $sn Connection closed (error $sockerr $+ ) }
  :l
  sockread %^d | if $sockbr { if (($gettok(%^d,2,32) != $null) || ($gettok(%^d,1,32) isnum)) { num $sn %^d } | goto l } | set %^d
}
alias -l num {
  say $sn $colour(normal) $2-
  if ($2 = 257) { if ($d($1,mkd)) { if ($m($1) = c) mkf $1 $d($1,mkd) | sd $1 mkd } | else { set -u %^t $iif($-($d($1,rd)) && $=($d($1,d)),1,0) | sd $1 rd $gettok($2-,2,34) $+ $iif($right($gettok($2-,2,34),1) != /,/) | if (%^t) do $1 CWD $d($1,d) | else { info $1 | list $1 } } }
  if ($2 = 230) { titlebar $1 $d($1,u) $+ @ $+ $d($1,a) | sl $1 1 |  info $1 Logged in to $d($1,a) as $d($1,u) | mc $1 -n | sd $1 at 0 | sd $1 rnt | sd $1 mkd }
  if ($2 = 220) { if ($-($d($1,u))) { c2 $1 Please enter user name.. | sd $1 u anonymous | sd $1 try u | u $1 | window -a $1 } | else { do $1 USER $d($1,u) } }
  if ($2 = 331) { if ($-($d($1,pw))) { c2 $1 Please enter password.. | if ($d($1,u) = anonymous) sd $1 pw $email | sd $1 try pw | u $1 | window -a $1 } | else { .do $1 PASS $d($1,pw) } }
  if ($2 = 250) { if ($d($1,rnt)) rnm $1 c $d($1,rnt) | else pwd $1 }
  if (($2 = 200) && ($3 = PORT)) { if ($mk($1) = list) do $1 LIST | if ($mk($1) = get) do $1 RETR $d($1,rf) | if ($mk($1) = put) do $1 STOR $d($1,rf) }
  if ($2 isin 550.450.553.501) { if ($d($1,mkd)) sd $1 mkd | elseif ($d($1,rnt)) sd $1 rnt | elseif ($mk($1) = get) next $1 get | else { info $1 | list $1 } }
  if (($2 = 425) || (($2 = 500) && ($4 = PORT))) { sd $1 at $calc($d($1,at) + 1) | if ($d($1,at) < 5) { if ($mk($1) != list) f $+ $mk($1) $1 | else list $1 } | else { c1 $1 Can't establish data connection | mc $1 1 } }
  if ($2 = 350) { do $1 RNTO $d($1,rnt) }
}
alias -l type do $1 TYPE $2
alias -l prt set -u %^p $nprt($1) | do $1 PORT $replace( [ $ip $+ . $+ [ $gettok($longip(%^p),3-,46) ] ] ,.,$chr(44))  | return %^p
alias -l pwd sockmark $1 pwd | do $1 PWD
alias -l list clear -l $1 | urd $1 | type $1 A | lsock $1 | sockmark $1 list 
alias -l cd {
  if ($m($1) != f) { if ($2- = ..) do $1 CDUP | elseif ($2 = -a) do $1 CWD $3- | else do $1 CWD $d($1,rd) $+ $2- }
  else { if ($2- = ..) { if (?:\ !iswm $d($1,ld)) sd $1 ld $gettok($d($1,ld), [ 1- [ $+ [ $calc($numtok($d($1,ld),92) - 1) ] ] ] ,92) $+ \ | else sd $1 ld } | elseif ($2- != .) sd $1 ld $d($1,ld) $+ $2- $+ \ | ll $1 }
}
alias -l lsock cs ?. $+ $1 | socklisten l. $+ $1 $prt($1) | sockmark l. $+ $1 $1
on 1:socklisten:l.@ftp* { sockaccept d. $+ $mk($sn) | sockmark d. $+ $mk($sn) $mk($sn) | sd $mk($sn) at 0 | if ($mk($mk($sn)) = put) psh $mk($sn) | cs $sn }
on 1:sockclose:d.@ftp* {
  if ($mk($mk($sn)) = list) { if ($-($fline($mk($sn),$sdr(..),1,1)) && ($d($mk($sn),rd) != /)) aline -l $mk($sn) $sdr(..) | if ($-($fline($mk($sn),$sdr(.),1,1))) aline -l $mk($sn) $sdr(.) }
  if ($mk($mk($sn)) = get) trd $mk($sn) get
}
on 1:sockwrite:d.@ftp* { if ($d($mk($sn),tb) < $d($mk($sn),ttb)) psh $mk($sn) | else trd $mk($sn) put }
alias -l trd sd $1 tdone $calc($d($1,tdone) + 1) | c2 $1 Transfer of $nopath($d($1,lf)) completed | next $mk($sn) $2
alias -l psh bread $d($1,lf) $d($1,tb) 4096 &d | sockwrite d. $+ $1 &d | sd $1 tb $calc($d($1,tb) + 4096) | transu $1
alias -l sn return $sockname
on 1:sockread:d.@ftp* {
  if ($sockerr) err $mk($sn) Data socket error
  if ($mk($mk($sn)) = get) {
    :l2
    sockread &d | sd $mk($sn) tb $calc($d($mk($sn),tb) + $sockbr) | if ($sockbr) { bwrite " $+ $d($mk($sn),lf) $+ " -1 &d | goto l2 } | transu $mk($sn)
  }
  elseif ($mk($mk($sn)) = list) {
    :l1
    sockread %^d
    if ($sockbr) {
      if ($=($gettok(%^d,9,32))) {
        if (d isin $gettok(%^d,1,32)) aline -l $mk($sn) $sdr($gettok(%^d,9-,32))
        else { if ($gettok(%^d,10,32) = ->) { if (?*.* !iswm $nopath($gettok(%^d,11-,32))) aline -l $mk($sn) $sdr($gettok(%^d,9,32)) | else aline -l $mk($sn) $sfl($gettok(%^d,5,32),$gettok(%^d,9,32)) $+ $chr(9) $gettok(%^d,11-,32) } | else aline -l $mk($sn) $sfl($gettok(%^d,5,32),$gettok(%^d,9-,32)) }
      }
      goto l1
    }
    set %^d
} }
alias -l trf {
  set %^i 1 | window -lh @ftpc.tmp $_1($1)
  :l1
  if ($sline($1,%^i)) { if ($d~ !iswm $sline($1,%^i)) aline @ftpc.tmp $sline($1,%^i) | inc -u %^i | goto l1 } | clear -l $1
  :l2
  if ($line(@ftpc.tmp,1)) { aline -l $1 $line(@ftpc.tmp,1) | dline -l @ftpc.tmp 1 | goto l2 } | sd $1 tdone 0 | close -@ @ftpc.tmp | next $1 $2
}
alias -l get sd $1 tb 0 | sd $1 ttb $sz($line($1,1,1)) | sd $1 ts $ctime | if ($=($gettok($line($1,1,1),4,9))) sd $1 rf $gettok($line($1,1,1),4,9) | else sd $1 rf $d($1,rd) $+ $fl($line($1,1,1)) | sd $1 lf $d($1,gd) $+ $fl($line($1,1,1)) | dline -l $1 1 | sd $1 tleft $line($1,0,1) | fget $1
alias -l fget {
  if ($isfile($d($1,lf))) { window -a $1 | c1 $1 File already exists | sd $1 q_n $nopath($d($1,lf)) | sm $1 q }
  elseif ((.* iswm $nopath($d($1,lf))) && (.*. !iswm $nopath($d($1,lf)))) { window -a $1 | c1 $1 Erronous filename | sd $1 q_n $nopath($d($1,lf)) | sm $1 q }
  else { write $d($1,lf) | sockmark $1 get | type $1 $iif($d($1,asc),A,I) | lsock $1 | ` $1 get }
}
alias -l next if ($line($1,0,1)) $2 $1 | elseif ($2 == get) mc $1 | else frq $1
alias -l put sd $1 tb 0 | sd $1 ttb $sz($line($1,1,1)) | sd $1 ts $ctime | sd $1 rf $d($1,rd) $+ $fl($line($1,1,1)) | sd $1 lf $d($1,ld) $+ $fl($line($1,1,1)) | dline -l $1 1 | sd $1 tleft $line($1,0,1) | fput $1
alias -l fput sockmark $1 put | type $1 $iif($d($1,asc),A,I) | lsock $1 | ` $1 put
alias -l nprt {
  set -u %^c 1
  :l
  set -u %^np $rand(10000,60000) | if ($portfree(%^np)) return %^np | inc -u %^c | if (%^c < 100) goto l | if ($mk($1) = put) ll $1 | err $1 No free port found
}
menu @ftpc {
  mouse { g2.mouse gui act }
  sclick { g2.click gui act }
  dclick {
    if ($mouse.y isnum 220-314) { run notepad.exe $logdirftpc.log } | if ($=($mouse.x)) g2.click gui act
    else {
      if ($l($a)) { if ($left($_1($a),1) = $chr(160)) cd $a $gettok($gettok($_1($a),1,9),2-,32) | elseif ($mt(f,1)) trf $a put | elseif (($left($_1($a),1) = $chr(9)) && ($mt(c,1))) trf $a get }
      elseif ($m($a) = e) e $a | elseif ($-($sock($a))) { sd $a qc $_1($a) | u $a } | elseif ($-($l($a))) { con $a $_1($a) }
  } }
  uclick { g2.uclick gui act }
  $mt(mt,Connect) { con $a $_1($a) }
  $iif($mt(f,1) && ($d($a,frq) = a),Put) { trf $a put }
  $mt(c,Get) { trf $a get }
  -
  $mt(me,Edit bookmark) { e $a }
  $mt(m,Delete bookmark) { if ($=($_1($a))) del $a }
  $mt(fc,Make new directory) { mkd $a }
  $mt(fc,Rename file) { if ($d~ iswm $_1($a)) return | sd $a rnt $$?="New name:" | if ((/ isin $!) || (\ isin $!)) { sd $a rnt | err $a Illegal name } | sd $a rnf $fl($_1($a)) | sd $a rns $sz($_1($a)) | if ($mt(f,1)) { rename $d($a,ld) $+ $fl($_1($a)) $d($a,ld) $+ $! | rnm $a f $! } | else do $a RNFR $fl($_1($a)) }
  $mt(zq,Skip file) { dline -l $a $fline($a,$_1($a),1,1) }
}
alias -l mkd sd $1 mkd $$?="Directory name:" | if ((/ isin $!) || (\ isin $!)) { sd $1 mkd | err $1 Illegal name } | if ($m($1) = f) { sd $1 mkd | mkdir $d($a,ld) $+ $! | mkf $1 $! } | else do $1 MKD $!
alias -l mkf aline -l $1 $sdr($2-) | sline -l $1 $fline($1,$sdr($2-),1,1)
alias -l rnm sd $1 rnt | c2 $1 Renamed as $3- | if ($m($1) = $2) { set -u %^nf $sfl($d($1,rns),$3-) | rline -l $1 $$fline($1,$sfl($d($1,rns),$d($1,rnf)),1,1) %^nf | sline -al $1 $fline($1,%^nf,1,1) }
on *:start { remini $f w | g2.start }
on *:close:@FTP*: { end $target }
alias -l act {
  if $3 = m_n { sd $1 e_n New site | sd $1 e_a | sd $1 e_p 21 | sd $1 e_d | sd $1 e_u anonymous | sd $1 e_pw $email | sd $1 e_new 1 | sm $1 e }
  if $3 = m_e e $1
  if ($3 = m_d) && ($=($_1($1))) del $1
  if ($3 = m_c) con $1 $_1($1)
  if $3 = m_qc parse $1 $d($1,qc)
  if $3 = m_q end $1
  if $3 = m_q end $1
  if $3 = e_c sm $1 m
  if $3 = e_ok { abm $1 | sm $1 m }
  if $3 = b_s start
  if $3 = b_p cd $1 ..
  if $3 = b_h cd $1 -a $iif($d($1,d),$d($1,d),~)
  if $3 = c_d dcon $1
  if $3 = b_r { if ($m($1) = f) ll $1 | else list $1 }
  if $3 = h hlp
  if $3 = n mkd $1
  if $3 = c_p { sd $1 frq a | frq $1 pd }
  if $3 = c_ld { sd $1 frq d | frq $1 gd }
  if $3 = f_d { if ($d($1,frq) = d) { if ($=($d($1,ld))) { sd $1 gd $d($1,ld) | sd g gd $d($1,ld) | mc $1 } | } | else { sd $1 pd $d($1,ld) | sd g pd $d($1,ld) | mc $1  } }
  if $3 = f_h { if ($d($1,frq) = d) mc $1 | else hlp }
  if ($3 = t_ok) && ($=($d($1,$d($1,try)))) { if ($d($1,try) = pw) .do $1 PASS $d($1,pw) | else do $1 USER $d($1,u) | sd $1 try n | u $1 }
  if $3 = c_g trf $1 get
  if $3 = f_p trf $1 put
  if $3 = z_c { if ($mk($1) = get) dun $1 | cs d. $+ $1 | mc $1 | c1 $1 Transfer aborted }
  if $3 = z_s { rm $d($1,lf) | next $1 $mk($1) }
  if $3 = q_o { rm $d($1,lf) | fget $1 }
  if ($3 = q_r) && ($=($d($1,q_n))) { sd $1 lf $d($1,ld) $+ $d($1,q_n) | fget $1 }
  if $3 = a { if ($d($1,asc)) sd $1 asc | else sd $1 asc 1 }
  if $3 = l { if ($d($1,log)) sd $1 log | else sd $1 log 1 | sd g log $d($1,log) }
}
alias -l gui {
  set -u %^x $2 | set -u %^y $3
  if ($3 isnum 30-250) || ($2 = _) {
    if $m($1) = m {
      if $i(20,100,210,20) || ($4 = 1) return eb qc 20 100 210 20 $f $1 qc Site:
      if $i(80,135,90,25) || ($4 = 2) return b m_qc 80 135 90 25 Connect!
      if $i(27,45,60,21) || ($4 = 3) return b m_n 27 45 60 21 Add..
      if $i(94,45,60,21) || ($4 = 4) return b m_e 94 45 60 21 Edit..
      if $i(162,45,60,21) || ($4 = 5) return b m_d 162 45 60 21 Delete
    }
    elseif $m($1) = e {
      if $i(25,45,175,20) || ($4 = 1) return eb e_n 25 45 175 20 $f $1 e_n Description:
      if $i(25,81,145,20) || ($4 = 2) return eb e_a 25 81 145 20 $f $1 e_a Address:
      if $i(185,81,40,20) || ($4 = 3) return eb e_p 185 81 40 20 $f $1 e_p Port:
      if $i(25,117,80,20) || ($4 = 4) return eb e_u 25 117 80 20 $f $1 e_u User:
      if $i(120,117,105,20) || ($4 = 5) return eb e_pw 120 117 105 20 $f $1 e_pw Password:
      if $i(25,153,175,20) || ($4 = 6) return eb e_d 25 153 175 20 $f $1 e_d Default directory:
      if $i(53,190,70,25) || ($4 = 7) return b e_ok 53 190 70 25 Ok
      if $i(127,190,70,25) || ($4 = 8) return b e_c 127 190 70 25 Cancel
    }
    elseif $m($1) = t {
      if $4 = 1 return frame _ 10 37 230 82 Connecting
      if $i(53,190,70,25) || ($4 = 2) return b $iif($d($1,try) = n,c_d 53 190 70 25 Cancel,t_ok 53 190 70 25 OK)
      if $i(127,190,70,25) || ($4 = 3) return b $iif($d($1,try) = n,h 127 190 70 25 Help..,c_d 127 190 70 25 Cancel)
      if ($i(17,137,140,20) || ($4 = 4)) && ($d($1,try) = u) return eb t_u 17 137 140 20 $f $1 u User:
      if ($i(17,137,140,20) || ($4 = 4)) && ($d($1,try) = pw) return eb t_pwd 17 137 140 20 $f $1 pw Password:
    }
    elseif $m($1) = c {
      if $i(70,130,110,25) || ($4 = 1) return b c_g 70 130 110 25  Get
      if $i(70,160,110,25) || ($4 = 2) return b c_p 70 160 110 25 Put..
      if $i(70,190,110,25) || ($4 = 3) return b c_ld 70 190 110 25  Download in..
    }
    elseif $m($1) = f {
      if $i(53,190,70,25) || ($4 = 1) return b f_d 53 190 70 25 $iif($d($1,frq) = d,OK,Done)
      if $i(127,190,70,25) || ($4 = 2) return b f_h 127 190 70 25 $iif($d($1,frq) = d,Cancel,Help..)
      if ($i(80,130,90,25) || ($4 = 3) && ($d($1,frq) != d)) return b f_p 80 130 90 25 Put
    }
    elseif $m($1) = q {
      if $i(20,60,210,20) || ($4 = 1) return eb q_n 20 60 210 20 $f $1 q_n New name:
      if $i(90,90,80,25) || ($4 = 2) return b q_r 90 90 80 25 Rename
      if $i(90,190,80,25) || ($4 = 3) return b z_s 90 190 80 25 Skip
      if ($i(90,160,80,25) || ($4 = 4) && ($isfile($d($1,lf)))) return b q_o 90 160 80 25 Overwrite
    }
    elseif $m($1) = z {
      if $i(53,190,70,25) || ($4 = 1) return b z_s 53 190 70 25 Skip
      if $i(127,190,70,25) || ($4 = 2) return b z_c 127 190 70 25 Cancel
  } }
  elseif $3 isnum 2-23 {
    if $2 isnum 4-27 return $@($"($1,1)) | if $2 isnum 34-57 return $@($"($1,2)) | if $2 isnum 58-83 return $@($"($1,3)) | if $2 isnum 84-107 return $@($"($1,4))
    if $2 isnum 108-133 return $@($"($1,5)) | if $2 isnum 138-163 return $@($"($1,6)) | if $2 isnum 164-187 return $@($"($1,7)) | if $2 isnum 194-219 return $@($"($1,8)) | if $2 isnum 220-244 return $@($"($1,9))
} }
alias -l i return $inrect(%^x,%^y,$1,$2,$3,$4)
alias -l @ if ($1 != -d) return $2-
alias -l brun $3 $2 $1 $5-12
alias -l " {
  goto $2
  :1 | return $iif($m($1) != e,-n,-d) bb $iif($sock($1),c_d,m_c) 4 2 23 23 $iif($sock($1),4,5) $rgb(192,0,0) $iif($sock($1),34 17 _ info Disconnect from site,37 17 _ info Connect to bookmarked server)
  :2 | return $iif($m($1) isin cf,-n,-d) bb b_r 34 2 23 23 2 $rgb(210,210,0) 49 17 _ info Refresh current directory
  :3 | return $iif($m($1) isin cf,-n,-d) bb b_p 58 2 23 23 4 $rgb(30,30,30) 199 20 _ info Go to parent directory
  :4 | return $iif($m($1) = c,-n,-d) bb b_h 84 2 23 23 3 $rgb(0,128,0) 80 20 _ info Go to default directory
  :5 | return $iif($m($1) isin cf,-n,-d) bb n 108 2 23 23 5 $rgb(230,230,130) 172 20 _ info Make new directory
  :6 | return $iif($l($1),-n,-d) bb a 138 2 23 23 5 $rgb(255,255,255) 50 26 $f $+ ; $+ $1 $+ ;asc info ASCII mode transfer is $iif( [ $readini [ $f ] [ $1 ] [ asc ] ] ,enabled,disabled)
  :7 | return -n bb l 164 2 23 23 3 $rgb(128,64,0) 38 17 $f $+ ; $+ $1 $+ ;log info Logging is $iif( [ $readini [ $f ] [ $1 ] [ log ] ] ,enabled,disabled)
  :8 | return -n bb b_s 194 2 23 23 5 $rgb(0,0,0) 107 14 _ info Spawn new window
  :9 | return -n bb h 220 2 23 23 2 $rgb(45,45,180) 180 26 _ info Open help in brower window
}
alias -l abm {
  set -u %^s $k($d($1,e_n))
  if ($-($d($1,e_n))) { err $1 No site name specified }
  if (($-($d($1,e_a))) || ($chr(32) isin $d($1,e_a))) { err $1 Invalid/no site address specified }
  if ($d($1,e_p) !isnum) { err $1 Invalid/no port specified }
  if ($d($1,e_new)) {
    if ($=($d($k($d($1,e_n),$chr(32)),a))) { err $1 Site with this name already exists }
  }
  else { bms -d $d($d($1,e_s),n) | remini $f $d($1,e_s) | unlistini $f s n $d($1,e_s) }
  sd %^s n $d($1,e_n) | sd %^s a $d($1,e_a) | sd %^s p $d($1,e_p) | sd %^s d $d($1,e_d) | sd %^s u $d($1,e_u) | sd %^s pw $d($1,e_pw) | listini $f s n %^s | bms -a $d($1,e_n) | sel $1 $d($1,e_n) | sel $1
}
alias -l bms {
  set %^i 0
  if ($1 = -a) || ($1 = -d)  {
    :l1
    if ($nd(w,%^i) != $null) { if ($-($l($nd(w,%^i)))) { if ($1 = -a) aline -l $nd(w,%^i) $2- | else dline -l $nd(w,%^i) $fline($nd(w,%^i),$2-,1,1) } | inc %^i | goto l1 }
  }
  else {
    clear -l $1
    :l2
    if ($=($nd(s,%^i))) { aline -l $1 $d($nd(s,%^i),n) | inc %^i | goto l2 }
} }
alias -l del if ($?!="Really delete bookmark?") { unlistini $f s n $k($_1($1)) | remini $f $k($_1($1)) | set -u %^l $sline($1,1).ln | bms -d $_1($1)) | if ($line($1,0,1)) sline -l $1 %^l }
alias -l e if ($m($1) = e) if ($?!="Save changes to this bookmark?") abm $1 | set -u %^s $k($_1($1))) | sel $1 $_1($1) | sd $1 e_a $d(%^s,a) | sd $1 e_p $d(%^s,p) | sd $1 e_n $d(%^s,n) | sd $1 e_d $d(%^s,d) | sd $1 e_u $d(%^s,u) | sd $1 e_pw $d(%^s,pw) | sd $1 e_s %^s | sd $1 e_new $false | sm $1 e
alias -l l return $gettok( [ %ftpc. [ $+ [ $1 ] ] ] ,3,32)
alias -l c return $gettok( [ %ftpc. [ $+ [ $1 ] ] ] ,2,32)
alias -l m return $gettok( [ %ftpc. [ $+ [ $1 ] ] ] ,1,32)
alias -l d return $readini $f $1 $remove($2-,$chr(32))
alias -l nd return $readini $f $1 [ n $+ [ $2 ] ]
alias -l f return $scriptdir $+ ftp.ini
alias -l k return s_ $+ $replace($1-,$chr(32),_)
alias -l w return @FTP $+ $chr(160) $+ $1 $+ :
alias -l - return $iif($1,0,1)
alias -l = return $iif($1,1,0)
alias -l _1 if ($sline($1,0)) return $sline($1,1) | err $1 None selected
alias -l ´ if ($round($calc($1 / 1024),1) >= 1000) return $round($calc($calc($1 / 1024) / 1024),1) $+ mb | return $round($calc($1 / 1024),1) $+ kb
alias -l mk return $sock($1).mark
alias -l sdr return $chr(160) $+ [dir] $1-
alias -l sfl return $chr(9) $+ $2- $chr(9) $+ $chr(160) $+ $´($1) $chr(9) $1
alias -l fl return $gettok($1-,1,9)
alias -l sz return $gettok($1-,3,9)
alias -l mt return $iif($-($mouse.x) && ($m($a) isin $1),$2-)
alias -l a return $active
alias -l c1 say $1 $colour(info) *** $2-
alias -l c2 say $1 $colour(info2) *** $2-
alias -l d~ return $chr(160) $+ [dir]*
alias -l sm set %ftpc. $+ $1 $2 $c($1) $l($1) | g2.reset $1 | u $1
alias -l cs sockclose $1-
alias -l sc set %ftpc. $+ $1 $m($1) $2 $l($1)
alias -l sl set %ftpc. $+ $1 $m($1) $c($1) $2
alias -l sd if ($3- != $null) writeini $f $1- | else remini $f $1-
alias -l say if ($d($1,log) && ($3 != ***)) write $logdirftpc.log $date $+ $timestamp ( $+ $d($1,a) $+ ) $3- | drawscroll -n $1 0 -12 0 222 250 92 | dr -hnf $1 $colour(background) 1 0 300 248 13 | drawtext -nc $1-2 $fn" 13 1 299 248 99 $3- | drawdot $1
alias -l rm if ($isfile($1-)) .remove $1-
alias -l do sockwrite -n $1 $2- | if ($show) say $1 $colour(own text) > $2- | if ($l($1)) .timer $+ $1 $+ .NOOP -o 1 180 do $1 NOOP
alias -l err say $1 $colour(highlight) *** $2- | halt
alias -l hlp run http://www.dtek.chalmers.se/~d97masa/mirc/ftp/
alias -l dr drawrect $1-
alias -l dl drawline $1-
alias -l dun if (($mk($1) = get) && ($m($1) = z)) rm $d($1,lf)
alias -l mc clear -l $1 | sm $1 c | sd $1 ld $d($1,gd) | uld $1 | if ($2 != 1) $iif($=($d($1,rd)),list,pwd) $1
alias -l urd dr -nrf $1 $g2cf 1 10 37 230 42 | frame -n $1 10 35 230 42 Remote directory | mtext $1 17 43 $spt(207,$d($1,rd))
alias -l uld dr -nrf $1 $g2cf 1 10 84 230 42 | frame -n $1 10 84 230 42 $iif(($m($1) = c) || ($d($1,frq) = d),Download in,Upload from) | mtext $1 17 92 $spt(207,$d($1,ld))
alias -l info {
  if ($1 = -n) { dr -rnf $2 $g2cf 1 0 315 248 21 | dl -rnf $2 $g2cf 1 0 314 249 314 | dl -rnf $2 $g2ch 1 1 315 248 315 | 3d -rn $2 $g2cs $g2ch 1 318 246 15 | drawdot $2 }
  else { dr -rnf $1 $g2cf 1 3 319 243 13 | if ($2- != $null) drawtext -rnc $1 $g2ct $fn" 12 5 319 241 20 $2- | elseif ($=($d($1,rd))) drawtext -rnc $1 $g2ct $fn" 12 5 319 241 20 $d($1,rd) | drawdot $1 }
}
alias -l listini set -u %^a $readini $1 $2 [ [ $3 ] $+ .total ] | if (%^a = $null) set -u %^a 0 | writeini $1 $2 [ [ $3 ] $+ .total ] $calc(%^a + 1) | writeini $1 $2 [ [ $3 ] $+ [ %^a ] ] $4-
alias -l unlistini {
  set %^i 0
  :l
  set -u %^a $readini $1 $2 [ [ $3 ] $+ [ %^i ] ]
  if (%^a != $null) {
    if (%^a = $4) { set -u %^b $readini -n $1 $2 [ [ $3 ] $+ .total ] - 1 | writeini $1 $2 [ [ $3 ] $+ [ %^i ] ] $readini -n $1 $2 [ [ $3 ] $+ [ %^b ] ] | writeini $1 $2 [ [ $3 ] $+ .total ] %^b | remini $1 $2 [ [ $3 ] $+ [ %^b ] ] }
    else { inc %^i | goto l }
} }
alias -l eb {
  if ($1 = -u) { if ($editbox(@g2.lock) != $null) writeini $7 $8 $9 $strip($editbox(@g2.lock)) | else remini $7 $8 $9 | close -@ @g2.lock }
  if ($1 = -n) {
    drawrect -rnf $2 $g2cw 1 $3-6 | 3d -rn $2 $g2cs $g2ch $3-6 | 3d -rn $2 $rgb(frame) $g2cf $calc($3 + 1) $calc($4 + 1) $calc($5 - 2) $calc($6 - 2)
    if ($10) drawtext -rn $2 $g2ct $fn" 13 $3 $calc($4 - 13) $10- | set -u %^a $readini $7 $8 $9
    if (%^a != $null) drawtext -rnc $2 $rgb(0,0,0) $fn" 13 $calc($3 + 4) $calc($4 + 4) $calc($5 - 6) 100 %^a
  }
  elseif ($1 = -i) {
    close -@ @g2.lock | window -eah +d @g2.lock $abspos(@g2.lock,$3,$4) $calc($5 - 5) $calc($6 - 5) @g2.lock MS Sans Serif 10
    editbox @g2.lock $readini $7 $8 $9 | window -a @g2.lock | g2.lock @g2.lock
} }
alias -l frame 3d -rn $2 $g2cs $g2ch $3-6 | 3d -rn $2 $g2ch $g2cs $calc($3 + 1) $calc($4 + 1) $calc($5 - 2) $calc($6 - 2) | if ($7-) drawtext -rnb $2 $g2ct $g2cf $fn" 13 $calc($3 + 7) $calc($4 - 6) $chr(160) $+ $7- $+ $chr(160)
alias -l abspos return $calc($mouse.mx - [ $window($1).x ] - $mouse.x + $2 + 3) $calc($mouse.my - [ $window($1).y ] - $mouse.y + $3 + 3)
alias -l bb {
  set -u %^v [ $readini [ $gettok($11,1,59) ] [ $gettok($11,2,59) ] [ $gettok($11,3,59) ] ]
  drawrect -rnf $2 $iif(($11 = _) || ($1 != -n) || ($-(%^v)),$g2cf,$rgb($ic($g2ch,$g2cf,1),$ic($g2ch,$g2cf,2),$ic($g2ch,$g2cf,3))) 1 $3-6
  drawtext -rn $2 $rgb($iif($1 = -d,hilight,shadow)) "Wingdings" $10 $calc($3 + $7 + $iif($1 = -i,1,0)) $calc($4 + ($6 - $10) / 2 + $iif($1 = -i,2,1)) $chr($9)
  drawtext -rn $2 $iif($1 = -d,$g2cs,$8) "Wingdings" $10 $calc($3 + $7 - $iif($1 = -i,0,1)) $calc($4 + ($6 - $10) / 2 - $iif($1 = -i,-1,0)) $chr($9)
  if ($1 = -h) { 3d -rn $2 $g2ch $g2cs $3-6 | if ($12) $12 $2 $13- }
  if (($11 != _) && (%^v)) 3d -rn $2 $g2cs $g2ch $3-6
  if ($1 = -i) { 3d -rn $2 $rgb(frame) $g2ch $3-6 | 3d -rn $2 $g2cs $g2ch $calc($3 + 1) $calc($4 + 1) $calc($5 - 1) $calc($6 - 1) }
  if (($1 = -n) && ($12)) $12 $2
}
alias -l ic return $int($calc(($gettok($rgb($1),$3,44) - $gettok($rgb($2),$3,44)) / 2 + $gettok($rgb($2),$3,44)))
alias -l b {
  drawrect -rnf $2 $g2cf 1 $3-6
  drawtext -rn $2 $g2ct $fn" 13 $calc($3 + ($5 - $width($7-,$fn",13,0,0)) / 2 + $iif($1 = -i,2,1)) $calc($4 + ($6 - 10) / 2 - $iif($1 = -i,0,1)) $7-
  if ($1 = -n) || ($1 = -o) || ($1 = -h) { 3d -rn $2 $g2cf $rgb(frame) $3-6 | 3d -rn $2 $g2ch $g2cs $calc($3 + 1) $calc($4 + 1) $calc($5 - 2) $calc($6 - 2) }
  else drawrect -rn $2 $g2cs 1 $3-6
  if (($1 = -i) || ($1 = -n)) drawrect -rn $2 $rgb($iif($1 = -i,frame,face)) 1 $calc($3 - 1) $calc($4 - 1) $calc($5 + 2) $calc($6 + 2)
}
alias -l pbar {
  3d -rn $2 $g2cs $g2ch $3-6 | set -u %^p $iif($7,$round($calc(($8 / $7) * ($5 - 2) / 8),0),$7) - 1
  :l
  if (%^p >= 0) { drawrect -rnf $2 $g2ca 1 $calc($3 + 2 + (8 * %^p)) $calc($4 + 2) 5 $calc($6 - 4) | dec %^p | goto l }
}
alias -l 3d drawrect $1 $2 $4 1 $5- | drawline $1 $2 $3 1 $5 $calc($6 + $8 - 1) $5 $6 $calc($5 + $7) $6
alias -l fn" return "Ms Sans Serif"
alias -l g2ch return $rgb(hilight)
alias -l g2cs return $rgb(shadow)
alias -l g2ct return $rgb(text)
alias -l g2cf return $rgb(face)
alias -l g2cw return $rgb(255,255,255)
alias -l g2ca return $rgb(0,0,128)
on *:input:@g2.lock { editbox @g2.lock $1- | g2.unlock | halt }
alias -l g2.mouse {
  g2in $2
  if (%g2.state) {
    if (($g2s(1) != $active) || ($calc($mouse.key & 1) = 0)) { g2run -n $g2s(1-) | drawdot $g2s(1) | unset %g2.state }
    else { if ($inrect($mouse.x,$mouse.y,$g2s(4),$g2s(5),$g2s(6),$g2s(7))) g2run -i $g2s(1-) | else g2run -o $g2s(1-) | drawdot $g2s(1) }
  }
  else {
    set -u %g2.newover $active [ $ [ $+ [ $1 ] $+ ( [ $active ] , [ $mouse.x ] , [ $mouse.y ] ,mouse) ] ]
    if (%g2.newover != %g2.over) {
      if (%g2.over) { g2run -n $g2o(1-) | drawdot $g2o(1) }
      set %g2.over %g2.newover | if (%g2.over != $active) { g2run -h $g2o(1-) | drawdot $g2o(1) } | else unset %g2.over
} } }
alias -l g2.click {
  g2in $2 
  if (%g2.state) { g2run -n $g2s(1-) | drawdot $g2s(1) }
  set %g2.state $active [ $ [ $+ [ $1 ] $+ ( [ $active ] , [ $mouse.x ] , [ $mouse.y ] ,click) ] ]
  if ((%g2.state != %g2.over) && (%g2.over)) g2run -n $g2o(1-) | unset %g2.over
  if (%g2.state != $active) { g2run -i $g2s(1-) | drawdot $g2s(1) } | else unset %g2.state 
}
alias -l g2.uclick {
  if (%g2.lock) return
  if (%g2.state) {
    set %g2.tmp $inrect($mouse.x,$mouse.y,$g2s(4),$g2s(5),$g2s(6),$g2s(7))
    if (%g2.tmp) set -u %g2.do %g2.state | else unset %g2.do
    if (%g2.do) { g2call $2 %g2.do } | if (%g2.state) { g2run -n $g2s(1-) | drawdot $g2s(1) } | unset %g2.state
    if (%g2.tmp) g2.mouse $1-
    unset %g2.tmp
} }
alias -l g2.reset {
  if ($1 = $g2s(1)) { if (%g2.lock) g2.unlock | unset %g2.state %g2.tmp }
  if ($1 = $g2o(1)) unset %g2.over
}
alias -l g2call set %g2call $true | .timerg2call 1 0 g2calli $1- | .timerg2call -e
alias -l g2calli if (%g2call) { set %g2call | $1- }
alias -l g2.act %g2.action %g2.state
alias -l g2.lock set %g2.lock %g2.action | .timerg2lock -om 0 100 if ( $!active != $1 ) || ( $!window($g2s(1)).state !=  $window($g2s(1)).state ) g2.unlock
alias -l g2.unlock .timerg2lock off | g2run -u %g2.state | if ($window($g2s(1))) { g2run -n %g2.state | drawdot $g2s(1) } | %g2.lock %g2.state | unset %g2.state %g2.lock
alias -l g2.start unset %g2.*
alias -l g2run $3 $1 $2 $5-
alias -l g2in set -u %g2.action $1 | if (%g2.lock) g2.unlock
alias -l g2s return $gettok(%g2.state,$1,32)
alias -l g2t return $gettok(%g2.tmp,$1,32)
alias -l g2o return $gettok(%g2.over,$1,32)
