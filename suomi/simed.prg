procedure simed
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
use
use ncsp_koo.dbf
SET FILTER TO NOT released
set order to code
seek sim_code
select ncsp_en
set order to code_fin
seek ncsp_koo.code
if not found()
  wait window nowait 'The line has be added to NCSP common version without mapping, check the result'
  do no_match
  do simcheck
  return
endif
select ncsp_koo
if not bof()
  skip -1
  sim_code=ncsp_koo.code
  do simloop with -1
endif
return  
