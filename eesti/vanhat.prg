*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\VANHAT.PRG
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
*:   vanhat
*!******************************************************************************
*!
*! Procedure VANHAT
*!
*!  Calls
*!      lastkey
*!      space
*!      substr
*!
*!******************************************************************************
procedure vanhat
define window vanhat from 0,luv_x to max_y,max_x font  max_foty,  max_fosi title 'NCSP-EN'
on key label f5
activate window vanhat
select ncsp_koo
lc_vanha=substr(vanha,1,4)
select tmp
if lc_vanha<>space(4)
  seek (lc_vanha)
endif
wait window '[Esc] = peruuutus, [Crtrl][W] = muuta vanha ' nowait
browse
if lastkey()<>23
  release window vanhat
  on key label f5 do vanhat
  return
endif
select ncsp_koo
replace vanha with tmp.code
release window vanhat
select ncsp_koo
do paiv
on key label f5 do vanhat
return
