;
;
raw 352:*: halt
raw 315:*: /echo -a Done Up Dating Internal Address Listing! | halt
alias firewallstart {
  dialog -dm firewall firewall
  did -u firewall 69 
  did -c firewall 68 
}
dialog firewall {
  title "LazZaro Firewall"
  size 30 30 500 300
  button "Exit",60,10 270 80 25,ok
  button "Edit Ports",63,10 220 80 25,defult
  button "Options",64,10 245 80 25,defult
  button "",61,-1 -1 -1 -1,Cancel
  edit "",62,10 10 480 200,multi,vsbar,read
  text "Listening to Ports",66,100 220 90 25,drop,sort
  combo 65,100 235 90 126,drop,sort
  text "FireWall on/off",67,100 260 90 20,drop,sort
  radio "On",68,100 280 35 13
  radio "Off",69,135 280 35 13
  box "Last Connection From...",70,200 215 290 80
  button "Find Nick",71,210 260 80 25,defult
  text "In -->",72,300 265 90 25,defult
  combo 73,330 260 90 126,drop,sort,edit
  text "Chan(s)",74,430 265 90 25,defult
  text "IP",75,210 235 90 25,defult
  edit "",76,225 231 90 20,defult
  text "Port",77,320 235 90 25,defult
  edit "",78,350 231 90 20,defult
}
dialog firewalledit {
  title "Edit Ports"
  size 30 30 195 200
  button "",1,-1 -1 -1 -1,Cancel
  list 2,5 5 100 200,sort
  text "Port To Add:",6,110 5 90 25  
  edit "",7,109 20 80 20
  radio "TCP",8,110 40 60 25
  radio "UDP",9,110 60 60 25
  button "Add ????",11,110 105 80 25
  button "Del ????",12,110 135 80 25
  button "Exit",13,110 165 80 25,ok
}
dialog firewalloptions {
  title "Options"
  size 30 30 210 150
  button "",1,-1 -1 -1 -1,Cancel
  text "Msg To Send When Connection Is Made",2,5 5 200 20
  edit "",3,5 20 200 20,autohs
  text "Start Up Fire Wall On Mirc Connection",4,5 45 200 20
  radio "Yes",5,5 60 35 20,group
  radio "No",6,50 60 35 20
  text "Show Port Connection In",7,5 80 200 20
  radio "FireWall GUI",8,5 95 85 20,group
  radio "Active Window",9,90 95 90 20
  button "OK",10,5 120 80 25,ok
}
on 1:dialog:firewalloptions:edit:3: set %fw.connect.msg $did(firewalloptions,3).text
on 1:dialog:firewalloptions:sclick:5: set %nukestart yes
on 1:dialog:firewalloptions:sclick:6: set %nukestart no
on 1:dialog:firewalloptions:sclick:8: set %fw.active.gui gui
on 1:dialog:firewalloptions:sclick:9: set %fw.active.gui active
on 1:dialog:firewalloptions:init:0: {
  did -a firewalloptions 3 %fw.connect.msg
  if (%nukestart = yes) { did -c firewalloptions 5 } | else { did -c firewalloptions 6 }
  if (%fw.active.gui = gui) { did -c firewalloptions 8 } | else { did -c firewalloptions 9 }
}

on 1:dialog:firewalledit:sclick:12: {
  set %firewall.edit.read $read -w"* $+ $did(firewalledit,2,$did(firewalledit,2).sel).text $+ *" $scriptdirsocks.txt 
  write -dl $+ $readn $scriptdirsocks.txt 
  set %firewall.edit.i 0
  :loop
  inc %firewall.edit.i 1
  if ($DID(firewall,65,%firewall.edit.i).text = $did(firewalledit,2,$did(firewalledit,2).sel).text) {
    did -d firewall 65 %firewall.edit.i
    did -c firewall 65 1
    did -d firewalledit 2 $did(firewalledit,2).sel
  }
  else { goto loop }
}
on 1:dialog:firewalledit:sclick:11: {
  set %fw.edit.i 0
  if ($did(firewalledit,8).state = 1) { set %fw.edit.uttest $did(firewalledit,7).text TCP }
  if ($did(firewalledit,9).state = 1) { set %fw.edit.uttest $did(firewalledit,7).text UDP }
  :loop
  inc %fw.edit.i 1
  if ($did(firewalledit,2,%fw.edit.i).text = $null) { goto goodtogo }
  if ($did(firewalledit,2,%fw.edit.i).text = %fw.edit.uttest) { halt }
  goto loop
  :goodtogo
  if ($did(firewalledit,8).state = 1) { 
    write $scriptdirsocks.txt $did(firewalledit,7).text TCP
    did -ca firewalledit 2 $did(firewalledit,7).text TCP
    did -ca firewall 65 $did(firewalledit,7).text TCP
    socklisten nuke $+ $did(firewalledit,7).text $did(firewalledit,7).text
    did -a firewall 62 $timestamp Watching Port: $did(firewalledit,7).text (TCP) $crlf 
  }
  if ($did(firewalledit,9).state = 1) { 
    write $scriptdirsocks.txt $did(firewalledit,7).text UDP
    did -ca firewalledit 2 $did(firewalledit,7).text UDP 
    did -ca firewall 65 $did(firewalledit,7).text UDP
    sockudp -k udpnuke $+ $did(firewalledit,7).text $did(firewalledit,7).text
    did -a firewall 62 $timestamp Watching Port: $did(firewalledit,7).text (UDP) $crlf
  }
}
on 1:dialog:firewalledit:sclick:8:did -r firewalledit 11 | did -a firewalledit 11 Add $did(firewalledit,7).text TCP 
on 1:dialog:firewalledit:sclick:9:did -r firewalledit 11 | did -a firewalledit 11 Add $did(firewalledit,7).text UDP
on 1:dialog:firewalledit:edit:7: {
  if ($did(firewalledit,8).state = 1) { did -r firewalledit 11 | did -a firewalledit 11 Add $did(firewalledit,7).text TCP | halt }
  if ($did(firewalledit,9).state = 1) { did -r firewalledit 11 | did -a firewalledit 11 Add $did(firewalledit,7).text UDP | halt }
  did -c firewalledit 8 | did -r firewalledit 11 | did -a firewalledit 11 Add $did(firewalledit,7).text TCP
}
on 1:dialog:firewalledit:sclick:2:did -r firewalledit 12 | did -a firewalledit 12 Del $did(firewalledit,2,$did(firewalledit,2).sel).text
on 1:dialog:firewalledit:init:0: {
  set %fw.i 0
  :loop
  inc %fw.i 1
  if ($read -l $+ %fw.i $scriptdirsocks.txt = $null) { halt }
  did -ca firewalledit 2 $read -l $+ %fw.i $scriptdirsocks.txt
  goto loop
}

alias firewallipfinds {
  set %fw.i1 0
  :loop
  inc %fw.i1 1
  if ($nick(%fw.i2,%fw.i1) = $null) { did -a firewall 62 $timestamp Done Scanning For Nick $crlf | halt }
  if ($gettok($address($nick(%fw.i2,%fw.i1),2),2,$asc(@)) = %fw.naddress) { did -a firewall 62 $timestamp Found Nick: $nick(%fw.i2,%fw.i1) In %fw.i2 $crlf | goto loop }
  if ($gettok($address($nick(%fw.i2,%fw.i1),2),2,$asc(@)) = %fw.naddress.ip) { did -a firewall 62 $timestamp Found Nick: $nick(%fw.i2,%fw.i1) In %fw.i2 $crlf | goto loop }
  goto loop
}
alias firewallipfindall {
  set %fw.i1 0 | set %fw.i2 1
  :loop
  inc %fw.i1 1
  if ($chan(%fw.i2) = $null) { did -a firewall 62 $timestamp Done Scanning For Nick $crlf | halt }
  if ($nick($chan(%fw.i2),%fw.i1) = $null) { inc %fw.i2 1 | set %fw.i1 0 | goto loop }
  if ($gettok($address($nick($chan(%fw.i2),%fw.i1),2),2,$asc(@)) = %fw.naddress) { did -a firewall 62 $timestamp Found Nick: $nick($chan(%fw.i2),%fw.i1) In $chan(%fw.i2) $crlf }
  if ($gettok($address($nick($chan(%fw.i2),%fw.i1),2),2,$asc(@)) = %fw.naddress.ip) { did -a firewall 62 $timestamp Found Nick: $nick($chan(%fw.i2),%fw.i1) In $chan(%fw.i2) $crlf }
  goto loop
}
on 1:dialog:firewall:sclick:71: if ($did(firewall,76).text = $null) { did -a firewall 62 $timestamp No Ip In "Last Connection From" "IP" Field $crlf | halt } | else { did -a firewall 62 $timestamp Looking Up $did(firewall,76).text $crlf | .disable #dnson | .enable #a | dns $did(firewall,76).text }
on 1:dialog:firewall:sclick:68: firewallopen
on 1:dialog:firewall:sclick:63: .timer -m 1 0 /dialog -dm firewalledit firewalledit
on 1:dialog:firewall:sclick:64: .timer -m 1 0 /dialog -dm firewalloptions firewalloptions
on 1:dialog:firewall:sclick:69: firewallclose
on 1:dialog:firewall:init:0: {
  did -r firewall 65
  set %fw.i 0
  :loop
  inc %fw.i 1
  if ($read -l $+ %fw.i $scriptdirsocks.txt = $null) { 
    set %fw.i 0
    :loop1
    inc %fw.i 1
    if ($chan(%fw.i) = $null) {  
      did -ac firewall 73 All
      did -a firewall 62 Benvenuti nel firewall di LazZaro $crlf
      did -a firewall 62 This will only block what ports you tell it to, such as port 139. $crlf
      did -a firewall 62 The FireWall waz only made as an experiment and may not werk as a blocker on some systems. $crlf
      did -a firewall 62 **To Test TCP, Type: /run telnet $ip $crlf
      did -a firewall 62 **To Test UDP, Type: /sockudp TEST 2424 $IP 31337 $IP $crlf
      did -a firewall 62 $crlf
      did -a firewall 62 $timestamp  Connection Ftom Ip: %nuker-ip Port: %nuker-port %nuker-udp-tcp $crlf
      did -r firewall 76 
      did -r firewall 78 
      did -a firewall 76 %nuker-ip
      did -a firewall 78 %nuker-port
      did -c firewall 68
      did -h firewall 67
      did -v firewall 67
      halt
    }
    did -a firewall 73 $chan(%fw.i)
    goto loop1
  }
  did -ca firewall 65 $read -l $+ %fw.i $scriptdirsocks.txt
  goto loop
}
on 1:socklisten:nuke*: { 
  set %nuker-udp-tcp (TCP)
  sockaccept nuker
  %nuker-ip = $sock(nuker,1).ip
  %nuker-port = $gettok($sockname,2,$asc(e))
  sockwrite -n nuker %fw.connect.msg
  .sockclose nuker
  set %nuker-firewall $dialog(firewall)
  if (%fw.active.gui = gui) {
    if (%nuker-firewall != firewall) { .timerfwdialog -m 1 0 dialog -m firewall firewall }
    else {
      did -a firewall 62 $timestamp  Connection Ftom Ip: %nuker-ip Port: %nuker-port %nuker-udp-tcp $crlf
      did -r firewall 76 
      did -r firewall 78 
      did -a firewall 76 %nuker-ip
      did -a firewall 78 %nuker-port
      did -c firewall 68
      did -h firewall 67
      did -v firewall 67
    }
  }
  else {
    echo -a $timestamp Connection Ftom Ip: %nuker-ip Port: %nuker-port %nuker-udp-tcp
    echo -a $timestamp To Open FireWall Gui And Seach For Nick Type: /firewallstart
  }
}
on 1:udpread:udpnuke*:{
  set %nuker-udp-tcp (UDP)
  %nuker-ip = $sock($sockname,1).saddr
  %nuker-port = $gettok($sockname,2,$asc(e))
  set %nuker-firewall $dialog(firewall)
  if (%fw.active.gui = gui) {
    if (%nuker-firewall != firewall) { .timerfwdialog -m 1 0 dialog -m firewall firewall }
    else {
      did -a firewall 62 $timestamp  Connection Ftom Ip: %nuker-ip Port: %nuker-port %nuker-udp-tcp $crlf
      did -r firewall 76 
      did -r firewall 78 
      did -a firewall 76 %nuker-ip
      did -a firewall 78 %nuker-port
      did -c firewall 68
      did -h firewall 67
      did -v firewall 67
    }
  }
  else {
    echo -a $timestamp Connection Ftom Ip: %nuker-ip Port: %nuker-port %nuker-udp-tcp
    echo -a $timestamp To Open FireWall Gui And Seach For Nick Type: /firewallstart
  }
}

alias nukestarup { 
  if (%nukestart = Yes) { firewallstart | firewallopen }
}
alias deleteport /write -ds $+ $1 $scriptdirsocks.txt
alias sockidlisten /socklisten $1 $2 | /write $scriptdirsocks.txt $2
alias firewallclose sockclose nuke* | sockclose udpnuke* | did -a firewall 62 $timestamp All TCP/UDP ports are no longer being watched! $crlf
alias firewallopen {
  set %frw.open.i 0
  :loop
  inc %frw.open.i 1
  set %portnukeinfo $read -l $+ %frw.open.i $scriptdirsocks.txt
  set %portfree $portfree($gettok(%portnukeinfo,1,32))
  if (%portnukeinfo == $null) { halt }
  if ($gettok(%portnukeinfo,2,32) = UDP) {
    did -a firewall 62 $timestamp Watching Port: $gettok(%portnukeinfo,1,32) (UDP) $crlf 
    sockudp -k udpnuke $+ $gettok(%portnukeinfo,1,32) $gettok(%portnukeinfo,1,32)
    goto loop 
  }
  if (t isin %portfree) { 
    if ($gettok(%portnukeinfo,2,32) = TCP) {
      did -a firewall 62 $timestamp Watching Port: $gettok(%portnukeinfo,1,32) (TCP) $crlf 
      socklisten nuke $+ $gettok(%portnukeinfo,1,32) $gettok(%portnukeinfo,1,32)
      goto loop 
    }
  }
  did -a firewall 62 $timestamp Cant Open Port: $gettok(%portnukeinfo,1,32) ( $+ $gettok(%portnukeinfo,2,32) $+ ) <In Use By Another Program> $crlf
  goto loop
}
