Procedure apuluku
select ncsp_koo
set filter to not released
delete all
select uusi
goto top
do while not eof()
  select ncsp_koo
  seek trim(uusi.c1)
  if found()
    recall
  endif
  if not found() 
     append blank
     replace released with .f., code with uusi.c1, text with uusi.c2, chadate with date(), usedate with  ctod('2006/01/01')
  endif
  if ncsp_koo.text <> trim(uusi.c2)
    replace short with text
    replace text with uusi.c2
  endif
  select uusi
  skip
enddo
select ncsp_koo
set filter to deleted ()
replace all released with .t., reldate with ctod('2005/12/31')
recall all
return
