*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\OHJE.PRG
*:
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:
*: Documented using Visual FoxPro Formatting wizard version  .05
*:******************************************************************************
*:   ohje
*!******************************************************************************
*!
*! Procedure OHJE
*!
*!******************************************************************************
procedure ohje
  activate window valikko
  clear
  @ 0,2 say 'NCSP danish version'

  @ 3,5 say '[F12] - Edit activated code'

  @ 5,5 say '[F11] - uppdate the screen'
  @ 6,5 say '[Ctrl][F11] - show all/ active codes'
  @ 7,5 say '[Alt][F11] - add and edit a new code'
  @ 8,5 say '[Alt][B] - add and edit a new code'
  @ 9,5 say '[Ctrl][B] - open large window'
  @ 10,5 say '[F9] - all/undeleted/speciality codes'
  @ 11,5 say '[Alt][F9] - change the filter file'
  
  @ 13,5 say '[Alt][F8] - Transfer for DRG to C:/data'
  @ 14,5 say '[F7]      - Update common NCSP-version'

  @ 26,5 say '[Ctrl][F1] - Stop the program'
  @ 27,5 say '[Alt][F1] - restart the program'

  if max_x>28
    @ 28,5 say '[Ctrl][F] - start text search / [Alt][F] search for a code'
  endif
  if max_x>29
    @ 29,5 say '[Ctrl][G] - repeat code search'
  endif

  on key label f12 do ..\tanska\kasit
  on key label f11 do ..\tanska\paiv
  on key label ctrl+f11 do ..\tanska\suodatin
  on key label f9 do ..\tanska\suodkay
  on key label alt+f9 do ..\tanska\suodval1
  on key  label  ctrl+f8 do  ..\tanska\siirmuun
  on key label alt+f8 do ..\tanska\siir_drg
  on key label f7 do ..\tanska\simupda
*  on key label alt+f7 do ..\tanska\simupda
  on key label alt+l do ..\tanska\lang_pal
  on key label alt+f11 do ..\tanska\lang_pal

  on key label f2 do ..\tanska\valinta

  on key label alt+f do ..\tanska\koodets
  on key label alt+b do ..\tanska\lisays
  on key label  ctrl+b do ..\tanska\isonay
  on key label f10

  on key label alt+f1 do ..\tanska\ncsp
  on key label ctrl+f1 do ..\tanska\lopetus

  return
