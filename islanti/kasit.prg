procedure kasit
lc_alias=alias()
if alias()='SUOD' or alias()='NCSP_KOO'
  lc_alias='NCSP_KOO'
  lc_code=ncsp_koo.code
  lc_ncsp=ncsp_koo.ncsp
  select suod
  set order to code
  set relation to
  select ncsp_koo
  set relation to 
  select suod
  SET FILTER TO NOT DELETED()
  seek trim(lc_code)
  if not found()
    append blank
    replace code with lc_code, suod with .f.
  endif
  select ncsp_koo
  set order to ncsp
  seek lc_ncsp
  do while code<>lc_code and ncsp=lc_ncsp and not eof() 
    skip
  enddo
  edit next 1 fields  suod.suod, usedate, reldate, subst, released, chadate, code, text, text_2, short, english, suod.old, suod.price, ncsp, note, note_2
  do while code=' '
    wait window 'CODE hast to have a value!'
    edit next 1 fields  suod.suod, usedate, reldate, subst, released, chadate, code, text, text_2, short, english, suod.old, suod.price, ncsp, note, note_2
  enddo
  if code<>lc_code
    replace suod.code with ncsp_koo.code
  endif
  select ncsp_koo
  set filter to
  set relation to substr(code,1,1)+trim(substr(code,2,6)) into suod
  if released and reldate<=date() and reldate<>ctod(space(8))
    replace suod.suod with .f.
  endif
else
  edit next 1
endif
wait window 'Did you change the information? Y/N'
select (lc_alias)
if lastkey()=121 or lastkey()=89
  replace ncsp_koo.chadate with date()
endif
if ncsp_koo.usedate=ctod(space(8))
  replace ncsp_koo.usedate with ctod(str(year(chadate)+1,4)+'/01/01')
endif
if ncsp_koo.released
  if ncsp_koo.reldate=ctod(space(8))
    replace ncsp_koo.reldate with ctod(str(year(date()),4)+'/12/31')
  endif
else
  replace ncsp_koo.reldate with ctod(space(8))
endif
if ncsp_koo.reldate < ncsp_koo.usedate and ncsp_koo.reldate<>ctod(space(8))
  delete in ncsp_koo
endif
select (lc_alias)
if suodatin
  set filter to suod.suod
endif
do naytto
return
