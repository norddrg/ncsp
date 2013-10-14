procedure simno
replace ncsp_koo.ncsp with ' '
Select ncsp_en
set order to code_swe
nm_loop=.t.
do while nm_loop
  seek ncsp_koo.code
  if not found() 
    insert into ncsp_en (code, code_swe,  released, usedate, chadate, text);
    values (ncsp_koo.code, ncsp_koo.code, .f., ncsp_koo.usedate, ncsp_koo.chadate, ncsp_koo.english)
    if ncsp_en.text=' '
      replace ncsp_en.text with ncsp_koo.text_2
    endif
    if ncsp_en.text=' '
      replace ncsp_en.text with ncsp_koo.text
    endif
    exit
  endif
  if found() and ncsp_en.ncsp<>' '
    replace code_swe with ' '
    loop
  endif
  if code_swe=' ' and code_den=' ' and code_nor=' ' and code_est=' ' and code_fin=' ' and code_eng=' ' and ncsp=' '
    replace text with ncsp_koo.english
  else
    if text=' ' 
      replace text with ncsp_koo.english
    endif
  endif
  if text=' '
    replace text with ncsp_koo.text_2
  endif
  if text=' '
    replace text with ncsp_koo.text
  endif
  skip
  if ncsp_en.code_swe=ncsp_koo.code
    replace code_swe with ' '
  else
    exit
  endif
enddo
lc_find=.f.
select ncsp_en
set order to code_swe
seek ncsp_koo.code
wait window 'Should local code be added to common version? (Y)/(N)?'
if lastkey()=121 or lastkey()=89
  replace ncsp with code
  edit fields ncsp, text, short, usedate next 1
  replace code with ncsp
  do ..\ruotsi\sim_toloc
else
  do ..\ruotsi\simnayt
endif
return

