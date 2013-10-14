procedure ncsp
if max_x<60 or max_y<23
    wait window 'Too small window, start again!'
    return
endif
public p_poist
p_poist=.t.
public p_date
p_date=date()
set date to ymd
set century on
clear
close databases
select 1
close databases
set talk off
set near on
public  luv_y, luv_x, ryh_y, ala_y, pub_code, kieli, laji, aktfilt, suodatin, lc_rel
lc_loop=.t.
kieli='E'
laji='A'
suodatin=.f.
luv_y=int(max_y/5)
if luv_y<6
  luv_y=6
endif
ryh_y=2*luv_y
ala_y=3*luv_y
luv_x=int(0.75*max_x)
*
define window valikko from 0,0 to max_y,luv_x-3 font  max_foty,  max_fosi
define window luvut from 0,3 to luv_y,luv_x font  max_foty,  max_fosi
define window ryhmat from luv_y,3 to ryh_y,luv_x font  max_foty,  max_fosi
define window alaryh from ryh_y,3 to ala_y,luv_x font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi
*
define popup suodval from 5,5 font  max_foty,  max_fosi prompt files like s_*.dbf
on selection popup suodval do suodval with prompt()
wait window nowait 'Select filter file! New filter file - [Esc]'
activate popup suodval
release popup suodval
if lastkey()=27
  lc_val=space(8)
define window koodi from 5,5 to 30,30 font  max_foty,  max_fosi
activate window koodi
ke_koodi=space(7)
@ 2,1 say 'give the name of the new filter file! Cancel - [Esc]'
@ 4,5 get lc_val picture 'S_XXX'
read
if lastkey()=27
  clear all
  wait window 'You have to select a filter file!'
  do _ncsp
  return
endif
select 0
use s_str.str
lc_val='\data\icd_10\'+lc_val
copy next 1 to (lc_val) with cdx
use
aktfilt=substr(lc_val,rat('_',lc_val)+1,rat('.', lc_val)-rat('_',lc_val)-1)
select 0
use (lc_val) alias suod
set filter to not deleted() and suod
set order to koodi
endif
*
select 0
use ..\gemens\tmp noupdate
set order to code
*
select 0
use ..\gemens\ncsp_luv.dbf exclusive
set order to ncsp
SET SAFETY OFF 
COPY TO ..\text\ncsp_luv.txt SDF
SET SAFETY ON 
*
select 0
use ..\gemens\ncsp_ryh.dbf
set order to ncsp
SET SAFETY OFF 
COPY TO ..\text\ncsp_ryh.txt SDF
SET SAFETY ON 
*
select 0 
use ..\gemens\ncsp_ala.dbf
set order to ncsp
SET SAFETY OFF 
COPY TO ..\text\ncsp_ala.txt SDF
SET SAFETY ON 
*
select 0
use ..\gemens\ncsp_koo.dbf
set order to ncsp
SET safety OFF 
COPY TO ..\text\com_ncsp_koo.txt SDF
SET SAFETY ON 
seek p_ncsp
*
do ..\gemens\lang_def
*
do ..\gemens\ncspohje
*
do ..\gemens\suodkay
return
*
  procedure suodval
    parameter lc_val
    aktfilt=substr(lc_val,rat('_',lc_val)+1,rat('.', lc_val)-rat('_',lc_val)-1)
    select 0
    use (lc_val) alias suod
    set order to code
    deactivate popup suodval
    return
