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
    wait window nowait 'Kaikki koodit'
  else
    p_poist=.t.
    wait window nowait 'Poistamattomat koodit'
  endif
  do naytto
  return
