procedure simed
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
seek sim_code
select ncsp_en
set order to code_lat
seek ncsp_koo.code
if not found()
  wait window nowait 'The line has be added to NCSP common version without mapping, check the result'
  do ..\latvia\no_match
  do ..\latvia\simcheck
  return
endif
select ncsp_koo
if not bof()
  skip -1
  sim_code=ncsp_koo.code
  do simloop with -1
endif
return  
