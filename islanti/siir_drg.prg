procedure siir_drg
lc_nyear="0"
wait window nowait 'Select the version you need'
do ..\islanti\suodkay
set talk off
set safety off
wait window nowait 'The file is transferred to C:/data/ncps_ice.dbf file'
select ncsp_koo
set order to code
on error return
COPY TO c:\data\ncsp_ice.dbf for ncsp_koo.code<>' '
on error
SELECT 0 
USE c:\data\ncsp_ice.dbf
replace ALL text WITH 'Deleted '+DTOC(reldate)+'-'+text FOR reldate<>CTOD(SPACE(8))
goto top
lc_apucode=SPACE(6)
DO WHILE NOT EOF()
  IF reldate=CTOD(SPACE(8))
    IF EOF()
      EXIT 
    ENDIF
    lc_apucode=code 
    skip
    LOOP 
  endif
  IF code=lc_apucode
    DELETE 
  ENDIF 
  lc_apucode=code
  SKIP 
ENDDO 
pack
set safety on
do _ncsp
return
