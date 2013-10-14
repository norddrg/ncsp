*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\NCSP.PRG
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
*:   ncsp
*!******************************************************************************
*!
*! Procedure NCSP
*!
*!  Calls
*!      deleted
*!      int
*!      lastkey
*!      prompt
*!      rat
*!      space
*!      substr
*!      to
*!
*!******************************************************************************
procedure ncsp
  if max_x<60 or max_y<23
    wait window 'Liian pieni ikkuna, aloita uudestaan!'
    return
  endif
  close all
  public p_poist
  p_poist=.t.
  public p_date
  p_date=date()
  set date to ymd
  set century on
  clear
  close databases
  set talk off
  set near on
  public  luv_y, luv_x, ryh_y, ala_y, kieli, laji, aktfilt, suodatin
  kieli='E'
  lc_loop=.t.
  laji='A'
  suodatin=.f.
lc_alias=alias()
PUBLIC lc_nyear

select 0
use tmp noupdate
set order to code

select 0
use ncsp_luv.dbf exclusive
set order to code

select 0
use ncsp_ryh.dbf
set order to code

select 0
use ncsp_ala.dbf
set order to code

select 0
use ncsp_koo.dbf
set order to code

SET SAFETY OFF 
SELECT ncsp_luv
COPY TO ..\text\isl_ncsp_luv.txt SDF 
SELECT ncsp_ryh
COPY TO ..\text\isl_ncsp_ryh.txt SDF 
SELECT ncsp_ala
COPY TO ..\text\isl_ncsp_ala.txt SDF 
SELECT ncsp_koo
COPY TO ..\text\isl_ncsp_koo.txt SDF 
SET SAFETY ON 


define popup suodval from 5,5 font  max_foty,  max_fosi prompt files like s_*.dbf
on selection popup suodval do ..\islanti\suodval with prompt()
wait window nowait 'Valitse suodatin tiedosto! Uuden tiedoston perustaminen [Esc]'
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
    clear all
    wait window 'Joku suodatin on pakko valita!'
    do ..\islanti\_ncsp
    return
  endif
  select 0
  use s_str.str
  lc_val='..\suomi\'+lc_val
	  copy next 0 to (lc_val) with cdx
	  use
  aktfilt=substr(lc_val,rat('_',lc_val)+1,rat('.', lc_val)-rat('_',lc_val)-1)
  select 0
  use (lc_val) alias suod
  set filter to not deleted() and suod
  set order to code
endif
select suod
goto top
do while not eof()
  select ncsp_koo
  seek suod.code
  if not found() 
    select suod
    delete
    replace suod with .f.
  endif
  select suod
  skip
enddo
pack
select ncsp_koo
set relation to trim(code) into suod

luv_y=int(max_y/5)
if luv_y<6
  luv_y=6
endif
ryh_y=2*luv_y
ala_y=3*luv_y
luv_x=int(0.6*max_x)

define window valikko from 0,0 to max_y,luv_x-3 font  max_foty,  max_fosi
define window luvut from 0,3 to luv_y,luv_x font  max_foty,  max_fosi
define window ryhmat from luv_y,3 to ryh_y,luv_x font  max_foty,  max_fosi
define window  alaryh from ryh_y,3 to ala_y,luv_x font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'Ncsp-'+aktfilt

select ncsp_koo
set order to ncsp
SET SAFETY OFF 
COPY TO ncsp_ice.sdf TYPE SDF
SET SAFETY ON
seek trim(p_ncsp)
set order to code
do ..\islanti\ohje

do ..\islanti\naytto
return
