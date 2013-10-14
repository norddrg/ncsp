procedure simloop
parameter suunta
lc_loop=.t.
do while lc_loop
  select ncsp_koo
  if ncsp_koo.code=' '
    replace released with .t.
    delete
    if suunta=1 and eof()
      exit
    endif
    if suunta=-1 and bof()
      exit
    endif
    skip suunta
    loop
  endif
  if ncsp_koo.released
    if suunta=1 and eof()
      exit
    endif
    if suunta=-1 and bof()
      exit
    endif
    skip suunta
    loop
  endif
  do ../tanska/simtark
  su_code=ncsp_koo.code
  if lc_tark and not lc_tark2
    lc_tark2=.t.
    do ../tanska/simcheck
    return
  endif
  select ncsp_en
  set order to code_den
  seek ncsp_koo.code
  if not found()
    wait window nowait 'The '+ncsp_koo.code +'-line will be added to the NCSP common version without mapping'
    do ../tanska/simno
    do ../tanska/simcheck
    return
  endif
  select ncsp_koo
  lc_tark2=.f.
  if suunta=1 and eof()
    exit
  endif
  if suunta=-1 and bof()
    exit
  endif
  skip (suunta)
  public sim_code
  sim_code=ncsp_koo.code
enddo
do ../tanska/simlop
return