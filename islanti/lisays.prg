procedure lisays
  lc_alias=alias()
  set filter to
  lc_koodi=code
  lc_ncsp=ncsp
  append blank
  replace code with lc_koodi
  replace chadate with date()
  replace ncsp with lc_ncsp
  replace usedate with ctod(str(year(date())+1,4)+'/01/01')
  replace released with .f.
  edit
  select (lc_alias)
  do naytto
  return
