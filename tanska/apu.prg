PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_den<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_den)
  IF FOUND()
    replace text WITH uusi.danish, ncsp WITH uusi.ord; 
    chadate WITH uusi.cha_dan, usedate WITH uusi.use_dan, reldate WITH uusi.rel_dan
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_den, ncsp WITH uusi.ncps
    replace text WITH uusi.danish,; 
    chadate WITH uusi.cha_dan, usedate WITH uusi.use_dan, reldate WITH uusi.rel_dan
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
