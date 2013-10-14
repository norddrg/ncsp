procedure import
select ncsp_luv
set filter to
replace all released with .t.
select ncsp_ryh
set filter to
replace all released with .t.
select ncsp_ala
set filter to
replace all released with .t.
select ncsp_koo
set filter to
replace all released with .t.
select 0
use ncsp_ice_2006.dbf alias uusi
goto top
do while not eof()
  if len(trim(code))=1
    select ncsp_luv
    seek trim(uusi.code)
    if found()
      replace text with uusi.text, text_2 with uusi.text2, released with .f.
    else 
      append blank
      replace code with uusi.code, text with uusi.text, text_2 with uusi.text2, released with .f., chadate with ctod('2005/21/31'), usedate with ctod ('2006/01/01')
    endif
  endif
  if len(trim(code))=2
    select ncsp_ryh
    seek trim(uusi.code)
    if found()
      replace text with uusi.text, text_2 with uusi.text2, released with .f.
    else 
      append blank
      replace code with uusi.code, text with uusi.text, text_2 with uusi.text2, released with .f., chadate with ctod('2005/21/31'), usedate with ctod ('2006/01/01')
    endif
  endif
  if len(trim(code))=3 or len(trim(code))=4
    select ncsp_ala
    seek trim(uusi.code)
    if found()
      replace text with uusi.text, text_2 with uusi.text2, released with .f.
    else 
      append blank
      replace code with uusi.code, text with uusi.text, text_2 with uusi.text2, released with .f., chadate with ctod('2005/21/31'), usedate with ctod ('2006/01/01')
    endif
  endif
  if len(trim(code))>4
    select ncsp_koo
    seek trim(uusi.code)
    if found()
      replace text with uusi.text, text_2 with uusi.text2, released with .f.
    else 
      append blank
      replace code with uusi.code, text with uusi.text, text_2 with uusi.text2, released with .f., chadate with ctod('2005/21/31'), usedate with ctod ('2006/01/01')
    endif
  endif
  select uusi
  skip
enddo
select ncsp_luv
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2005/12/31')
select ncsp_ryh
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2005/12/31')
select ncsp_ala
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2005/12/31')
select ncsp_koo
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2005/12/31')
return


