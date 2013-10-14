*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\SIIRMUUN.PRG
*:
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:
*: Documented using Visual FoxPro Formatting wizard version  .05
*:******************************************************************************
*:   siirmuun
*!******************************************************************************
*!
*! Procedure SIIRMUUN
*!
*!  Calls
*!      deleted
*!      eof
*!      found
*!      len
*!      ncsp
*!      space
*!      substr
*!      to
*!      trim
*!      values
*!
*!******************************************************************************
procedure persiir
  set talk off
  set console off
  select ncsp_koo
  set order to code_ncbrowse
  select 0
  use siirstr.dbf
  set safety off
  on error return
  copy to c:\data\ncsp_fin
  on error
  wait window nowait 'The file is transferred to C:/data/ncps_eng.dbf file'
  set safety on
  select ncsp_koo
  set filter to ncsp and not deleted()
  goto top
  do while not eof()
    insert into c:\data\ncsp_eng (code, text, usedate, chadate, reldate, released, code_d, code_f, code_s, code_n);
    values (ncsp_koo.code_nc, ncsp_koo.english, ncsp_koo.usedate, ncsp_koo.chadate,;
    ncsp_koo.reldate, ncsp_koo.released, ncsp_koo.code_d, ncsp_koo.code_f,;
    ncsp_koo.code_s, ncsp_koo.code_n)
    select ncsp_koo
    skip
  enddo
  select ncsp_eng
  use
  select ncsp_koo
  goto top
  do ..\ruotsi\_ncsp
  return