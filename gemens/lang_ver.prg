Procedure lang_ver
select 0
use ..\muisti
replace muisti.ncsp with ncsp_koo.ncsp
do case
case p_kieli='F'
  set default to ..\suomi
  DO ..\suomi\_ncsp
case p_kieli='S'
  set default to ..\ruotsi
  DO ..\ruotsi\_ncsp
case p_kieli='D'
  set default to ..\tanska
  DO ..\tanska\_ncsp
case p_kieli='N'
  set default to ..\norja
  DO ..\norja\_ncsp
case p_kieli='Ice'
  set default to ..\islanti
  DO ..\islanti\_ncsp
case p_kieli='Est'
  set default to ..\eesti
  DO ..\eesti\_ncsp
case p_kieli='Eng'
  set default to ..\englanti
  DO ..\englanti\_ncsp
CASE p_kieli='Lat'
  SET DEFAULT TO ..\latvia
  DO ..\latvia\_ncsp
endcase
return