Procedure simupda
select ncsp_koo
public su_code
su_code=code
close all
set near on
define window valikko from 1,1 to max_y/2,luv_x-3 font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'NCSP-Finnish'
define window codes from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'NCSP-Common version'
use ncsp_koo.dbf
set order to code
select 0
USE ..\gemens\ncsp_koo.dbf EXCLUSIVE alias ncsp_en
set order to code
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
set filter to not released and not deleted()
select ncsp_en
set order to code
set filter to not released
select ncsp_koo
seek su_code
public sim_code
sim_code=ncsp_koo.code
do ..\suomi\simcheck
return
