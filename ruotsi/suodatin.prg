*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\SUODATIN.PRG
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
*:   suodatin
*!******************************************************************************
*!
*! Procedure SUODATIN
*!
*!******************************************************************************
procedure suodatin
  if p_poist
    p_poist=.f.
  else
    p_poist=.t.
  endif
  do ..\ruotsi\naytto
  return
