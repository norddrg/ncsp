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
  if alias()='SUOD'
    pa_kood=trim(ncsp_koo.ncsp)
  else
    pa_kood=ncsp
  endif
  if alias()<>'SUOD' and alias()<>'NCSP_KOO'
    select ncsp_luv
    set order to ncsp
    select ncsp_ryh
    set order to ncsp
    select ncsp_ala 
    set order to ncsp
    select ncsp_koo
    set order to ncsp
  endif
  *do ncspetsi with pa_kood
  select (lc_alias)
  do naytto
  return
