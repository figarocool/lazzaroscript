

; ----------------> <Feel free to change the 3 lines belove>-----------------
Rapto return 12«14Rap15toRa14zer12»
<  return 12«14
> return 12»
; ----------------> <Feel free to change the 3 lines above>------------------

on 1:load: {
  echo 3 -a *** Paint Addon Loaded
  echo 3 -a *** If you find any bugs or have any ideas please mail me: eae@ircweb.net
  echo 3 -a *** Right click here and select paint to start painting
  window -al @RR-Paint 50 50 600 500 Ms Sans Serif 8
  aline @RR-Paint                                            RR-Paint 2.0 Beta
  aline @RR-Paint  
  aline @RR-Paint Welcome to RR-Paint 2.0 you need mIRC 5.3 or later to use this addon
  aline @RR-Paint  
  aline @RR-Paint If you include this addon in your script/bot give me credits for it, feel
  aline @RR-Paint free to change anything as long as you're giving me credits for it.
  aline @RR-Paint  
  aline @RR-Paint Paint Menu has been added to:
  aline @RR-Paint * Menubar       * Nicklist
  aline @RR-Paint * Query            * Status Window
  aline @RR-Paint  
  aline @RR-Paint  
  aline @RR-Paint                                                  «Close»
  set %paint-act Active
  .load -rs $nofile($script(rr-paint.mrc)) $+ rr-paint.rap
}
menu @RR-Paint {
  dclick if ($1 == 13) { window -c @RR-Paint }
}
alias draw {
  if ($1 == color) {
    if ($2 > 20) { draw-r l }
    if ($2 < 20) { draw-r u }
    if ($2 == f) && (%draw-tool = sq) {
      unset %draw-f
      draw-r f
      drawrect @Paint 1 2 6 175 16 16
      drawline @Paint 14 1 4 173 24 173
      drawline @Paint 14 1 4 173 4 193
      drawline @Paint 0 1 4 193 25 193
      drawline @Paint 0 1 24 173 24 193
    }
    if ($2 == u) && (%draw-tool = sq) {
      set %draw-f f
      draw-r f
      drawrect -f @Paint 1 2 6 196 16 16
      drawline @Paint 14 1 4 194 24 194
      drawline @Paint 14 1 4 194 4 214
      drawline @Paint 0 1 4 214 25 214
      drawline @Paint 0 1 24 194 24 214
    }  
    if ($2 == dot) { 
      set %draw-tool dot
      unset %draw-dot-xy 
      drawdot @Paint 1 3 15 37
      drawline @Paint 14 1 4 26 24 26
      drawline @Paint 14 1 4 26 4 45
      drawline @Paint 0 1 4 45 25 45
      drawline @Paint 0 1 24 26 24 45
      .timer -m 1 100 draw over dot
    }
    if ($2 == line) {
      set %draw-tool line
      unset %draw-line*
      drawline @Paint 1 2 8 50 21 63
      drawline @Paint 14 1 4 46 24 46  
      drawline @Paint 14 1 4 46 4 65
      drawline @Paint 0 1 4 65 25 65
      drawline @Paint 0 1 24 46 24 65      
      .timer -m 1 100 draw over line
    }
    if ($2 == sq) {
      set %draw-tool sq
      unset %draw-sq* %draw-f
      drawrect @Paint 1 2 6 70 16 16
      drawline @Paint 14 1 4 68 24 68
      drawline @Paint 14 1 4 88 4 68
      drawline @Paint 0 1 4 88 25 88
      drawline @Paint 0 1 24 68 24 88      
      draw-r f
      drawrect @Paint 1 2 6 175 16 16
      .timer -m 1 100 draw over sq
    }
    if ($2 == ci) {
      set %draw-tool ci
      unset %draw-ci*
      drawdot @Paint 1 8 15 100
      drawdot @Paint 15 7 15 100
      drawline @Paint 15 1 4 89 24 89
      drawline @Paint 15 1 4 108 4 89
      drawline @Paint 15 1 4 108 25 108
      drawline @Paint 15 1 24 89 24 108      
      .timer -m 1 100 draw over ci
    }
    if ($2 == txt) {
      set %draw-tool txt
      drawtext @Paint 1 "Times New Roman" 28 6 107 A
      drawline @Paint 14 1 4 110 24 110
      drawline @Paint 14 1 4 130 4 110
      drawline @Paint 0 1 4 130 25 130
      drawline @Paint 0 1 24 110 24 130
      .timer -m 1 100 draw over txt
    }
    if ($2 == fill) {
      set %draw-tool fill
      drawtext @Paint 1 4 132 Fill
      drawline @Paint 14 1 4 131 24 131
      drawline @Paint 14 1 4 151 4 131
      drawline @Paint 0 1 4 151 25 151
      drawline @Paint 0 1 24 131 24 151
      .timer -m 1 100 draw over fill      
    }
    if ($2 == 0) { 
      set %draw-color 0
      drawtext @Paint 1 7 2 × 
      drawline @Paint 14 1 6 6 17 6
      drawline @Paint 14 1 6 6 16 16
      drawline @Paint 0 1 6 16 17 16
      drawline @Paint 0 1 16 7 16 17
      drawrect @Paint 0 1 7 7 8 8
      .timer -m 1 100 draw over 0
    }
    if ($2 == 1) { 
      set %draw-color 1
      drawtext @Paint 0 20 2 × 
      drawline @Paint 14 1 19 6 30 6
      drawline @Paint 14 1 19 6 22 16
      drawline @Paint 0 1 19 16 30 16
      drawline @Paint 0 1 29 7 29 17
      .timer -m 1 100 draw over 1
    }
    if ($2 == 2) { 
      set %draw-color 2
      drawtext @Paint 0 34 2 × 
      drawline @Paint 14 1 32 6 43 6
      drawline @Paint 14 1 32 6 32 16
      drawline @Paint 0 1 32 16 43 16
      drawline @Paint 0 1 42 7 42 17
      .timer -m 1 100 draw over 2
    }
    if ($2 == 3) { 
      set %draw-color 3
      drawtext @Paint 0 47 2 × 
      drawline @Paint 14 1 45 6 56 6
      drawline @Paint 14 1 45 6 45 16
      drawline @Paint 0 1 45 16 56 16
      drawline @Paint 0 1 55 7 55 17
      .timer -m 1 100 draw over 3
    }
    if ($2 == 4) { 
      set %draw-color 4
      drawtext @Paint 0 60 2 × 
      drawline @Paint 14 1 58 6 69 6
      drawline @Paint 14 1 58 6 58 16
      drawline @Paint 0 1 58 16 69 16
      drawline @Paint 0 1 68 7 68 17
      .timer -m 1 100 draw over 4
    }
    if ($2 == 5) { 
      set %draw-color 5
      drawtext @Paint 0 73 2 × 
      drawline @Paint 14 1 71 6 82 6
      drawline @Paint 14 1 71 6 71 16
      drawline @Paint 0 1 71 16 82 16
      drawline @Paint 0 1 81 7 81 17
      .timer -m 1 100 draw over 5
    }
    if ($2 == 6) { 
      set %draw-color 6
      drawtext @Paint 0 86 2 × 
      drawline @Paint 14 1 84 6 95 6
      drawline @Paint 14 1 84 6 84 16
      drawline @Paint 0 1 84 16 95 16
      drawline @Paint 0 1 94 7 94 17
      .timer -m 1 100 draw over 6
    }
    if ($2 == 7) {
      set %draw-color 7
      drawtext @Paint 1 99 2 × 
      drawline @Paint 14 1 97 6 108 6
      drawline @Paint 14 1 97 6 97 16
      drawline @Paint 0 1 97 16 108 16
      drawline @Paint 0 1 107 7 107 17
      .timer -m 1 100 draw over 7
    }
    if ($2 == 8) {
      set %draw-color 8
      drawtext @Paint 1 112 2 × 
      drawline @Paint 14 1 110 6 121 6
      drawline @Paint 14 1 110 6 110 16
      drawline @Paint 0 1 110 16 121 16
      drawline @Paint 0 1 120 7 120 17
      .timer -m 1 100 draw over 8
    }
    if ($2 == 9) {
      set %draw-color 9
      drawtext @Paint 1 125 2 × 
      drawline @Paint 14 1 123 6 134 6
      drawline @Paint 14 1 123 6 123 16
      drawline @Paint 0 1 123 16 134 16
      drawline @Paint 0 1 133 7 133 17
      .timer -m 1 100 draw over 9
    }
    if ($2 == 10) { 
      set %draw-color 10
      drawtext @Paint 0 138 2 × 
      drawline @Paint 14 1 136 6 147 6
      drawline @Paint 14 1 136 6 136 16
      drawline @Paint 0 1 136 16 147 16
      drawline @Paint 0 1 146 7 146 17
      .timer -m 1 100 draw over 10
    }
    if ($2 == 11) {
      set %draw-color 11
      drawtext @Paint 1 151 2 × 
      drawline @Paint 14 1 149 6 160 6
      drawline @Paint 14 1 149 6 149 16
      drawline @Paint 0 1 149 16 160 16
      drawline @Paint 0 1 159 7 159 17
      .timer -m 1 100 draw over 11
    }
    if ($2 == 12) {
      set %draw-color 12
      drawtext @Paint 0 164 2 × 
      drawline @Paint 14 1 162 6 173 6
      drawline @Paint 14 1 162 6 162 16
      drawline @Paint 0 1 162 16 173 16
      drawline @Paint 0 1 172 7 172 17
      .timer -m 1 100 draw over 12
    }
    if ($2 == 13) { 
      set %draw-color 13
      drawtext @Paint 0 177 2 × 
      drawline @Paint 14 1 175 6 186 6
      drawline @Paint 14 1 175 6 175 16
      drawline @Paint 0 1 175 16 186 16
      drawline @Paint 0 1 185 7 185 17
      .timer -m 1 100 draw over 13
    }
    if ($2 == 14) { 
      set %draw-color 14
      drawtext @Paint 0 190 2 × 
      drawline @Paint 14 1 188 6 199 6
      drawline @Paint 14 1 188 6 188 16
      drawline @Paint 0 1 188 16 199 16
      drawline @Paint 0 1 198 7 198 17
      .timer -m 1 100 draw over 14
    }
    if ($2 == 15) { 
      set %draw-color 15
      drawtext @Paint 1 203 2 × 
      drawline @Paint 14 1 201 6 212 6
      drawline @Paint 14 1 201 6 201 16
      drawline @Paint 0 1 201 16 212 16
      drawline @Paint 0 1 211 7 211 17
      drawrect @Paint 15 1 202 7 8 8
      .timer -m 1 100 draw over 15
    }
  }
  if ($1 == size) {
    draw-r s
    set %draw-size $2
    if ($2 == 1) { drawline @Paint 1 1 7 251 20 251 }
    if ($2 == 2) { drawline @Paint 1 2 8 255 19 255 }
    if ($2 == 3) { drawline @Paint 1 3 8 259 18 259 }
    if ($2 == 4) { drawline @Paint 1 4 9 265 18 265 }
    if ($2 == 5) { drawline @Paint 1 5 9 271 17 271 }
    if ($2 == 6) { drawline @Paint 1 5 9 278 17 278 | drawline @Paint 1 5 9 280 17 280 }
  }
  if ($1 == clear) {
    drawrect -f @Paint 0 1 30 24 312 268
    drawrect @Paint 14 1 30 24 312 268
    unset %draw-line-xy %draw-sq-xy %draw-dot-xy
  }
  if ($1 == over) {
    if ($inrect($mouse.x,$mouse.y,4,174,20,20) == $true) && ($2 == f) && (%draw-tool = sq) {
      drawline @Paint 0 1 4 173 24 173
      drawline @Paint 0 1 4 173 4 193
      drawline @Paint 14 1 4 193 25 193
      drawline @Paint 14 1 24 173 24 193
    }
    if ($inrect($mouse.x,$mouse.y,4,194,20,20) == $true) && ($2 == u) && (%draw-tool = sq) {
      drawline @Paint 0 1 4 194 24 194
      drawline @Paint 0 1 4 194 4 214
      drawline @Paint 14 1 4 214 25 214
      drawline @Paint 14 1 24 194 24 214
    }    
    if ($inrect($mouse.x,$mouse.y,4,26,20,20) == $true) && ($2 == dot) {
      drawline @Paint 0 1 4 26 24 26
      drawline @Paint 0 1 4 26 4 45
      drawline @Paint 14 1 4 45 25 45
      drawline @Paint 14 1 24 26 24 45
    }
    if ($inrect($mouse.x,$mouse.y,4,46,20,20) == $true) && ($2 == line) {
      drawline @Paint 0 1 4 46 24 46  
      drawline @Paint 0 1 4 46 4 65
      drawline @Paint 14 1 4 65 25 65
      drawline @Paint 14 1 24 46 24 65
    }
    if ($inrect($mouse.x,$mouse.y,4,66,20,20) == $true) &&  ($2 == sq) {
      drawline @Paint 0 1 4 68 24 68
      drawline @Paint 0 1 4 88 4 68
      drawline @Paint 14 1 4 88 25 88
      drawline @Paint 14 1 24 68 24 88      
    }
    if ($inrect($mouse.x,$mouse.y,4,86,20,20) == $true) &&  ($2 == ci) {
      drawline @Paint 0 1 4 89 24 89
      drawline @Paint 0 1 4 108 4 89
      drawline @Paint 14 1 4 108 25 108
      drawline @Paint 14 1 24 89 24 108      
    }
    if ($inrect($mouse.x,$mouse.y,4,110,20,20) == $true) && ($2 == txt) {
      drawline @Paint 0 1 4 110 24 110
      drawline @Paint 0 1 4 130 4 110
      drawline @Paint 14 1 4 130 25 130
      drawline @Paint 14 1 24 110 24 130
    }
    if ($inrect($mouse.x,$mouse.y,4,130,20,20) == $true) && ($2 == fill) {
      drawline @Paint 0 1 4 131 24 131
      drawline @Paint 0 1 4 151 4 131
      drawline @Paint 14 1 4 151 25 151
      drawline @Paint 14 1 24 131 24 151
    }
    if ($inrect($mouse.x,$mouse.y,6,6,10,10) == $true) && ($2 == 0) {
      drawline @Paint 0 1 6 6 17 6
      drawline @Paint 0 1 6 6 6 16
      drawline @Paint 14 1 6 16 17 16
      drawline @Paint 14 1 16 7 16 17
      drawrect @Paint 0 1 7 7 8 8
    }
    if ($inrect($mouse.x,$mouse.y,19,6,10,10) == $true) && ($2 == 1) {
      drawline @Paint 0 1 19 6 30 6
      drawline @Paint 0 1 19 6 19 16
      drawline @Paint 14 1 19 16 30 16
      drawline @Paint 14 1 29 7 29 17
    }
    if ($inrect($mouse.x,$mouse.y,32,6,10,10) == $true) && ($2 == 2) {
      drawline @Paint 0 1 32 6 43 6
      drawline @Paint 0 1 32 6 32 16
      drawline @Paint 14 1 32 16 43 16
      drawline @Paint 14 1 42 7 42 17
    }
    if ($inrect($mouse.x,$mouse.y,45,6,10,10) == $true) && ($2 == 3) {
      drawline @Paint 0 1 45 6 56 6
      drawline @Paint 0 1 45 6 45 16
      drawline @Paint 14 1 45 16 56 16
      drawline @Paint 14 1 55 7 55 17
    } 
    if ($inrect($mouse.x,$mouse.y,58,6,10,10) == $true) && ($2 == 4) {
      drawline @Paint 0 1 58 6 69 6
      drawline @Paint 0 1 58 6 58 16
      drawline @Paint 14 1 58 16 69 16
      drawline @Paint 14 1 68 7 68 17
    } 
    if ($inrect($mouse.x,$mouse.y,71,6,10,10) == $true) && ($2 == 5) {
      drawline @Paint 0 1 71 6 82 6
      drawline @Paint 0 1 71 6 71 16
      drawline @Paint 14 1 71 16 82 16
      drawline @Paint 14 1 81 7 81 17
    }
    if ($inrect($mouse.x,$mouse.y,84,6,10,10) == $true) && ($2 == 6) { 
      drawline @Paint 0 1 84 6 95 6
      drawline @Paint 0 1 84 6 84 16
      drawline @Paint 14 1 84 16 95 16
      drawline @Paint 14 1 94 7 94 17
    }
    if ($inrect($mouse.x,$mouse.y,97,6,10,10) == $true) && ($2 == 7) {
      drawline @Paint 0 1 97 6 108 6
      drawline @Paint 0 1 97 6 97 16
      drawline @Paint 14 1 97 16 108 16
      drawline @Paint 14 1 107 7 107 17
    }
    if ($inrect($mouse.x,$mouse.y,110,6,10,10) == $true) && ($2 == 8) {
      drawline @Paint 0 1 110 6 121 6
      drawline @Paint 0 1 110 6 110 16
      drawline @Paint 14 1 110 16 121 16
      drawline @Paint 14 1 120 7 120 17
    }
    if ($inrect($mouse.x,$mouse.y,123,6,10,10) == $true) && ($2 == 9) {
      drawline @Paint 0 1 123 6 134 6
      drawline @Paint 0 1 123 6 123 16
      drawline @Paint 14 1 123 16 134 16
      drawline @Paint 14 1 133 7 133 17
    }
    if ($inrect($mouse.x,$mouse.y,136,6,10,10) == $true) && ($2 == 10) { 
      drawline @Paint 0 1 136 6 147 6
      drawline @Paint 0 1 136 6 136 16
      drawline @Paint 14 1 136 16 147 16
      drawline @Paint 14 1 146 7 146 17
    }
    if ($inrect($mouse.x,$mouse.y,149,6,10,10) == $true) && ($2 == 11) {
      drawline @Paint 0 1 149 6 160 6
      drawline @Paint 0 1 149 6 149 16
      drawline @Paint 14 1 149 16 160 16
      drawline @Paint 14 1 159 7 159 17
    }
    if ($inrect($mouse.x,$mouse.y,162,6,10,10) == $true) && ($2 == 12) {
      drawline @Paint 0 1 162 6 173 6
      drawline @Paint 0 1 162 6 162 16
      drawline @Paint 14 1 162 16 173 16
      drawline @Paint 14 1 172 7 172 17
    }
    if ($inrect($mouse.x,$mouse.y,175,6,10,10) == $true) && ($2 == 13) { 
      drawline @Paint 0 1 175 6 186 6
      drawline @Paint 0 1 175 6 175 16
      drawline @Paint 14 1 175 16 186 16
      drawline @Paint 14 1 185 7 185 17
    }
    if ($inrect($mouse.x,$mouse.y,188,6,10,10) == $true) && ($2 == 14) { 
      drawline @Paint 0 1 188 6 199 6
      drawline @Paint 0 1 188 6 188 16
      drawline @Paint 14 1 188 16 199 16
      drawline @Paint 14 1 198 7 198 17
    }
    if ($inrect($mouse.x,$mouse.y,201,6,10,10) == $true) && ($2 == 15) { 
      drawline @Paint 0 1 201 6 212 6
      drawline @Paint 0 1 201 6 201 16
      drawline @Paint 14 1 201 16 212 16
      drawline @Paint 14 1 211 7 211 17
      drawrect @Paint 15 1 202 7 8 8
    }  
  }
  if ($1 == out) {
    if ($2 == f) && (%draw-tool = sq) {
      drawline @Paint 15 1 4 173 24 173
      drawline @Paint 15 1 4 173 4 193
      drawline @Paint 15 1 4 193 25 193
      drawline @Paint 15 1 24 173 24 193
    }
    if ($2 == u) && (%draw-tool = sq) {
      drawline @Paint 15 1 4 194 24 194
      drawline @Paint 15 1 4 194 4 214
      drawline @Paint 15 1 4 214 25 214
      drawline @Paint 15 1 24 194 24 214
    }    
    if ($2 == dot) {
      drawline @Paint 15 1 4 26 24 26
      drawline @Paint 15 1 4 26 4 45
      drawline @Paint 15 1 4 45 25 45
      drawline @Paint 15 1 24 26 24 45
    }
    if ($2 == line) {
      drawline @Paint 15 1 4 46 24 46  
      drawline @Paint 15 1 4 46 4 65
      drawline @Paint 15 1 4 65 25 65
      drawline @Paint 15 1 24 46 24 65      
    }
    if ($2 == sq) {
      drawline @Paint 15 1 4 68 24 68
      drawline @Paint 15 1 4 88 4 68
      drawline @Paint 15 1 4 88 25 88
      drawline @Paint 15 1 24 68 24 88      
    }
    if ($2 == ci) {
      drawline @Paint 15 1 4 89 24 89
      drawline @Paint 15 1 4 108 4 89
      drawline @Paint 15 1 4 108 25 108
      drawline @Paint 15 1 24 89 24 108      
    }
    if ($2 == txt) {
      drawline @Paint 15 1 4 110 24 110
      drawline @Paint 15 1 4 130 4 110
      drawline @Paint 15 1 4 130 25 130
      drawline @Paint 15 1 24 110 24 130
    }
    if ($2 == fill) {
      drawline @Paint 15 1 4 131 24 131
      drawline @Paint 15 1 4 151 4 131
      drawline @Paint 15 1 4 151 25 151
      drawline @Paint 15 1 24 131 24 151
    }
    if ($2 == 0) {
      drawline @Paint 15 1 6 6 17 6
      drawline @Paint 15 1 6 6 6 16
      drawline @Paint 15 1 6 16 17 16
      drawline @Paint 15 1 16 7 16 17
      drawrect @Paint 1 1 7 7 8 8
    }
    if ($2 == 1) {
      drawline @Paint 15 1 19 6 30 6
      drawline @Paint 15 1 19 6 19 16
      drawline @Paint 15 1 19 16 30 16
      drawline @Paint 15 1 29 7 29 17
    }
    if ($2 == 2) {
      drawline @Paint 15 1 32 6 43 6
      drawline @Paint 15 1 32 6 32 16
      drawline @Paint 15 1 32 16 43 16
      drawline @Paint 15 1 42 7 42 17
    }
    if ($2 == 3) {
      drawline @Paint 15 1 45 6 56 6
      drawline @Paint 15 1 45 6 45 16
      drawline @Paint 15 1 45 16 56 16
      drawline @Paint 15 1 55 7 55 17
    } 
    if ($2 == 4) {
      drawline @Paint 15 1 58 6 69 6
      drawline @Paint 15 1 58 6 58 16
      drawline @Paint 15 1 58 16 69 16
      drawline @Paint 15 1 68 7 68 17
    } 
    if ($2 == 5) {
      drawline @Paint 15 1 71 6 82 6
      drawline @Paint 15 1 71 6 71 16
      drawline @Paint 15 1 71 16 82 16
      drawline @Paint 15 1 81 7 81 17
    }
    if ($2 == 6) { 
      drawline @Paint 15 1 84 6 95 6
      drawline @Paint 15 1 84 6 84 16
      drawline @Paint 15 1 84 16 95 16
      drawline @Paint 15 1 94 7 94 17
    }
    if ($2 == 7) {
      drawline @Paint 15 1 97 6 108 6
      drawline @Paint 15 1 97 6 97 16
      drawline @Paint 15 1 97 16 108 16
      drawline @Paint 15 1 107 7 107 17
    }
    if ($2 == 8) {
      drawline @Paint 15 1 110 6 121 6
      drawline @Paint 15 1 110 6 110 16
      drawline @Paint 15 1 110 16 121 16
      drawline @Paint 15 1 120 7 120 17
    }
    if ($2 == 9) {
      drawline @Paint 15 1 123 6 134 6
      drawline @Paint 15 1 123 6 123 16
      drawline @Paint 15 1 123 16 134 16
      drawline @Paint 15 1 133 7 133 17
    }
    if ($2 == 10) { 
      drawline @Paint 15 1 136 6 147 6
      drawline @Paint 15 1 136 6 136 16
      drawline @Paint 15 1 136 16 147 16
      drawline @Paint 15 1 146 7 146 17
    }
    if ($2 == 11) {
      drawline @Paint 15 1 149 6 160 6
      drawline @Paint 15 1 149 6 149 16
      drawline @Paint 15 1 149 16 160 16
      drawline @Paint 15 1 159 7 159 17
    }
    if ($2 == 12) {
      drawline @Paint 15 1 162 6 173 6
      drawline @Paint 15 1 162 6 162 16
      drawline @Paint 15 1 162 16 173 16
      drawline @Paint 15 1 172 7 172 17
    }
    if ($2 == 13) { 
      drawline @Paint 15 1 175 6 186 6
      drawline @Paint 15 1 175 6 175 16
      drawline @Paint 15 1 175 16 186 16
      drawline @Paint 15 1 185 7 185 17
    }
    if ($2 == 14) { 
      drawline @Paint 15 1 188 6 199 6
      drawline @Paint 15 1 188 6 188 16
      drawline @Paint 15 1 188 16 199 16
      drawline @Paint 15 1 198 7 198 17
    }
    if ($2 == 15) { 
      drawline @Paint 15 1 201 6 212 6
      drawline @Paint 15 1 201 6 201 16
      drawline @Paint 15 1 201 16 212 16
      drawline @Paint 15 1 211 7 211 17
      drawrect @Paint 1 1 202 7 8 8
    }
} }
alias draw-r {
  if (u isin $1) {
    drawrect -f @Paint 0 1 7 7 8 8
    drawrect @Paint 1 1 7 7 8 8
    drawrect -f @Paint 1 1 20 7 8 8
    drawrect -f @Paint 2 1 33 7 8 8
    drawrect -f @Paint 3 1 46 7 8 8
    drawrect -f @Paint 4 1 60 7 8 8
    drawrect -f @Paint 5 1 72 7 8 8
    drawrect -f @Paint 6 1 85 7 8 8
    drawrect -f @Paint 7 1 98 7 8 8
    drawrect -f @Paint 8 1 111 7 8 8
    drawrect -f @Paint 9 1 124 7 8 8
    drawrect -f @Paint 10 1 137 7 8 8
    drawrect -f @Paint 11 1 150 7 8 8
    drawrect -f @Paint 12 1 163 7 8 8
    drawrect -f @Paint 13 1 176 7 8 8
    drawrect -f @Paint 14 1 189 7 8 8
    drawrect -f @Paint 15 1 202 7 8 8
    drawrect @Paint 1 1 202 7 8 8
  }
  if (l isin $1) {
    drawdot @Paint 14 3 15 37
    drawline @Paint 14 2 8 50 21 63
    drawrect @Paint 14 2 6 70 16 16
    drawdot @Paint 14 8 15 100
    drawdot @Paint 15 7 15 100
    drawtext @Paint 14 "Times New Roman" 28 6 107 A
    drawtext @Paint 14 4 132 Fill
    drawrect @Paint 15 2 6 175 16 16
    drawrect -f @Paint 15 2 6 196 16 16
  }
  if (s isin $1) {
    drawline @Paint 14 1 7 251 20 251
    drawline @Paint 14 2 8 255 19 255
    drawline @Paint 14 3 8 259 18 259
    drawline @Paint 14 4 9 265 18 265
    drawline @Paint 14 5 9 271 17 271
    drawline @Paint 14 5 9 278 17 278
    drawline @Paint 14 5 9 280 17 280
  }
  if (f isin $1) {
    drawrect @Paint 14 2 6 175 16 16
    drawrect -f @Paint 14 2 6 196 16 16
} }
ctcp 1:PAINT:/notice $nick PAINT on ! %script | ignore -tiu5 $nick 2
