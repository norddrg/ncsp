*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\PAIV.PRG
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
*:   paiv
*!******************************************************************************
*!
*! Procedure PAIV
*!
*!  Calls
*!      alias
*!      trim
*!
*!******************************************************************************
procedure paiv
  lc_alias=alias()
  pa_kood=trim(ncsp)
  if ncsp=' '
    pa_kood=code
  endif
  do etsi with pa_kood
  select (lc_alias)
  do ..\gemens\naytto
  return
