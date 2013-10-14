*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\LISAYS.PRG
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
*:   lisays
*!******************************************************************************
*!
*! Procedure LISAYS
*!
*!  Calls
*!      alias
*!      date
*!
*!******************************************************************************
procedure lisays
  lc_alias=alias()
  set filter to
  lc_koodi=code
  append blank
  if alias()='NCSP_EN'
    replace code with lc_koodi
  else
    replace code with lc_koodi
    replace chadate with date()
  endif
  edit
  select (lc_alias)
  do ../tanska/naytto
  return
