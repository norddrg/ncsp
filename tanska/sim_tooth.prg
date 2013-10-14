procedure sim_tooth
su_code=ncsp_koo.code
replace ncsp_koo.ncsp with ncsp_en.code
select ncsp_en
replace ncsp_en.code_den with ncsp_koo.code
lc_ncsp=ncsp_en.code
lc_rec=recno()

set filter to not released
set order to code_den
seek trim(ncsp_koo.code)
do while code_den=ncsp_koo.code and not eof() 
  if recno()<>lc_rec
    replace code_den with ' '
    if code_swe=' ' and code_den=' ' and code_nor=' ' and code_est=' ' and code_fin=' ' and code_eng=' '  and ncsp=' '
      replace released with .t.
      delete
    endif
  endif
  select ncsp_en
  skip
enddo
lc_find=.t.
do ../tanska/simcheck
return
