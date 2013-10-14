procedure lisays
  lc_alias=alias()
  set filter to
  on key label alt+b
  if month(date())<11
    jan1=ctod(str(val(substr(dtoc(date()),1,4))+1,4)+'/01/01')
  else
    jan1=ctod(str(val(substr(dtoc(date()),1,4))+2,4)+'/01/01')
  endif
  dec31 = jan1-1
  lc_koodi=ncsp
  lc_text=text
  wait window nowait 'Accept [Ctrl][W], reject [Esc]'
  append blank
  replace ncsp with lc_koodi
  replace chadate with date()
  replace usedate with jan1
  replace released with .f.
  if lc_alias='NCSP_KOO'
    replace ncsp with lc_koodi
    replace text with lc_text
    edit next 1
    if lastkey()=27
       replace usedate with date(), reldate with date()-1
       delete
       return
    endif
    do while text=lc_text
      wait window nowait 'You have to change the text'
      edit fields text next 1
    enddo
    replace code with ncsp
  else
    replace text with lc_text
    replace ncsp with lc_koodi
    edit fields ncsp, text, usedate, short next 1
    if lastkey()=27
       replace usedate with date(), reldate with date()-1
       delete
       return
    endif
    do while text=lc_text
      wait window nowait 'You have to change the text'
      edit fields text next 1
    enddo
  endif
  do while ncsp=lc_koodi
    wait window nowait 'You have to change the code'
    edit fields ncsp next 1
    if lc_alias='NCSP_KOO'
      replace code with ncsp
    endif
  enddo
  select (lc_alias)
  do ..\gemens\naytto
  on key label alt+b do lisays
return
