procedure sim_toloc
su_code=ncsp_koo.code
lc_loop=.t.
if ncsp_en.ncsp=' '
  if ncsp_en.code_nor=ncsp_koo.code and ncsp_koo.ncsp=ncsp_en.ncsp and released
    replace released with .f.
  else
    wait window 'Mapping has to be to a common NCSP-code'
    return
  endif
else
  replace ncsp_en.code_nor with ncsp_koo.code
  replace ncsp_koo.ncsp with ncsp_en.code
  if ncsp_koo.english=' '
    replace ncsp_koo.english with ncsp_en.text
  endif
  select ncsp_en
  set order to code_nor
  seek ncsp_koo.code
  do while code_nor=ncsp_koo.code
    if ncsp<>ncsp_koo.ncsp
      replace code_nor with ' '
      if code_den=' ' and code_fin=' 'and code_swe=' ' and code_est=' ' and code_eng=' ' and ncsp=' '
         delete
      endif
      seek ncsp_koo.code
      loop
    else
      if not eof()
	    skip
	    loop
	  endif
	  exit
    endif
  enddo
endif
lc_find=.t.
do ../norja/simcheck
return
