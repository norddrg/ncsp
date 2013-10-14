procedure apu_päiv
select ncsp_koo
SET FILTER TO  
replace all released with .t.
SELECT ncsp_luv
SET FILTER TO 
replace all released with .t. 
SELECT ncsp_ryh
SET FILTER TO 
replace all released with .t. 
SELECT ncsp_ala
SET FILTER TO 
replace all released with .t. 
SELECT 0
USE csp_2014 ALIAS uusi
*SET ORDER TO CODE   && CODE
goto top
do while not eof()
  DO CASE 
    CASE LEN(TRIM(code))<3
      SELECT ncsp_luv
    CASE LEN(TRIM(code))=3
      SELECT ncsp_ryh
    CASE LEN(TRIM(code))=4
      SELECT ncsp_ala
      seek TRIM(uusi.code)
      if found()
        replace released with .f., text WITH uusi.text, reldate WITH CTOD(SPACE(9))
      else
         append blank
         replace code with uusi.code, text with uusi.text, chadate with DATE(), usedate with ctod('2014/01/01')
      ENDIF
      SELECT uusi
      lc_code=TRIM(code)
      SKIP 
      IF code=lc_code
        SKIP -1
        SELECT ncsp_ala
      ELSE 
        SKIP -1
        SELECT ncsp_koo
      ENDIF 
      
    CASE LEN(TRIM(code))=5
      lc_code=TRIM(code)
      SKIP 
      IF code=lc_code
        SKIP -1
        SELECT ncsp_ala
      ELSE 
        SKIP -1
        SELECT ncsp_koo
      ENDIF 
    OTHERWISE 
      SELECT ncsp_koo
  ENDCASE 
  seek TRIM(uusi.code)
  if found()
    replace released with .f., text WITH uusi.text, reldate WITH CTOD(SPACE(9))
  else
    append blank
    replace code with uusi.code, text with uusi.text, chadate with DATE(), usedate with ctod('2014/01/01')
  endif
  select uusi
  skip
ENDDO
SELECT ncsp_koo
SET FILTER TO released AND reldate=CTOD(SPACE(8))
replace ALL reldate WITH CTOD('2013/12/31')
SELECT ncsp_ala
SET FILTER TO released AND reldate=CTOD(SPACE(8))
replace ALL reldate WITH CTOD('2013/12/31')
SELECT ncsp_ryh
SET FILTER TO released AND reldate=CTOD(SPACE(8))
replace ALL reldate WITH CTOD('2013/12/31')
SELECT ncsp_luv
SET FILTER TO released AND reldate=CTOD(SPACE(8))
replace ALL reldate WITH CTOD('2013/12/31')
SELECT uusi
use
return