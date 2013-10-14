Procedure apu_imp
select 0
USE F:\luokitukset\ncsp\norja\csp_2014_nor.dbf EXCLUSIVE alias new		
select ncsp_koo
set filter to not released
replace all released with .t.
set filter to reldate=ctod(space(8)) OR reldate>DATE()-365
select new
goto top
do while not eof()
  select ncsp_koo
  seek trim(new.c1)
  if found()
    replace released with .f.
    if trim(text)<>trim(new.c2)
       replace text with new.c2
       replace chadate with date()
    endif
    replace reldate WITH CTOD(SPACE(9))
    replace subst WITH ' '
  else
    append blank
    replace code with new.c1
    replace text with new.c2
    replace usedate with ctod('2014/01/01')
    replace chadate with date()
    replace released with .f.
  endif
  select new
  skip
enddo
select ncsp_koo
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2013/12/31')
return