@ECHO OFF
@CLS
@DEL STATRETE.TXT
ECHO --------------------------------------------
ECHO Pizza Script 2.7 WarOp
ECHO by PizzaTeam  Alexius e Frankj
ECHO --------------------------------------------
@ARP -a >> STATRETE.TXT
ECHO. >> STATRETE.TXT
ECHO -=+=-=+=-=+=-=+=-=+=-=+=-=+=- >> STATRETE.TXT
ECHO. >> STATRETE.TXT
ECHO Statistiche Ethernet >> STATRETE.TXT
@NETSTAT -e >> STATRETE.TXT
@NETSTAT -s >> STATRETE.TXT
@NETSTAT -a >> STATRETE.TXT
ECHO. >> STATRETE.TXT
ECHO -------------------------------------------- >> STATRETE.TXT
ECHO ® PÎZzÂ §©rÎpT© 2.7 WarOp >> STATRETE.TXT
ECHO by PizzaTeam  ÄLë×iüS & F®åñ|<j >> STATRETE.TXT
ECHO -------------------------------------------- >> STATRETE.TXT
ECHO Ricerca fatta.. Caricamento dei risultati.
C:\WINDOWS\NOTEPAD.EXE STATRETE.TXT
@EXIT