Procedure apu_siir
select ncsp_koo
replace ALL released WITH .t.
set filter to not reldate<>CTOD(SPACE(9))
select 0
use tpl2008.dbf alias paiv
set order to tunniste
GOTO top
DO WHILE NOT EOF()
 IF voimassa='F'
   SKIP
   loop
 ENDIF
 IF LEN(TRIM(tunniste))=5
  select ncsp_koo
  seek TRIM(paiv.tunniste)
  if NOT found() 
    APPEND BLANK
    replace code WITH paiv.tunniste, text with paiv.pitk�_nimi, text_2 with paiv.l�ngt_namn,; 
    short WITH paiv.lyhenne, english WITH paiv.long_name, usedate WITH paiv.voimassaol,; 
    chadate WITH paiv.muutospvm
  ELSE
    replace released WITH .f.
    IF NOT (TRIM(text)=TRIM(paiv.pitk�_nimi) AND TRIM(paiv.pitk�_nimi)=TRIM(text))
      replace text WITH paiv.pitk�_nimi
    ENDIF
    IF NOT (TRIM(text_2)=TRIM(paiv.l�ngt_namn) AND TRIM(paiv.l�ngt_namn)=TRIM(text_2))
      replace text_2 WITH paiv.l�ngt_namn
    ENDIF
    IF paiv.long_name<>' '
      replace english WITH paiv.long_name
    ENDIF
    IF paiv.lyhenne<>' '
      replace short WITH paiv.lyhenne
    endif
  ENDIF
 endif
 SELECT paiv
 skip
ENDDO
SELECT ncsp_koo
SET FILTER TO released AND reldate=CTOD(SPACE(9))
replace ALL reldate WITH CTOD('2008/12/31') 
return
