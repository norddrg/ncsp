PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_eng<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_eng)
  IF FOUND()
    replace text WITH uusi.english,; 
    chadate WITH uusi.cha_eng, usedate WITH uusi.use_eng, reldate WITH uusi.rel_eng
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_eng, ncsp WITH uusi.ord
    replace text WITH uusi.english,; 
    chadate WITH uusi.cha_eng, usedate WITH uusi.use_eng, reldate WITH uusi.rel_eng
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
