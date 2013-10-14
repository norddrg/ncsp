procedure koodets
define window koodi from 5,5 to 15,30 font  max_foty,  max_fosi
activate window koodi
ke_koodi=space(6)
@ 2,1 say 'Anna etsittävä koodi'
@ 3,5 get ke_koodi picture '!!!!!!' font 'Courier New', 8
read
release window koodi
if lastkey()=27
  return
endif
ke_koodi=upper(ke_koodi)
do etsi with ke_koodi
lc_f=.f.
if len(trim(ke_koodi))>4
  select ncsp_koo
  if code=trim(ke_koodi) 
    lc_f=.t.
  endif
endif
if len(trim(ke_koodi))>2 and not lc_f
  select ncsp_ala
  if code=substr(ke_koodi,1,3) 
    lc_f=.t.
  endif
endif
if len(trim(ke_koodi))>1 and not lc_f
  select ncsp_ryh
  if code=substr(ke_koodi,1,2) 
    lc_f=.t.
  endif
endif
if not lc_f
  select ncsp_luv
endif
do naytto
return
