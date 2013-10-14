goto top
do while not eof()
  if ncsp_koo.code=' '
    skip
    loop
  endif
  select ncsp_en
  seek ncsp_koo.ncsp
  if released
    SET STEP ON
    do while ncsp_en.code_fin<>ncsp_koo.code and ncsp_en.code=ncsp_koo.ncsp and not eof()
      skip
    enddo
    if released and ncsp_en.code_fin=ncsp_koo.code
      replace ncsp_koo.ncsp with ncsp_en.subst
    endif
    replace ncsp_en.code_fin with ' '
    if ncsp_en.reldate<ncsp_en.usedate and code_den=' ' and code_swe=' ' and code_nor=' ' and code_eng=' ' and code_est=' '
      delete
    endif
  endif
  select ncsp_koo
  skip
enddo
