Procedure apu2
select ncsp_koo
set filter to not released
select ncmp_dbf
got top
do while not eof()
  if kv_)='  '
    skip
    loop
  endif
  select g
  seek trim(ncmp_dbf.kode)
  if found()
    select ncsp_koo
    seek trim(ncsp_koo.code_swe)
    if found()
      select ncsp_koo
      replace ncsp with ncsp_koo.ncsp
    endif
  select ncmp_dbf
  skip
enddo
return