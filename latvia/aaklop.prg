procedure aaklop
release window aakkos
select ncsp_hak
lc_haku=trim(substr(scand,1,at(' ',scand)))
select sanat
use
do case
case ncsp_hak.tyyppi='L'
  select ncsp_luv
case ncsp_hak.tyyppi='R'
  select ncsp_ryh
case ncsp_hak.tyyppi='A'
  select ncsp_ala
otherwise
  select ncsp_koo
endcase
seek ncsp_hak.code
lc_alias=alias()
do ohje
do naytto
select ncsp_hak
use
select (lc_alias)
return

