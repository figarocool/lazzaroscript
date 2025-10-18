;
; Autor Stefano Basile 
; LazZaro.s@tiscalinet.it
; Nessun sito Internet
; 
;

dialog portscanner {
  title " LazZaro Server Port Scanner"
  size -1 -1 461 240
  button "Scan Now", 1, 242 120 209 24, ok default
  edit "", 2, 48 10 403 20, disable
  text "Server:", 3, 10 13 40 20
  list 4, 51 35 135 160
  text "Ports:", 5, 17 38 30 20
  edit "Created with mIRC 5.1", 6, 241 33 210 40
  text "Status:", 7, 204 37 38 20
  edit "", 8, 51 185 55 20, disable
  text "Current:", 9, 8 189 40 20
  button "Clear", 11, 130 196 35 18, ok default
  text "Created by W\RRIOR - 1999", 12, 310 218 150 20, disable
  box "", 13, 49 27 140 202
  edit "", 14, 51 206 55 20, disable
  text "Fastest:", 15, 8 209 44 20
}
on *:dialog:portscanner:init:*:{
  if ($server != $null) { did -f portscanner 1 }
  did -m portscanner 6
  if ($server == $null) { did -b portscanner 1 | did -b portscanner 4 | did -r portscanner 2 | did -r portscanner 8 | did -o portscanner 6 1 $chr(160) $+ Not connected to server | did -b portscanner 1 | halt }
  did -o portscanner 2 1 $chr(160) $+ $server | did -o portscanner 8 1 $port
}
on *:dialog:portscanner:dclick:*:if ($did == 4) { server $server $+ : $+ $did(4,$did(4).sel) }
on *:dialog:portscanner:sclick:*:{
  if ($did == 1) { did -b portscanner 1 | did -o portscanner 6 1 $chr(160) $+ Scanning... | .timer49 -o 1 3 pstimeout | did -r portscanner 4 | .enable #statsl | stats l | halt }
  if ($did == 11) { did  -r portscanner 4 | halt }
}
on 1:connect:{
  if ($dialog(portscanner)) {
    did -e portscanner 1 | did -e portscanner 4 | did -o portscanner 2 1 $chr(160) $+ $server | did -o portscanner 8 1 $port
    did -r portscanner 6 | did -o portscanner 6 1 $chr(160) $+ Connected
  }
}
on 1:disconnect:{
  if ($dialog(portscanner)) {
    did -o portscanner 6 1 $chr(160) $+ Not connected to server | did -b portscanner 1 | did -b portscanner 4 | did -r portscanner 2 | did -r portscanner 8 | did -r portscanner 14
  }
}
