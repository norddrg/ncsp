procedure paiv
  lc_alias=alias()
  if alias()='SUOD'
    pa_kood=trim(ncsp_koo.code)
  else
    pa_kood=code
  endif
  if alias()<>'SUOD' and alias()<>'NCSP_KOO'
    select ncsp_luv
    set order to code
    select ncsp_ryh
    set order to code
    select ncsp_ala 
    set order to code
    select ncsp_koo
    set order to code
  endif
  *do ncspetsi with pa_kood
  select (lc_alias)
  do naytto
  return
