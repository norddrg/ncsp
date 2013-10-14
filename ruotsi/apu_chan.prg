Procedure apu_chan
select 0
use csp2014_cha alias kva
select ncsp_koo
set filter to
select kva
goto top
do while not eof()
  select ncsp_koo
  seek trim(kva.code)
  if found()
    if trim(text)<>trim(kva.text)
       replace text with kva.text
       replace chadate with date()
    ENDIF
    IF kva.in_out='OUT'
       replace released WITH .t.
       replace reldate WITH CTOD('2013/12/31')
    ENDIF 
    IF kva.in_out='IN'
       IF released
         replace released WITH .f.
         replace reldate WITH CTOD(SPACE(8))
       ENDIF 
    ENDIF 
  ELSE 
    IF kva.in_out='IN'
      append blank
      replace code with kva.code
      replace text with kva.text
      replace usedate with CTOD('2014/01/01')
      replace released WITH .f.
      REPLACE chadate WITH DATE()    
    ENDIF 
  ENDIF 
*  if len(trim(kva.beskrivnin))>0 
*    replace note with kva.beskrivnin
*  endif
  select kva
  skip
enddo
select ncsp_koo
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2011/12/31')
return