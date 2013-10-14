procedure siirmuun
  set talk off
  set console off
  do valyear
  select ncsp_koo
  set order to ncsp
  select 0
  use siirstr.dbf
  set safety off
  on error return
  copy to c:\data\ncsp_com
  on error
  wait window nowait 'The file is beeing transferred to C:/data/ncsp_com.dbf file'
  set safety on
  select ncsp_koo
  set filter to ncsp<>' ' and (usedate<=p_date+100 and (reldate>=p_date-(VAL(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  goto top
  do while not eof()
    insert into c:\data\ncsp_com (code, text, usedate, chadate,;
    reldate, code_den, code_fin, code_swe, code_nor, code_est, code_lat, code_eng);
    values (ncsp_koo.ncsp, ncsp_koo.text, ncsp_koo.usedate, ncsp_koo.chadate,;
    ncsp_koo.reldate, ncsp_koo.code_den, ncsp_koo.code_fin,;
    ncsp_koo.code_swe, ncsp_koo.code_nor, ncsp_koo.code_est, ncsp_koo.code_lat, ncsp_koo.code_eng)
    IF reldate<>CTOD(SPACE(8))
      replace ncsp_com.text WITH 'Deleted '+DTOC(reldate)+' - '+text
    ENDIF 
    select ncsp_koo
    skip
  enddo
  select ncsp_com
  use
  select ncsp_koo
  goto top
  set filter to ncsp<>' ' and (usedate<=p_date+100 and reldate>=p_date-365)
  copy to c:\data\rel_com.dbf
  select ncsp_luv
  set filter to ncsp<>' ' and (usedate<=p_date+100 and (reldate>=p_date-(VAL(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  copy all to C:\data\com_luv.dbf fields ncsp, text
  select ncsp_ryh
  set filter to ncsp<>' ' and (usedate<=p_date+100 and (reldate>=p_date-(VAL(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  copy all to C:\data\com_ryh.dbf fields ncsp, text  
  select ncsp_ala
  set filter to ncsp<>' ' and (usedate<=p_date+100 and (reldate>=p_date-(VAL(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  copy all to C:\data\com_ala.dbf fields ncsp, text
  do ..\gemens\_ncsp
  return
