procedure simed
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
seek sim_code
select ncsp_en
set order to code_swe
seek ncsp_koo.code
if not found()
  wait window nowait 'The line has been added to NCSP common version without mapping, check the result'
  do ..\ruotsi\no_match
  do ..\ruotsi\simcheck
  return
endif
select ncsp_koo
if not bof()
  skip -1
  sim_code=ncsp_koo.code
  do ..\ruotsi\simloop with -1
endif
return  
