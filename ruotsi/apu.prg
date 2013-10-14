PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_swe<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_swe)
  IF FOUND()
    replace text WITH uusi.swedish,; 
    chadate WITH uusi.cha_swe, usedate WITH uusi.use_swe, reldate WITH uusi.rel_swe
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_swe, ncsp WITH uusi.ord
    replace text WITH uusi.swedish,; 
    chadate WITH uusi.cha_swe, usedate WITH uusi.use_swe, reldate WITH uusi.rel_swe
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
