Procedure ncmp_imp
select ncsp_koo
set filter to 
select ncmp_2007
goto top
do while not eof()
  select ncsp_koo
  seek trim(ncmp_2007.code)
  if found()
    replace released with .f.
    replace reldate with ctod(space(8))
    if trim(text)<>trim(ncmp_2007.text)
       replace text with ncmp_2007.text
       replace chadate with date()
    endif
  else
    append blank
    replace code with ncmp_2007.code
    replace text with ncmp_2007.text
    replace usedate with ctod('2007/01/01')
  endif
  select ncmp_2007
  skip
enddo
select ncmp_2007
use
return