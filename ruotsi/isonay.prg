*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\ISONAY.PRG
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
*:   isonay
*!******************************************************************************
*!
*! Procedure ISONAY
*!
*!******************************************************************************
procedure isonay
  lc_alias=alias()
  on key label ctrl+b do editoi
  set filter to
  browse noedit
  on  key label ctrl+b do isonay
  select (lc_alias)
  do ..\ruotsi\naytto
  return
