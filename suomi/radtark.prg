Procedure radtark
select rad2008
replace all tpl with .f.
goto top
do while not eof()
  select tpl2008
  seek rad2008.tunniste
  if found()
    replace rad2008.tpl with .t.
  endif
  select rad2008
  skip
enddo
return
