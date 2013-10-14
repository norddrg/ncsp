*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\PVMMUU.PRG
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
*:   pvmmuu
*!******************************************************************************
*!
*! Procedure PVMMUU
*!
*!  Calls
*!      alias
*!      ctod
*!      date
*!      dtoc
*!      lastkey
*!      not
*!
*!******************************************************************************
procedure pvmmuu
  lc_muutos=muutos
  if not (alias()='NCSP_KOO' or alias()='NCSP_ALA' or alias()='NCSP_RYH' or alias()='NCSP_LUV')
    wait window 'Mik‰ tiedosto?'
    return
  endif
  wait window 'Haluatko muuttaa '+ alias() +'-tietueen p‰iv‰m‰‰r‰n. Enter = peruuutus'
  if lastkey()=13
    wait window "Palautetaanko entinen pvm (" + dtoc(lc_muutos) + ") vai 20/6/95. Enter = 20/06/95"
    if lastkey()=13
      replace muutos with ctod('20/06/95')
    else
      replace muutos with lc_muutos
    endif
    do ..\ruotsi\naytto
    return
  endif
  replace muutos with date()
  do ..\ruotsi\naytto
  return
