PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_nor<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_nor)
  IF FOUND()
    replace text WITH uusi.norwegian,; 
    chadate WITH uusi.cha_nor, usedate WITH uusi.use_nor, reldate WITH uusi.rel_nor
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_nor, ncsp WITH uusi.ord
    replace text WITH uusi.norwegian,; 
    chadate WITH uusi.cha_nor, usedate WITH uusi.use_nor, reldate WITH uusi.rel_nor
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
