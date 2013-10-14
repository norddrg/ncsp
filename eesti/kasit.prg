*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\KASIT.PRG
*:
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:
*: Documented using Visual FoxPro Formatting wizard version  .05
*:******************************************************************************
*:   kasit
*!******************************************************************************
*!
*! Procedure KASIT
*!
*!  Calls
*!      alias
*!      ctod
*!      date
*!      found
*!      lastkey
*!      space
*!      str
*!      year
*!
*!******************************************************************************
procedure kasit
  lc_alias=alias()
  if alias()='SUOD' or alias()='NCSP_KOO'
    lc_code=ncsp_koo.code
    selec suod
    set order to code
    set relation to
    select ncsp_koo
    set relation to 
    select suod
    SET FILTER TO NOT DELETED()
    seek lc_code
    if not found()
      append blank
      replace code with lc_code, suod with .f.
    endif
    select ncsp_koo
    seek lc_code
    edit next 1 fields usedate, reldate, subst, released, chadate, code, text, text_2, short, english, suod.old, suod.price, ncsp, note, note_2, note_e, suod.suod
    if code<>lc_code
      set relation to
      select suod
      seek lc_code
      replace suod.code with ncsp_koo.code
    endif
    select ncsp_koo
    set filter to
    set relation to code into suod
    if released
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
    replace ncsp_koo.reldate with date()
  else
    replace ncsp_koo.reldate with ctod(space(8))
  endif
  if ncsp_koo.reldate < ncsp_koo.usedate and ncsp_koo.reldate<>ctod(space(8))
    delete in ncsp_koo
  endif
  select (lc_alias)
  if lc_alias='SUOD'
    set filter to suod
  endif
  do ..\eesti\naytto
  return
