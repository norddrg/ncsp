procedure sanasiir
select sanat
seek jarjesty(trim(ncsp_hak.haku))
if not found()
  insert into sanat (sana, kieli) values (jarjesty(ncsp_hak.haku), ncsp_hak.kieli)
endif
select ncsp_hak
set order to haku
lc_sana=jarjesty(trim(sanat.sana))
seek lc_sana
do while scand=lc_sana and len(trim(haku))=len(lc_sana)
  if not deleted()
    replace sanat.count with sanat.count+1
  endif
  delete
  skip
enddo
wait window nowait sanat.sana+': '+str(sanat.count)
select ncsp_hak
set filter to not deleted()
return

Function jarjesty
parameter lc_string
lc_palaute=trim(lower(lc_string))
do while at('å',lc_palaute)>0
   lc_palaute = substr(lc_palaute,1, at('å',lc_palaute)-1)+'Å'+substr(lc_palaute,at('å',lc_palaute)+1,len(lc_palaute)-at('å',lc_palaute))
enddo
return lc_palaute