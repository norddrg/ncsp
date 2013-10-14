Procedure lang_pal
select 0
use ..\muisti
replace muisti.ncsp with ncsp_koo.ncsp
SET PATH TO TO ..\gemens
set default to ..\gemens
do ..\gemens\_ncsp
return