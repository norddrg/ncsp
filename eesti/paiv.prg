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
  pa_kood=trim(code)
  do etsi with pa_kood
  select (lc_alias)
  do ..\eesti\naytto
  return
