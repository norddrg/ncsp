Procedure ncspupda
set near on
set date ymd
select ncsp_koo
replace all released with .t.
select ncsp_luv
replace all released with .t.
select ncsp_ryh
replace all released with .t.
select ncsp_ala
replace all released with .t.
set order to code
select 0
use ? alias ncsp
goto top
do while not eof()
  wait window nowait ncsp.code
  do case
  case len(trim(code))<=2
     do ncsp_luv
  case len(trim(code))=3
    do ncsp_ryh
  case len(trim(code))=4
    do ncsp_ala
  otherwise
    do ncsp_koo
  endcase
  select ncsp
  skip
enddo
select ncsp_koo
replace all reldate with ctod(str(year(date()),4,0)+'/12/31') for released
return

procedure ncsp_koo
  select ncsp_koo
  set order to code
  set filter to  not deleted()
  seek trim(ncsp.code)
  if found() 
    replace code with ncsp.code
    replace text with ncsp.text
    replace released with .f.
  else
    if lastkey()=23 or ncsp.code='K'
      select ncsp
      browse window ryhmat fields code, text nowait save nomodify
      select ncsp_koo
      set order to code
      set filter to 
      seek trim(ncsp.code)
      wait window nowait 'Select a code to be substituted - [Ctrl][W], insert a new code - [Esc]'
      browse window koodit fields ncsp_koo.code, ncsp_koo.released:2:r, ncsp_koo.ncsp:2, suod.suod:2, ; 
      ncsp_koo.text:50, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ncsp_koo.reldate:6:r, ncsp_koo.subst:7; 
      save nomodify 
    endif
    if lastkey()=23
      replace released with .t., reldate with ctod('2000/12/31')
      lc_ncsp=ncsp
      append blank
      replace text with ncsp.text, code with ncsp.code, chadate with date(),;
      usedate with ctod('2001/01/01'), ncsp with lc_ncsp
    else
      append blank 
      replace code with ncsp.code, text with ncsp.text,;
      released with .f., chadate with date(), usedate with ctod('2001/01/01')
    endif
  endif
return

procedure ncsp_ala
  select ncsp_ala
  set order to code
  set filter to  not deleted()
  seek trim(ncsp.code)
  if found() 
    replace code with ncsp.code
    replace text with ncsp.text
    replace released with .f.
  else
    if lastkey()=23 or ncsp.code='K'
      select ncsp
      browse window ryhmat fields code, text nowait save nomodify
      select ncsp_ala
      set order to code
      set filter to 
      seek trim(ncsp.code)
      wait window nowait 'Select a code to be substituted - [Ctrl][W], insert a new code - [Esc]'
      browse window koodit fields ncsp_ala.code, ncsp_ala.released:2:r, suod.suod:2, ; 
      ncsp_ala.text:50, ncsp_ala.chadate:6 :r, ncsp_ala.usedate:6:r, ncsp_ala.reldate:6:r; 
      save nomodify 
    endif
    if lastkey()=23
      replace released with .t., reldate with ctod('2000/12/31')
      lc_ncsp=ncsp
      append blank
      replace text with ncsp.text, code with ncsp.code, chadate with date(),;
      usedate with ctod('2001/01/01'), ncsp with lc_ncsp
    else
      append blank 
      replace code with ncsp.code, text with ncsp.text,;
      released with .f., chadate with date(), usedate with ctod('2001/01/01')
    endif
  endif
return

procedure ncsp_ryh
  select ncsp_ryh
  set order to code
  set filter to  not deleted()
  seek trim(ncsp.code)
  if found() 
    replace code with ncsp.code
    replace text with ncsp.text
    replace released with .f.
  else
    if lastkey()=23 or ncsp.code='K'
      select ncsp
      browse window ryhmat fields code, text nowait save nomodify
      select ncsp_ryh
      set order to code
      set filter to 
      seek trim(ncsp.code)
      wait window nowait 'Select a code to be substituted - [Ctrl][W], insert a new code - [Esc]'
      browse window koodit fields ncsp_ryh.code, ncsp_ryh.released:2:r, suod.suod:2, ; 
      ncsp_ryh.text:50, ncsp_ryh.chadate:6 :r, ncsp_ryh.usedate:6:r, ncsp_ryh.reldate:6:r; 
      save nomodify 
    endif
    if lastkey()=23
      replace released with .t., reldate with ctod('2000/12/31')
      lc_ncsp=ncsp
      append blank
      replace text with ncsp.text, code with ncsp.code, chadate with date(),;
      usedate with ctod('2001/01/01')
    else
      append blank 
      replace code with ncsp.code, text with ncsp.text,;
      released with .f., chadate with date(), usedate with ctod('2001/01/01')
    endif
  endif
return

procedure ncsp_luv
  select ncsp_luv
  set order to code
  set filter to  not deleted()
  seek trim(ncsp.code)
  if found() 
    replace code with ncsp.code
    replace text with ncsp.text
    replace released with .f.
  else
    if lastkey()=23 or ncsp.code='K'
      select ncsp
      browse window ryhmat fields code, text nowait save nomodify
      select ncsp_luv
      set order to code
      set filter to 
      seek trim(ncsp.code)
      wait window nowait 'Select a code to be substituted - [Ctrl][W], insert a new code - [Esc]'
      browse window koodit fields ncsp_luv.code, ncsp_luv.released:2:r, suod.suod:2, ; 
      ncsp_luv.text:50, ncsp_luv.chadate:6 :r, ncsp_luv.usedate:6:r, ncsp_luv.reldate:6:r; 
      save nomodify 
    endif
    if lastkey()=23
      replace released with .t., reldate with ncsp.fradto
      lc_ncsp=ncsp
      append blank
      replace text with ncsp.text, code with ncsp.code, chadate with date(),;
      usedate with ctod('2001/01/01')
    else
      append blank 
      replace code with ncsp.code, text with ncsp.text,;
      released with .f., chadate with date(), usedate with ctod('2001/01/01')
    endif
  endif
return
