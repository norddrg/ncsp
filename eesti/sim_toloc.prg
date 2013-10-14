procedure sim_toloc
su_code=ncsp_koo.code
lc_loop=.t.
if ncsp_en.ncsp=' '
  if ncsp_en.code_est=ncsp_koo.code and ncsp_koo.ncsp=ncsp_en.ncsp and released
    replace released with .f.
  else
    wait window 'Mapping has to be to a common NCSP-code'
    return
  endif
else
  replace ncsp_en.code_est with ncsp_koo.code
  replace ncsp_koo.ncsp with ncsp_en.code
  if ncsp_koo.english=' '
    replace ncsp_koo.english with ncsp_en.text
  endif
  select ncsp_koo
  set order to code
  select ncsp_en
  set filter to not released
  set order to code_est
  seek ncsp_koo.code
  do while trim(code_est)=trim(ncsp_koo.code) and len(trim(code))>0
    if ncsp<>ncsp_koo.ncsp
      replace code_est with ' '
      if code_den=' ' and code_swe=' 'and code_nor=' ' and code_est=' ' and code_fin=' ' and code_eng=' ' and ncsp=' '
         delete
      endif
      seek ncsp_koo.code
      loop
    else
      if eof()
	    exit
	  endif
	endif
    skip
    loop
  enddo
endif
lc_find=.t.
do ..\eesti\simcheck
return
