procedure siir_drg
  set talk off
  set safety off
  wait window nowait 'The file is transferred to C:/data/ncps_com.dbf file'
  select ncsp_koo
  set order to code
  on error return
  COPY TO c:\data\ncsp_com.dbf FOR ncsp<>' '
  on error
  set safety on
  wait window 'The file is transferred to C:/data/ncps_com.dbf file'
  do ..\gemens\_ncsp
  return