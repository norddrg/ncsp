*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\ETSI.PRG
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
*:   etsi
*!******************************************************************************
*!
*! Procedure ETSI
*!
*!  Calls
*!      len
*!      space
*!      substr
*!
*!******************************************************************************
procedure etsi
  parameter et_kood
  if len(et_kood)<5
    et_kood=et_kood+space(4-len(et_kood))
  endif
  et_loop=.t.
  select ncsp_luv
  set filter to
  seek substr(et_kood,1,1)
  select ncsp_ryh
  set filter to
  seek substr(et_kood,1,2)
  select ncsp_ala
  set filter to
  seek substr(et_kood,1,4)
  select ncsp_koo
  lc_order=order()
  set order to code
  seek (et_kood)
  set order to (lc_order)
  return
