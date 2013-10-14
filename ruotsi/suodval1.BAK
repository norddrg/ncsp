Procedure suodval1
select ncsp_koo
set relation to
set filter to
suodatin=.f.
define popup suodval from 5,5 font  max_foty,  max_fosi prompt files like s_*.dbf
on selection popup suodval do suodval with prompt()
wait window nowait 'Valitse suodatintiedosto! Uuden tiedoston perustaminen [Esc]'
activate popup suodval
release popup suodval
if lastkey()=27
  lc_val=space(8)
  define window koodi from 5,5 to 30,30 font  max_foty,  max_fosi
  activate window koodi
  ke_koodi=space(7)
  @ 2,1 say 'Anna uuden suodattimen nimi! Peruutus [Esc]'
  @ 4,5 get lc_val picture 'S_XXX'
  read
  if lastkey()=27
    wait window 'Jatkan entisellä suodatintiedostolla!'
    return
  endif
  select suod
  use s_str.str
  lc_val='\data\icd_10\'+lc_val
  copy next 1 to (lc_val) with cdx
  use
  aktfilt=upper(substr(lc_val,rat('_',lc_val)+1,rat('.', lc_val)-rat('_',lc_val)-1))
  select 0
  use (lc_val) alias suod
  set filter to not deleted() and suod
  set order to koodi
endif
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'Ncsp-'+aktfilt
select suod
seek ncsp_koo.code
select ncsp_koo
set relation to code into suod
do naytto
return