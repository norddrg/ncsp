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
    select suod
    seek lc_code
    if not found()
      append blank
      replace code with lc_code, suod with .f.
    endif
    select ncsp_koo
    seek lc_code
    edit next 1 fields usedate, reldate, subst, released, chadate, code, text, text_2, short, english, oldcode, ncsp, note, note_2, note_e, suod.suod
  else
    edit next 1
  endif
  wait window 'Did you change the information? Y/N'
  select (lc_alias)
  if lastkey()=121 or lastkey()=89
    replace chadate with date()
  endif
  if usedate=ctod(space(8))
    replace usedate with ctod(str(year(chadate)+1,4)+'/01/01')
  endif
  if released
    replace reldate with date()
  else
    replace reldate with ctod(space(8))
  endif
  if reldate<usedate and reldate<>ctod(space(8))
    delete
  endif
  do ../tanska/naytto
  return
