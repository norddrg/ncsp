PROCEDURE apu
SELECT ncsp_koo
SET FILTER TO 
DELETE all
SELECT uusi
SET FILTER TO c6<>' ' 
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  IF uusi.ncsp<>' '
    SEEK TRIM(uusi.ord)+'A'
  ELSE 
    SEEK TRIM(uusi.ord) +'B'+ SUBSTR(uusi.code_eng,1,6)+SUBSTR(uusi.code_den,1,7)+SUBSTR(uusi.code_swe,1,6)+SUBSTR(uusi.code_nor,1,7)+SUBSTR(uusi.code_fin,1,6)+DTOC(uusi.usedate)+DTOC(uusi.reldate)
  ENDIF 
  IF FOUND()
    RECALL 
    replace text WITH uusi.text,; 
    chadate WITH uusi.chadate, usedate WITH uusi.usedate, reldate WITH uusi.reldate,;
    code_eng WITH uusi.code_eng, code_den WITH uusi.code_den, code_swe WITH uusi.code_swe, code_nor WITH uusi.code_nor, code_fin WITH uusi.code_fin
  ELSE
    APPEND BLANK
    replace code WITH uusi.ord, ncsp WITH uusi.ncsp
    replace text WITH uusi.text,; 
    chadate WITH uusi.chadate, usedate WITH uusi.usedate, reldate WITH uusi.reldate,;
    code_eng WITH uusi.code_eng, code_den WITH uusi.code_den, code_swe WITH uusi.code_swe, code_nor WITH uusi.code_nor, code_fin WITH uusi.code_fin
  ENDIF 
  IF reldate<>CTOD('  /  /  ')
    replace released WITH .t.
  ELSE 
    replace released WITH .f.
  ENDIF 
  SELECT uusi
  SKIP 
ENDDO
RETURN
