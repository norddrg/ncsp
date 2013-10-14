Procedure apu_ncmp
select ncsp_koo
set order to code
set filter to not released
select ncmp
goto top
do while not eof()
  if kode=' '
    skip
    loop
  endif
  if ncsp_nor<>' '
    select ncsp_koo
    seek ncmp.ncsp_nor
    if found()
      replace released with .t., reldate with ctod('2006/12/31'), subst with ncmp.kode
    endif
    select ncmp
    replace ncsp with ncsp_koo.ncsp
  endif
  select ncsp_koo
  append blank
  replace  code with ncmp.kode, text with ncmp.text, note with ncmp.kommentar, ncsp with ncmp.ncsp
  select ncmp
  skip
  loop
enddo
return