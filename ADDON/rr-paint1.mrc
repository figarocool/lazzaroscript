;                               RR Paint 2.0
;
; If you include this addon in your script/bot give me credits for it, 
; feel free to change anything as long as you're giving  me credits for it. 
; For mIRC 5.3 and later. Enjoy it! :o)
;
; Don't load this file manualy, it will be auto loaded.
; But it doesn't matter if you've alredy loaded this file :o)
;
;                      By EAE eae@ircweb.net
;
on 1:chat:*: {
  if ($1 == rrpaint) && (%paint-act == Active) { msg = $+ $nick Enabled | paint Go $nick }
  if ($1 == Enabled) && (%paint-act == Active) { paint Go $nick }
  if ($1 == paint) && (%paint-act == Active) {
    if ($2 == drawline) { drawline $3-  }
    if ($2 == drawrect) { drawrect $3-  }
    if ($2 == drawtext) { 
      drawtext $3- 
      drawrect @Paint 15 3 28 22 315 272
      drawrect @Paint 14 1 30 24 312 268
    }
    if ($2 == drawfill) { 
      set %draw-tmp %fill [ $+ [ $getdot(@paint,$4,$5) ] ]
      drawfill -s @paint $3 %draw-tmp $4-
    }
    if ($2 == clear) { draw clear }
  }
  if (%paint-act != Active) { .notice $nick $< RR Paint 4Deactivated $>
} }
on 1:open:=: if (%draw-nick == $nick) { msg = $+ $nick rrpaint 2.0 }
on 1:close:=: if (%draw-nick == $nick) { unset %draw-nick | window -c @paint }
alias paint {
  unset %draw-nick
  if ($1 == Start) { set %draw-nick $2 | dcc chat $2 | halt }
  if ($1 == Go) { set %draw-nick $2 }
  set %draw-color 1
  set %draw-size 4
  set %draw-tool dot
  window -arp +f @Paint 0 1 350 300
  set %fill-tmp 0
  :go
  inc %fill-tmp 1
  drawdot @paint %fill-tmp 1 10 10
  set %fill [ $+ [ $getdot(@paint,10,10) ] ] %fill-tmp
  if (%fill-tmp == 16) { goto done }
  goto go
  :done
  clear @paint
  drawfill @Paint 15 1 1 1 1
  drawrect -f @Paint 15 3 1 1 341 20 
  drawrect -f @Paint 15 3 1 1 25 291
  drawtext -b @Paint 1 15 330 0 ×
  drawrect @Paint 1 1 1 1 341 20 
  drawrect @Paint 1 1 1 23 25 269
  drawline @Paint 0 1 1 1 343 1
  drawline @Paint 14 1 1 21 343 21
  drawline @Paint 0 1 1 1 1 23
  drawline @Paint 14 1 342 2 342 21
  drawline @Paint 0 1 1 23 27 23
  drawline @Paint 14 1 1 292 27 292
  drawline @Paint 0 1 1 23 1 292
  drawline @Paint 14 1 26 24 26 292
  set %draw-color 1
  set %draw-size 2
  drawtext @Paint 0 21 2 ×
  drawtext -b @Paint 1 15 270 3 Clear
  draw-r uls
  drawdot @Paint 1 3 15 37
  drawline @Paint 1 2 8 255 19 255
  draw clear
  drawtext @paint 1 "Times New Roman" 48 75 80 RR Paint 2.0
  drawtext @paint 1 "Times New Roman" 20 78 130 By EAE       eae@ircweb.net
  drawtext @paint 1 "Times New Roman" 20 80 250 Please wait a few secunds...
  .timer 1 3 paint-go
}
alias paint-go {
  if ($window(@Paint) != @Paint) { halt }
  draw clear
}
menu @paint {
  drop {
    if ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if (%draw-tool == line) { 
        drawline @paint %draw-color %draw-size %draw-line-xy $mouse.x $mouse.y
        if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawline @paint %draw-color %draw-size %draw-line-xy $mouse.x $mouse.y }
        unset %draw-line-xy
      }
      if (%draw-tool == sq) { 
        if (%draw-sq-px != $null) {
          set %draw-sq-pw $calc($mouse.x - %draw-sq-px) 
          set %draw-sq-ph $calc($mouse.y - %draw-sq-py) 
          if (%draw-f == f) { 
            drawrect -f @paint %draw-color 1 %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph 
            if (%draw-nick != $null) {  msg = $+ %draw-nick Paint drawrect -f @paint %draw-color 1 %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph  }
          }
          if (%draw-f != f) { 
            drawrect @paint %draw-color %draw-size %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph 
            if (%draw-nick != $null) {  msg = $+ %draw-nick Paint drawrect @paint %draw-color %draw-size %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph }
          }
          unset %draw-sq-*
        }
      }
      if (%draw-tool == ci) { 
        if (%draw-ci-px != $null) {
          set %draw-ci-pw $calc($mouse.x - %draw-ci-px) 
          set %draw-ci-ph $calc($mouse.y - %draw-ci-py) 
          drawrect -e @paint %draw-color %draw-size %draw-ci-px %draw-ci-py %draw-ci-pw %draw-ci-ph
          if (%draw-nick != $null) {  msg = $+ %draw-nick Paint drawrect -e @paint %draw-color %draw-size %draw-ci-px %draw-ci-py %draw-ci-pw %draw-ci-ph }
          unset %draw-ci-*
        }
      }
    }
  }
  mouse {
    if ($mouse.y > 27) && ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if ($mouse.key & 1) {
        if (%draw-tool == dot) { 
          drawline -h @paint %draw-color %draw-size %draw-dot-xy $mouse.x $mouse.y 
          if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawline -h @paint %draw-color %draw-size %draw-dot-xy $mouse.x $mouse.y }
          set %draw-dot-xy $mouse.x $mouse.y
        }
      }
    }
    if (%draw-tool == line) && ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if (%draw-line-xy != $null) {
        drawline -i @paint 1 %draw-size %draw-line-xy %draw-line-xy-last
        drawline -i @paint 1 %draw-size %draw-line-xy $mouse.x $mouse.y
        set %draw-line-xy-last $mouse.x $mouse.y
      }
    }
    if (%draw-tool == sq) && ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if (%draw-sq-px != $null) {
        set %draw-sq-pw $calc($mouse.x - %draw-sq-px) 
        set %draw-sq-ph $calc($mouse.y - %draw-sq-py) 
        if (%draw-f == f) {
          drawrect -if @paint 1 1 %draw-sq-px %draw-sq-py %draw-sq-last
          drawrect -if @paint 1 1 %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph
        }
        if (%draw-f != f) {
          drawrect -i @paint 1 %draw-size %draw-sq-px %draw-sq-py %draw-sq-last
          drawrect -i @paint 1 %draw-size %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph
        }
        set %draw-sq-last %draw-sq-pw %draw-sq-ph
      }
    }
    if (%draw-tool == ci) && ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if (%draw-ci-px != $null) {
        set %draw-ci-pw $calc($mouse.x - %draw-ci-px) 
        set %draw-ci-ph $calc($mouse.y - %draw-ci-py) 
        drawrect -ie @paint 1 1 %draw-ci-px %draw-ci-py %draw-ci-last
        drawrect -ie @paint 1 1 %draw-ci-px %draw-ci-py %draw-ci-pw %draw-ci-ph
        set %draw-ci-last %draw-ci-pw %draw-ci-ph
      }
    }
    if ($inrect($mouse.x,$mouse.y,4,174,20,20) == $true) && (%draw-in-f != Yes) { set %draw-in-f Yes | draw over f }
    if ($inrect($mouse.x,$mouse.y,4,174,20,20) == $false) && (%draw-in-f == Yes) { unset %draw-in-f | draw out f }
    if ($inrect($mouse.x,$mouse.y,4,194,20,20) == $true) && (%draw-in-u != Yes) { set %draw-in-u Yes | draw over u }
    if ($inrect($mouse.x,$mouse.y,4,194,20,20) == $false) && (%draw-in-u == Yes) { unset %draw-in-u | draw out u }
    if ($inrect($mouse.x,$mouse.y,4,26,20,20) == $true) && (%draw-in-dot != Yes) { set %draw-in-dot Yes | draw over dot }
    if ($inrect($mouse.x,$mouse.y,4,26,20,20) == $false) && (%draw-in-dot == Yes) { unset %draw-in-dot | draw out dot }
    if ($inrect($mouse.x,$mouse.y,4,46,20,20) == $true) && (%draw-in-line != Yes) { set %draw-in-line Yes | draw over line }
    if ($inrect($mouse.x,$mouse.y,4,46,20,20) == $false) && (%draw-in-line == Yes) { unset %draw-in-line | draw out line }
    if ($inrect($mouse.x,$mouse.y,4,66,20,20) == $true) && (%draw-in-sq != Yes) { set %draw-in-sq Yes | draw over sq }
    if ($inrect($mouse.x,$mouse.y,4,66,20,20) == $false) && (%draw-in-sq == Yes) { unset %draw-in-sq | draw out sq }
    if ($inrect($mouse.x,$mouse.y,4,86,20,20) == $true) && (%draw-in-ci != Yes) { set %draw-in-ci Yes | draw over ci }
    if ($inrect($mouse.x,$mouse.y,4,86,20,20) == $false) && (%draw-in-ci == Yes) { unset %draw-in-ci | draw out ci }
    if ($inrect($mouse.x,$mouse.y,4,106,20,20) == $true) && (%draw-in-txt != Yes) { set %draw-in-txt Yes | draw over txt }
    if ($inrect($mouse.x,$mouse.y,4,106,20,20) == $false) && (%draw-in-txt == Yes) { unset %draw-in-txt | draw out txt }
    if ($inrect($mouse.x,$mouse.y,4,126,20,20) == $true) && (%draw-in-fill != Yes) { set %draw-in-fill Yes | draw over fill }
    if ($inrect($mouse.x,$mouse.y,4,126,20,20) == $false) && (%draw-in-fill == Yes) { unset %draw-in-fill | draw out fill }
    if ($inrect($mouse.x,$mouse.y,6,6,10,10) == $true) && (%draw-in-0 != Yes) { set %draw-in-0 Yes | draw over 0 }
    if ($inrect($mouse.x,$mouse.y,6,6,10,10) == $false) && (%draw-in-0 == Yes) { unset %draw-in-0 | draw out 0 }
    if ($inrect($mouse.x,$mouse.y,19,6,10,10) == $true) && (%draw-in-1 != Yes) { set %draw-in-1 Yes | draw over 1 }
    if ($inrect($mouse.x,$mouse.y,19,6,10,10) == $false) && (%draw-in-1 == Yes) { unset %draw-in-1 Yes | draw out 1 }
    if ($inrect($mouse.x,$mouse.y,32,6,10,10) == $true) && (%draw-in-2 != Yes) { set %draw-in-2 Yes | draw over 2 }
    if ($inrect($mouse.x,$mouse.y,32,6,10,10) == $false) && (%draw-in-2 == Yes) { unset %draw-in-2 | draw out 2 }
    if ($inrect($mouse.x,$mouse.y,45,6,10,10) == $true) && (%draw-in-3 != Yes) { set %draw-in-3 Yes | draw over 3 }
    if ($inrect($mouse.x,$mouse.y,45,6,10,10) == $false) && (%draw-in-3 == Yes) { unset %draw-in-3 | draw out 3 }
    if ($inrect($mouse.x,$mouse.y,58,6,10,10) == $true) && (%draw-in-4 != Yes) { set %draw-in-4 Yes | draw over 4 }
    if ($inrect($mouse.x,$mouse.y,58,6,10,10) == $false) && (%draw-in-4 == Yes) { unset %draw-in-4 | draw out 4 }
    if ($inrect($mouse.x,$mouse.y,71,6,10,10) == $true) && (%draw-in-5 != Yes) { set %draw-in-5 Yes | draw over 5 }
    if ($inrect($mouse.x,$mouse.y,71,6,10,10) == $false) && (%draw-in-5 == Yes) { unset %draw-in-5 | draw out 5 }
    if ($inrect($mouse.x,$mouse.y,84,6,10,10) == $true) && (%draw-in-6 != Yes) { set %draw-in-6 Yes | draw over 6 }
    if ($inrect($mouse.x,$mouse.y,84,6,10,10) == $false) && (%draw-in-6 == Yes) { unset %draw-in-6 | draw out 6 }
    if ($inrect($mouse.x,$mouse.y,97,6,10,10) == $true) && (%draw-in-7 != Yes) { set %draw-in-7 Yes | draw over 7 }
    if ($inrect($mouse.x,$mouse.y,97,6,10,10) == $false) && (%draw-in-7 == Yes) { unset %draw-in-7 | draw out 7 }
    if ($inrect($mouse.x,$mouse.y,110,6,10,10) == $true) && (%draw-in-8 != Yes) { set %draw-in-8 Yes | draw over 8 }
    if ($inrect($mouse.x,$mouse.y,110,6,10,10) == $false) && (%draw-in-8 == Yes) { unset %draw-in-8 | draw out 8 }
    if ($inrect($mouse.x,$mouse.y,123,6,10,10) == $true) && (%draw-in-9 != Yes) { set %draw-in-9 Yes | draw over 9 }
    if ($inrect($mouse.x,$mouse.y,123,6,10,10) == $false) && (%draw-in-9 == Yes) { unset %draw-in-9 | draw out 9 }
    if ($inrect($mouse.x,$mouse.y,136,6,10,10) == $true) && (%draw-in-10 != Yes) { set %draw-in-10 Yes | draw over 10 }
    if ($inrect($mouse.x,$mouse.y,136,6,10,10) == $false) && (%draw-in-10 == Yes) { unset %draw-in-10 | draw out 10 }
    if ($inrect($mouse.x,$mouse.y,149,6,10,10) == $true) && (%draw-in-11 != Yes) { set %draw-in-11 Yes | draw over 11 }
    if ($inrect($mouse.x,$mouse.y,149,6,10,10) == $false) && (%draw-in-11 == Yes) { unset %draw-in-11 | draw out 11 }
    if ($inrect($mouse.x,$mouse.y,162,6,10,10) == $true) && (%draw-in-12 != Yes) { set %draw-in-12 Yes | draw over 12 }
    if ($inrect($mouse.x,$mouse.y,162,6,10,10) == $false) && (%draw-in-12 == Yes) { unset %draw-in-12 | draw out 12 }
    if ($inrect($mouse.x,$mouse.y,175,6,10,10) == $true) && (%draw-in-13 != Yes) { set %draw-in-13 Yes | draw over 13 }
    if ($inrect($mouse.x,$mouse.y,175,6,10,10) == $false) && (%draw-in-13 == Yes) { unset %draw-in-13 | draw out 13 }
    if ($inrect($mouse.x,$mouse.y,188,6,10,10) == $true) && (%draw-in-14 != Yes) { set %draw-in-14 Yes | draw over 14 }
    if ($inrect($mouse.x,$mouse.y,188,6,10,10) == $false) && (%draw-in-14 == Yes) { unset %draw-in-14 | draw out 14 }
    if ($inrect($mouse.x,$mouse.y,201,6,10,10) == $true) && (%draw-in-15 != Yes) { set %draw-in-15 Yes | draw over 15 }
    if ($inrect($mouse.x,$mouse.y,201,6,10,10) == $false) && (%draw-in-15 == Yes) { unset %draw-in-15 | draw out 15 }
  }
  sclick {
    if ($mouse.y > 27) && ($mouse.x > 33) && ($mouse.y < 290) && ($mouse.x < 340) {
      if (%draw-tool == dot) { 
        set %draw-dot-xy $mouse.x $mouse.y
        drawline @paint %draw-color %draw-size $mouse.x $mouse.y $mouse.x $mouse.y 
        if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawline @paint %draw-color %draw-size $mouse.x $mouse.y $mouse.x $mouse.y }
      }
      if (%draw-tool == line) { 
        if (%draw-line-xy != $null) {
          drawline @paint 1 %draw-size %draw-line-xy $mouse.x $mouse.y
          if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawline @paint 1 %draw-size %draw-line-xy $mouse.x $mouse.y }
          unset %draw-line-xy %draw-line-xy-last
          halt
        }
        if (%draw-line-xy == $null) { 
          set %draw-line-xy $mouse.x $mouse.y
          unset %draw-line-xy-last
        }
      }
      if (%draw-tool == sq) { 
        if (%draw-sq-px != $null) {
          set %draw-sq-pw $calc($mouse.x - %draw-sq-px) 
          set %draw-sq-ph $calc($mouse.y - %draw-sq-py) 
          if (%draw-f == f) { 
            drawrect -f @paint %draw-color 1 %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph 
            if (%draw-nick != $null) {  msg = $+ %draw-nick Paint drawrect -f @paint %draw-color 1 %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph }
          }
          if (%draw-f != f) { 
            drawrect @paint %draw-color %draw-size %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph
            if (%draw-nick != $null) { drawrect @paint %draw-color %draw-size %draw-sq-px %draw-sq-py %draw-sq-pw %draw-sq-ph }
          }
          unset %draw-sq-*
          halt
        }
        if (%draw-sq-px == $null) { 
          set %draw-sq-py $mouse.y
          set %draw-sq-px $mouse.x 
          set %draw-sq-last 0 0
        }
      }
      if (%draw-tool == ci) { 
        if (%draw-ci-px != $null) {
          set %draw-ci-pw $calc($mouse.x - %draw-ci-px) 
          set %draw-ci-ph $calc($mouse.y - %draw-ci-py) 
          drawrect -e @paint %draw-color %draw-size %draw-ci-px %draw-ci-py %draw-ci-pw %draw-ci-ph
          if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawrect -e @paint %draw-color %draw-size %draw-ci-px %draw-ci-py %draw-ci-pw %draw-ci-ph }
          unset %draw-ci-*
        }
        if (%draw-ci-px == $null) { 
          set %draw-ci-py $mouse.y
          set %draw-ci-px $mouse.x 
          set %draw-ci-last 0 0
        }
      }
      if (%draw-tool == txt) { 
        set %draw-font $$?="Enter Font Size"
        set %draw-text $$?="Enter Text"
        drawtext @paint %draw-color "Times New Roman" %draw-font $mouse.x $mouse.y %draw-text 
        drawrect @Paint 15 3 28 22 315 272
        drawrect @Paint 14 1 30 24 312 268
        if (%draw-nick != $null) { msg = $+ %draw-nick Paint drawtext @paint %draw-color "Times New Roman" %draw-font $mouse.x $mouse.y %draw-text }
        unset %draw-text
      }
      if (%draw-tool = fill) { 
        drawfill -s @paint %draw-color %fill [ $+ [ $getdot(@paint,$mouse.x,$mouse.y) ] ] $mouse.x $mouse.y 
        drawrect @Paint 14 1 30 24 312 268
        if (%draw-nick != $null) { 
          msg = $+ %draw-nick Paint drawfill %draw-color $mouse.x $mouse.y 
          msg = $+ %draw-nick Paint drawrect @Paint 14 1 30 24 312 268
        }
      } 
    }
    if ($mouse.x > 3) && ($mouse.x < 25) && ($mouse.y > 173) && ($mouse.y < 194) && (%draw-tool = sq) { draw color f }
    if ($mouse.x > 3) && ($mouse.x < 25) && ($mouse.y > 193) && ($mouse.y < 214) && (%draw-tool = sq) { draw color u }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 30) && ($mouse.y < 50) { draw color dot }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 50) && ($mouse.y < 70) { draw color line }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 70) && ($mouse.y < 90) { draw color sq }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 90) && ($mouse.y < 110) { draw color ci }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 110) && ($mouse.y < 130) { draw color txt }
    if ($mouse.x > 7) && ($mouse.x < 23) && ($mouse.y > 130) && ($mouse.y < 150) { draw color fill }
    if ($mouse.x > 6) && ($mouse.x < 16) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 0 }
    if ($mouse.x > 19) && ($mouse.x < 29) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 1 }
    if ($mouse.x > 32) && ($mouse.x < 42) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 2 }
    if ($mouse.x > 45) && ($mouse.x < 55) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 3 }
    if ($mouse.x > 58) && ($mouse.x < 68) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 4 }
    if ($mouse.x > 71) && ($mouse.x < 81) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 5 }
    if ($mouse.x > 84) && ($mouse.x < 94) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 6 }
    if ($mouse.x > 97) && ($mouse.x < 107) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 7 }
    if ($mouse.x > 110) && ($mouse.x < 120) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 8 }
    if ($mouse.x > 123) && ($mouse.x < 133) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 9 }
    if ($mouse.x > 136) && ($mouse.x < 146) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 10 }
    if ($mouse.x > 149) && ($mouse.x < 159) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 11 }
    if ($mouse.x > 162) && ($mouse.x < 172) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 12 }
    if ($mouse.x > 175) && ($mouse.x < 185) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 13 }
    if ($mouse.x > 188) && ($mouse.x < 198) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 14 }
    if ($mouse.x > 201) && ($mouse.x < 211) && ($mouse.y > 6) && ($mouse.y < 16) { draw color 15 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 249) && ($mouse.y < 253) { draw size 1 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 252) && ($mouse.y < 258) { draw size 2 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 256) && ($mouse.y < 263) { draw size 3 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 262) && ($mouse.y < 269) { draw size 4 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 267) && ($mouse.y < 276) { draw size 5 }
    if ($mouse.x > 6) && ($mouse.x < 21) && ($mouse.y > 275) && ($mouse.y < 285) { draw size 6 }
    if ($mouse.x > 270) && ($mouse.x < 300) && ($mouse.y > 2) && ($mouse.y < 18) { 
      draw clear
      if (%draw-nick != $null) { 
        msg = $+ %draw-nick paint clear
      }
    }
    if ($mouse.x > 325) && ($mouse.x < 340) && ($mouse.y > 2) && ($mouse.y < 13) { 
      window -c @paint 
      if (%draw-nick != $null) { close -c $nick }
    }
  }
}
