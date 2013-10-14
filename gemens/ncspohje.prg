procedure ncspohje
  activate window valikko
  clear
  @ 0,2 say 'NCSP - International version'

  @ 3,5 say '[F12] - edit the active line'
  *@ 4,5 say '[Alt][F12] - change date off the active line'
  @ 5,5 say '[F11] - update screen according to the active file'
  @ 6,5 say '[Alt][F11] - start working with NCSP-'+p_kieli
  @ 7,5 say '[Ctrl][F11] - change second language'

  @ 9,5 say '[F9] - select filter '

  @ 11,5 say '[F8] - transfer combined database'
  @ 12,5 say '[Ctrl][F8] - transfer for general use'
  
  @ 14,5 say '[F7] - create report in Excel format'

  @ 18,5 say '[Alt][B] - add a row to the active file'
  @ 19,5 say '[Ctrl][B] - show the active file in a large window'

  @ 26,5 say '[Ctrl][F1] - quitt to FoxPro'
  @ 27,5 say '[Alt][F1] - restart the program'

  if max_x>28
    @ 28,5 say '[Ctrl][F] - seacrch text / [Alt][F] search code'
  endif
  if max_x>29
    @ 29,5 say '[Ctrl][G] - repeat the search'
  endif
*if max_x>31
*  @ 30,5 say '[Ctrl][C] - kopioi valitun tekstin'
*endif
*if max_x>32
*  @ 31,5 say '[Ctrl][V] - lis�� muistissa olevan tekstin'
*endif

  on key label f12 do ..\gemens\kasit
*ON KEY LABEL ctrl+f12 DO lisays
*  on key label alt+f12 do pvmmuu
  on key label f11 do ..\gemens\paiv
  on key label alt+F11 do ..\gemens\lang_ver
  on key label ctrl+F11 do ..\gemens\lang_def
  on key label f9 do suodkay
*  on key label alt+f9 do suodval1
  on key label alt+f8 do ..\gemens\siirmuun
  on key label f8 do ..\gemens\siiryhd
  on key  label  ctrl+f8 do  ..\gemens\siirmuun
  on key label f7 do ..\gemens\repfile
*  on key label f5 do vanhat

 * on key label f2 do valinta

  on key label alt+f do ..\gemens\koodets
  on key label alt+b do ..\gemens\lisays
  on key label  ctrl+b do ..\gemens\isonay
*  on key label alt+f11 do englanti
 * on key label ctrl+s do suomi
 * on key label ctrl+r do ruotsi
 * on key label f10

  on key label alt+f1 do ..\gemens\_ncsp
  on key label ctrl+f1 do ..\gemens\lopetus
  return
