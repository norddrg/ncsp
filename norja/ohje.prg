procedure ohje
  activate window valikko
  clear
  @ 0,2 say 'NCSP Norwegian version'

  @ 3,5 say '[F12] - Edit the activated row'
*  @ 4,5 say '[Alt][F12] - Uppdate the date field'
  @ 5,5 say '[F11] - Uppdate screen from active window'
  @ 6,5 say '[Ctrl][F11] - Show all / unreleased codes'
  @ 7,5 say '[Alt][F11] - Start using NCPS+'
  @ 8,5 say '[Alt][B] - Add a row to current table'
  @ 9,5 say '[Ctrl][B] - Open current table for edition'
  @ 10,5 say '[F9] - all/unreleased/speciality codes '
  @ 11,5 say '[Alt][F9] - change the filter file'
*  @ 12,5 say '[Ctrl][S] - Show Finnish text, [Ctrl][R] - Show Swedish text'
*  @ 12,5 say '[F5] - katso vanhaa toimenpideluokitusta'
*  @ 13,5 say '[F3] - siirry ICD-10 k‰sittelyyn'
@ 18,5 say '[F6] - look at alphabetical index - [Ctrl][F6] - regenerate alphabetical index'

  @ 22,5 say '[F8] - Create transfer file for Ventura'
  @ 23,5 say '[Ctrl][F8] - Create general transfer files'
  @ 24,5 say '[Alt][F8] - Create transfer file for DRG to mapp C:/data'
  @ 25,5 say '[F7] - Uppdate NCSP+ with Norwegian codes'

  @ 26,5 say '[Ctrl][F1] - Stop the program to Fox'
  @ 27,5 say '[Alt][F1] - Restart the program'

  if max_x>28
    @ 28,5 say '[Ctrl][F] - FoxPro Find / [Alt][F] - Search a code'
  endif
  if max_x>29
    @ 29,5 say '[Ctrl][G] - Repeat FoxPro Find'
  endif
*if max_x>31
*  @ 30,5 say '[Ctrl][C] - kopioi valitun tekstin'
*endif
*if max_x>32
*  @ 31,5 say '[Ctrl][V] - lis‰‰ muistissa olevan tekstin'
*endif

  on key label f12 do ../norja/kasit
*ON KEY LABEL ctrl+f12 do ../norja/lisays
*  on key label alt+f12 do ../norja/pvmmuu
  on key label f11 do ../norja/paiv
  on key label ctrl+f11 do ../norja/suodatin
  on key label alt+f11 do ../norja/lang_pal
  on key label f9 do ../norja/suodkay
  on key label alt+f9 do ../norja/suodval1
  on key label f8 do ../norja/ventncsp
  on key  label  ctrl+f8 do ../norja/siirmuun
  on key label alt+f8 do ../norja/siir_drg
  on key label f7 do ../norja/simupda
  on key label f6 do ../norja/aakalo
  on key label ctrl+f6 do ../norja/aakkos

*  on key label f5 do ../norja/vanhat

*  on key label f2 do ../norja/valinta
*  on key label f3 do \data\icd_10\icdnayt\_icdnay
  on key label alt+f do ../norja/koodets
  on key label alt+b do ../norja/lisays
  on key label  ctrl+b do ../norja/isonay
*  on key label alt+f11 do ../norja/englanti
  on key label ctrl+s 
  on key label ctrl+r 
  on key label f10

  on key label alt+f1 do ../norja/ncsp
  on key label ctrl+f1 do ../norja/lopetus
  on key label alt+l do ../norja/lang_pal
return

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
do ../norja/_ncsp
RETURN
 
