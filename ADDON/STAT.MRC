alias stat {
  window -a @Statistiche 2 2 260 600 Big Fonts Verdana 10
  echo @Statistiche ------------------------------------------------ 
  echo @Statistiche  12Statistiche Personali
  echo @Statistiche  12Timer In linea:4 $online secondi
  echo @Statistiche  12Data:4 $adate 
  echo @Statistiche  12Ora:4 $time
  echo @Statistiche  12Ticks dall'avvio:4 $ticks 
  echo @Statistiche  12Ora esatta:4 $fulldate 
  echo @Statistiche  12Script:4 %ver
  echo @Statistiche  12Canali:4 $chan(N/#)
  echo @Statistiche  12Inattività:4 $idle secondi
  echo @Statistiche  12Host:4 $host
  echo @Statistiche  12IP:4 $ip
  echo @Statistiche  12Server:4 $server
  echo @Statistiche  12Porta:4 $port
  echo @Statistiche  12Versione mIRC:4 $version
  echo @Statistiche  12Nick:4 $me
  echo @Statistiche  12Aliases:4 $alias(0)
  echo @Statistiche  12Giorno:4 $day
  echo @Statistiche  12UserMode:4 $usermode
  echo @Statistiche  12URL:4 $url
  echo @Statistiche  12Assente:4 $away
  echo @Statistiche  12Nome DDE:4 $ddename
  echo @Statistiche  12E-Mail:4 $email
  echo @Statistiche  12DCC Chats:4 $chat(0)
  echo @Statistiche  12DCC Gets:4 $get(0)
  echo @Statistiche  12Scripts:4 $script(0)
  echo @Statistiche  12File INI mIRC:4 $mircini
  echo @Statistiche  12Cartella mIRC:4 $mircdir
  echo @Statistiche  12Cartella Logs:4 $logdir
  echo @Statistiche  12Cartella MIDI:4 $mididir
  echo @Statistiche  12Cartella File Ricevuti:4 $getdir
  echo @Statistiche  12IP Lungo:4 $longip
  echo @Statistiche  12Cartella Wave:4 $wavedir
  echo @Statistiche  12Time Zone:4 $timezone
  echo @Statistiche  12Secondi dal 1 Gennaio 1940:4 $ctime
  echo @Statistiche  1Timer Online:4 $duration($online)
  echo @Statistiche  12DCC Sends:4 $send(0)
} 
menu @SocketStats {
  Aggiorna:sstats
}
alias sstats {
  window -c @SocketStats
  window -l @SocketStats @SocketStats courier new
  aline 5 @SocketStats Sockets mIRC aperti:12 $sock(*,0)
  if ($sock(*,0) >= 1) {
    set %sstats.tmp 0
    :begin
    inc %sstats.tmp 1
    if ($sock(*,%sstats.tmp) == $null) { goto end }
    aline 2 @SocketStats -
    aline 5 @SocketStats Nome:12 $sock(*,%sstats.tmp)
    aline 6 @SocketStats ^-->5 IP:12 $sock(*,%sstats.tmp).ip
    aline 6 @SocketStats ^-->5 Porta:12 $sock(*,%sstats.tmp).port
    aline 6 @SocketStats ^-->5 Stato:12 $sock(*,%sstats.tmp).status
    aline 6 @SocketStats ^-->5 Byte Inviati:12 $sock(*,%sstats.tmp).sent byte
    aline 6 @SocketStats ^-->5 Byte Ricvuti:12 $sock(*,%sstats.tmp).rcvd byte
    aline 6 @SocketStats ^-->5 Coda Buffer Invio:12 $sock(*,%sstats.tmp).sq byte
    aline 6 @SocketStats ^-->5 Coda Buffer Ricez:12 $sock(*,%sstats.tmp).rq byte
    aline 6 @SocketStats ^-->5 Info Ultimo Invio:12 $sock(*,%sstats.tmp).ls sec
    aline 6 @SocketStats ^-->5 Info Ultima Ricez:12 $sock(*,%sstats.tmp).lr sec
    if ($sock(*,%sstats.tmp).mark != $null) { aline 6 @SocketStats ^-->5 Dati Mark:12 $sock(*,%sstats.tmp).mark }
    else { aline 6 @SocketStats ^-->5 Nessun Dato Mark }
    goto begin
    :end
  }
}
