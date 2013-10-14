Procedure aakhaku
define window koodi from 5,5 to 15,40 FONT  max_foty,  max_fosi
activate window koodi
ah_str=space(20)
@ 2,1 say 'Anna etsittävä teksti'
@ 3,5 get ah_str
read
release window koodi
if lastkey()=27
  return
endif
ah_str=jarjesty(ah_str)
select ncsp_hak
set order to haku
seek ah_str
browse fields alkuosa=trim(alku):40, hakuosa=trim(haku):15, loppuosa= trim(loppu):40, code, kieli, ncsp save nowait window aakkos noedit nodelete
*browse fields alut=trim(alku):40, haut=trim(haku):15, loput=trim(loppu):40, koodi, ast, d_koodi, kieli save nowait window aakkos
return

Function jarjesty
parameter lc_string
lc_palaute=lower(lc_string)
do while at('å',lc_palaute)>0
   lc_palaute = substr(lc_palaute,1, at('å',lc_palaute)-1)+'Å'+substr(lc_palaute,at('å',lc_palaute)+1,len(lc_palaute)-at('å',lc_palaute))
enddo
do while at('-',lc_palaute)>0
   lc_palaute = substr(lc_palaute,1, at('-',lc_palaute)-1)+substr(lc_palaute,at('-',lc_palaute)+1,len(lc_palaute)-at('-',lc_palaute))
enddo
return lc_palaute