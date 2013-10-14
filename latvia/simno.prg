procedure simno
replace ncsp_koo.ncsp with ' '
Select ncsp_en
set filter to not released
set order to code_lat
nm_loop=.t.
do while nm_loop
  seek ncsp_koo.code
  if found()
    replace code_lat with ' '
    if code_swe=' ' and code_den=' ' and code_nor=' ' and code_est=' ' and code_fin=' ' and code_eng=' ' AND code_ice=' ' AND code_lat=' '
      if ncsp=' '
        replace released with .t.
        delete
      else
        wait window 'Shall '+ncsp+' be deleted? Y/N'
        if lastkey()=121 or lastkey()=89
          replace released with .t.
          delete
        endif
     endif
    endif
    loop
  endif
  insert into ncsp_en (code, code_lat,  released, usedate, chadate, text);
  values (ncsp_koo.code, ncsp_koo.code, .f., ncsp_koo.usedate, ncsp_koo.chadate, ncsp_koo.text)
  replace nc with .f.
  if ncsp_en.text=' '
    replace ncsp_en.text with ncsp_koo.text_2
  endif
  exit
enddo
lc_find=.f.
select ncsp_en
set order to code_lat
seek ncsp_koo.code
wait window 'Should local code be added to common version? (Y)/(N)?'
if lastkey()=121 or lastkey()=89
  replace ncsp with code
  edit fields ncsp, text, short, usedate next 1
  replace code with ncsp
  do ..\latvia\sim_toloc
else
  do ..\latvia\simnayt
endif
return

