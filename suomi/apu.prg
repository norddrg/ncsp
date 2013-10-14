PROCEDURE apu
SELECT uusi
SET FILTER TO c6<>' ' AND code_fin<>' '
GOTO top
DO WHILE NOT EOF()
  SELECT ncsp_koo
  SEEK TRIM(uusi.code_fin)
  IF FOUND()
    replace text WITH uusi.finish, text_2 WITH uusi.fin_swe,; 
    chadate WITH uusi.cha_fin, usedate WITH uusi.use_fin, reldate WITH uusi.rel_fin
  ELSE
    APPEND BLANK
    replace code WITH uusi.code_fin, ncsp WITH uusi.ncps
    replace text WITH uusi.finnish, text_2 WITH uusi.fin_swe,; 
    chadate WITH uusi.cha_fin, usedate WITH uusi.use_fin, reldate WITH uusi.rel_fin
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
