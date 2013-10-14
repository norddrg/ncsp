procedure apu_paiv
clear all
set date ('YMD')
use ncsp_koo
set order to code
replace all released with .t.
select 0
use lat_2013 alias uusi
goto top
do while not eof()
  select ncsp_koo
  seek TRIM(uusi.code)
  if found()
    if trim(uusi.text)<>trim(ncsp_koo.text) OR TRIM(ncsp_koo.text)<>TRIM(uusi.text)
      replace text with uusi.text
    endif
    replace released with .f.
  else
    append blank
    replace usedate with ctod('13/01/01'), code with uusi.code, text with uusi.text, released WITH .f.
  endif
  select uusi
  skip
ENDDO
SELECT ncsp_koo
SEEK '  '
IF FOUND()
  replace released WITH .f.
endif
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('11/12/31')
return