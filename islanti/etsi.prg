procedure etsi
  parameter et_kood
  et_2=et_kood
  select ncsp_koo
  set order to ncsp
  seek trim(et_2)
  if not found()
    select ncsp_koo
    set order to code
    seek trim(et_2)
  endif
  if suodatin
    et_2=code
    set order to code
    select suod
    seek trim(et_2)
  endif
  do ncspetsi with ncsp_koo.ncsp
  return
