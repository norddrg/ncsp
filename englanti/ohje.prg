procedure ohje
  activate window valikko
  clear
  @ 0,2 say 'NCSP official English version'

*  @ 2,5 say '[F2] - toimenpideluokituksen laatu'
  @ 3,5 say '[F12] - Edit current line'
*  @ 4,5 say '[Alt][F12] - change date stamle'
  @ 5,5 say '[F11] - uppdate the screen from current window'
  @ 6,5 say '[Ctrl][F11] - show all / show active codes'
  @ 7,5 say '[Alt][F11] - go to NCSP+'
  @ 8,5 say '[Alt][B] - add a line to current table'
  @ 9,5 say '[Ctrl][B] - show the table in a large code'
  @ 10,5 say '[F9] - show all/undeleted/speciality codes'
  @ 11,5 say '[Alt][F9] - exchange the filter file'
  @ 13,5 say '[F3] - move to ICD-10 file'

  @ 22,5 say '[F8] - create a file for Ventura'
  @ 23,5 say '[Ctrl][F8] - create transport files'
  @ 24,5 say '[Alt][F8] - create transport file for DRG to c:\data'
  @ 25,5 say '[F7] - comparison with NCSP+'

  @ 26,5 say '[Ctrl][F1] - stop this program'
  @ 27,5 say '[Alt][F1] - restart the program'

  if max_x>28
    @ 28,5 say '[Ctrl][F] - standard Find / [Alt][F] code search'
  endif
  if max_x>29
    @ 29,5 say '[Ctrl][G] - repeat the search'
  endif
  on key label f12 do ..\englanti\kasit
*  on key label alt+f12 do pvmmuu
  on key label f11 do ..\englanti\paiv
  on key label ctrl+f11 do ..\englanti\suodatin
  on key label alt+f11 do ..\englanti\lang_pal
  on key label f9 do ..\englanti\suodkay
  on key label alt+f9 do ..\englanti\suodval1
  on key label f8 do ..\englanti\ventncsp
  on key  label  ctrl+f8 do ..\englanti\siirmuun
  on key label alt+f8 do ..\englanti\siir_drg
  on key label f7 do ..\englanti\simupda

  on key label f3 do \data\icd_10\icdnayt\_icdnay
  on key label alt+f do ..\englanti\koodets
  on key label alt+b do ..\englanti\lisays
  on key label  ctrl+b do ..\englanti\isonay
  on key label ctrl+s do ..\englanti\suomi
  on key label ctrl+r do ..\englanti\ruotsi
  on key label f10

  on key label alt+f1 do ..\englanti\ncsp
  on key label ctrl+f1 do ..\englanti\lopetus
  on key label alt+l do ..\englanti\lang_pal
 PROCEDURE lopetus
ON KEY LABEL f12
ON KEY LABEL f11
ON KEY LABEL ctrl+f11
ON KEY LABEL ctrl+f12
ON KEY LABEL f10
ON KEY LABEL ctrl+f10
ON KEY LABEL f9
ON KEY LABEL ctrl+f9
ON KEY LABEL alt+f1
ON KEY LABEL ctrl+f1
on key label ctrl+s
on key label ctrl+e
on key label ctrl+s
on key label ctrl+p
RELEASE WINDOWS
CLEAR ALL
CLEAR
do ..\englanti\_ncsp
RETURN
 