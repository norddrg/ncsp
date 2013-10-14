procedure simno
replace ncsp_koo.ncsp with ' '
Select ncsp_en
set filter to not released
set order to code_nor
nm_loop=.t.
do while nm_loop
  seek ncsp_koo.code
  if found()
    replace code_nor with ' '
    if code_swe=' ' and code_den=' ' and code_nor=' ' and code_est=' ' and code_fin=' ' and code_eng=' '  and ncsp=' '
      replace released with .t.
      delete
    endif
    loop
  endif
  insert into ncsp_en (code, code_nor,  released, usedate, chadate, text);
  values (ncsp_koo.code, ncsp_koo.code, .f., ncsp_koo.usedate, ncsp_koo.chadate, ncsp_koo.english)
  replace nc with .f.
  if ncsp_en.text=' '
    replace ncsp_en.text with ncsp_koo.text_2
  endif
  if ncsp_en.text=' '
    replace ncsp_en.text with ncsp_koo.text
  endif
  exit
enddo
lc_find=.f.
select ncsp_en
set order to code_nor
seek ncsp_koo.code
wait window 'Should local code be added to common version? (Y)/(N)?'
if lastkey()=121 or lastkey()=89
  replace ncsp with code
  edit fields ncsp, text, short, usedate next 1
  replace code with ncsp
  do ../norja/sim_toloc
else
  do ../norja/simnayt
endif
return

