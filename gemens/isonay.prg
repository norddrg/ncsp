procedure isonay
on key label ctrl+b do edirivi
set filter to
lc_apuik=.t.
do while lc_apuik
  DEFINE WINDOW apuikk FROM 1,1 TO max_y, 2*max_x/3  FONT  max_foty,  max_fosi
  ACTIVATE WINDOW apuikk
  wait window '[CTRL][B] - change current record, [Ctrl][W] - return to basic window' nowait
  BROWSE noedit nodelete 
  if lastkey()=23 or lastkey()=27
    exit
  endif
enddo
release window apuikk
on key label ctrl+b do isonay
do ..\gemens\suodkay
do ..\gemens\naytto 
return

