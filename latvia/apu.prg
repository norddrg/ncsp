PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_ice<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_ice)
  IF FOUND()
    replace text WITH uusi.icelandic,; 
    chadate WITH uusi.cha_ice, usedate WITH uusi.use_ice, reldate WITH uusi.rel_ice
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_ice, ncsp WITH uusi.ord
    replace text WITH uusi.icelandic,; 
    chadate WITH uusi.cha_ice, usedate WITH uusi.use_ice, reldate WITH uusi.rel_ice
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
