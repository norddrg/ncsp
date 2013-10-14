procedure ncspetsi
  parameter ne_kood
  if len(ne_kood)<5
    ne_kood=ne_kood+space(4-len(ne_kood))
  endif
  et_loop=.t.
  select ncsp_luv
  set order to ncsp
  set filter to
  seek substr(ne_kood,1,1)
  select ncsp_ryh
  set order to ncsp
  set filter to
  seek substr(ne_kood,1,2)
  select ncsp_koo
  set order to code
  set filter to
  if code<>trim(ne_kood) and ncsp<>trim(ne_kood)
    seek trim(ne_kood)
  endif
  ne_found=.f.
  if code=trim(ne_kood)
    ne_found=.t.
    select ncsp_ala
    set order to code
    seek substr(ne_kood,1,4)
    if not found()
      seek substr(ne_kood,1,3)
    endif
  endif
  select ncsp_koo
  if not ne_found
    if ncsp<>trim(ne_kood)
      set order to ncsp
      seek trim(ne_kood)
      set order to code
    endif
    select ncsp_ala
    seek substr(ne_kood,1,4)
    if not found()
      seek substr(ne_kood,1,3)
    endif
  endif
  select ncsp_koo
  if suodatin
    set order to code
  else
    set order to ncsp
  endif
  pub_code=ncsp_koo.code
 return
