Procedure apu2
select ncmp
goto top
do while not eof()
  if kva=' '
    skip
    loop
  endif
  select ncsp_koo
  seek ncmp.kva
  if found()
    if ncsp=' '
      select ncsp_en
      seek ncmp.kode
      if found()
        wait window trim(ncmp.text)+' vs. '+trim(ncsp_koo.text)
        if lastkey()=89 or lastkey()=121
          select ncsp_koo
          replace ncsp with ncsp_en.code
          select ncsp_en
          replace code_swe with ncsp_koo.code
        endif
      endif
    endif
  endif
  select ncmp
  skip
enddo
return