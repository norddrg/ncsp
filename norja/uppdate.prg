Procedure Uppdate
select ncsp_koo
set order to code
delete all for not released
select 0
use ncsp_ncmp.dbf alias uusi
goto top
do while not eof()
  select ncsp_koo
  seek trim(uusi.code)
  if found()
    recall
    if trim(uusi.text)<>trim(ncsp_koo.text) or trim(ncsp_koo.text) <> trim(uusi.text)
      replace released with .t., reldate with ctod('2004/12/31')
      lc_ncsp=ncsp_koo.ncsp
      append blank
      replace ncsp_koo.text with uusi.text, ncsp_koo.code with uusi.code, ncsp_koo.chadate with date(),;
      ncsp_koo.usedate with ctod('2005/01/01'), ncsp_koo.released with .f., ncsp_koo.ncsp with lc_ncsp
    endif
  else
    append blank
    replace ncsp_koo.text with uusi.text, ncsp_koo.code with uusi.code, ncsp_koo.chadate with date(),;
    ncsp_koo.usedate with ctod('2005/01/01'), ncsp_koo.released with .f.
  endif
  select uusi
  skip
enddo
select uusi 
use
select ncsp_koo 
replace all released with .t. for deleted()
replace all reldate with ctod('2005/12/31') for deleted()
recall all
return