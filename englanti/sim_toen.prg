procedure sim_toen
su_code=ncsp_koo.code
if ncsp_en.ncsp=' '
  wait window 'Do you want to mapp to a non NCSP-code (Y)/(N)?'
  if lastkey()=121 or lastkey()=89
    replace ncsp_koo.ncsp with ncsp_en.code
    replace ncsp_en.code_eng with ncsp_koo.code
    lc_recno=recno()
    select ncsp_en
    set order to code_eng
    goto top
    seek ncsp_koo.code
    do while trim(code_eng)=trim(ncsp_koo.code) and not eof()
      if recno()<>lc_recno
        replace code_eng with ' '
        seek ncsp_koo.code
        loop
      endif 
      skip
    enddo
  endif
  do ..\englanti\simloc
  return
endif
replace ncsp_koo.ncsp with ncsp_en.ncsp
if ncsp_en.code_eng=ncsp_koo.code and ncsp_koo.code=ncsp_en.code_eng
  replace ncsp_en.code_eng with ' '
endif
lc_ncsp=ncsp_en.ncsp

select ncsp_en
set order to code_eng
lc_loop=.t.
seek trim(ncsp_koo.code)
do while lc_loop
  if eof()
    exit
  endif
  if trim(code_eng)=trim(ncsp_koo.code) and trim(ncsp_koo.code)=trim(code_eng)
    if ncsp_en.ncsp<>ncsp_koo.ncsp
      replace ncsp_en.code_eng with ' '
      seek trim(ncsp_koo.code)
    else
      replace code with ncsp_en.ncsp
      skip
    endif
  else
    exit
  endif
enddo
seek ncsp_koo.code
if not found()
  insert into ncsp_en (code, code_eng);
  values (ncsp_koo.ncsp, ncsp_koo.code)
else
  if ncsp_en.ncsp=' '
    replace ncsp_en.code with lc_ncsp
  endif
endif
if code_eng=' '
  replace nc with .f.
else
  replace nc with .t.
endif
replace ncsp_en.chadate with ncsp_koo.chadate, ncsp_en.usedate with ncsp_koo.usedate
if code_swe=' '
  replace ncsp_en.text with ncsp_koo.english
endif
if ncsp_en.text=' '
  replace ncsp_en.text with ncsp_koo.text_2
endif
if ncsp_en.text=' '
  replace ncsp_en.text with ncsp_koo.text
endif
replace released with .f.
lc_find=.t.
do ..\englanti\simcheck
return
