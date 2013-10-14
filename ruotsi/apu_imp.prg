Procedure apu_imp
select 0
use "csp 2013 swe.dbf" alias kva
select ncsp_koo
set filter to not released
replace all released with .t. for not substr(code,1,2)<'A'
set filter to reldate=ctod(space(8))
select kva
SET FILTER TO NOT change='3'
goto top
do while not eof()
  select ncsp_koo
  seek trim(kva.kod)
  if found()
    replace released with .f.
    if trim(text)<>trim(kva.text) OR TRIM(kva.text)<>TRIM(text)
       replace text with kva.text
       replace chadate with date()
    endif
  else
    append blank
    replace code with kva.kod
    replace text with kva.text
    replace usedate with ctod('2013/01/01')
    REPLACE chadate WITH DATE()    
  endif
*  if len(trim(kva.beskrivnin))>0 
*    replace note with kva.beskrivnin
*  endif
  select kva
  skip
enddo
select ncsp_koo
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2012/12/31')
return