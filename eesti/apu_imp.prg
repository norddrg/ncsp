Procedure apu_imp
SELECT 0
USE "f:\luokitukset\ncsp\eesti\ncsp_est_2014.dbf" EXCLUSIVE alias new		
select ncsp_koo
set filter to not released
replace all released with .t.
set filter to reldate=ctod(space(8)) OR reldate>DATE()-365
select new
goto top
do while not eof()
  select ncsp_koo
  seek trim(new.kood)
  if found()
    replace released with .f.
    if (trim(LOWER(text))<>trim(LOWER(new.nimetus_ee))or TRIM(LOWER(new.nimetus_ee))<>TRIM(LOWER(text))) AND LEN(TRIM(new.nimetus_ee))>0
       replace text with new.nimetus_ee
       replace chadate with date()
    ENDIF
*    IF TRIM(english)<>TRIM(new.nimetus_in) OR TRIM(new.nimetus_in)<>TRIM(english)
*      replace english WITH new.nimetus_in
*    endif
    replace reldate WITH CTOD(SPACE(9))
    replace subst WITH ' '
  else
    append blank
    replace code with new.kood
    replace text with new.nimetus_ee
    replace english WITH new.nimetus_in
    replace usedate with ctod('2014/01/01')
    replace chadate with date()
    replace released with .f.
  ENDIF
  IF text=' '
    replace text WITH english
  endif
  select new
  skip
enddo
select ncsp_koo
SEEK '  '
IF FOUND()
  replace released WITH .f.
endif
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2013/12/31')
SELECT new
use
return