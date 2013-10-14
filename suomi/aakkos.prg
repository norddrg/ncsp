Procedure aakkos
on error do selhaku
select ncsp_hak
on error
set order to haku
delete all
pack
select sanat
set order to sana
replace all count with 0
select ncsp_luv
set filter to not released
wait window nowait 'Luvut'
do while not eof()
  do sanotus with code, text, 'Fin', ncsp, 'LUV'
  select ncsp_luv
  do sanotus with code, text_2, 'Swe', ncsp, 'LUV'
  select ncsp_luv
  do sanotus with code, english, 'Eng', ncsp, 'LUV'
  select ncsp_luv
  skip
enddo
select ncsp_ryh
set filter to not released
wait window nowait 'Ryhmät'
do while not eof()
  do sanotus with code, text, 'Fin', ncsp, 'RYH'
  select ncsp_ryh
  do sanotus with code, text_2, 'Swe', ncsp, 'RYH'
  select ncsp_ryh
  do sanotus with code, english, 'Eng', ncsp, 'RYH'
  select ncsp_ryh
  skip
enddo
select ncsp_ala
set filter to not released
lc_luv=' '
do while not eof()
  if lc_luv<>substr(code,1,1)
    wait window nowait 'Alaryhmä: '+code
    lc_luv=substr(code,1,1)
  endif
  do sanotus with code, text, 'Fin', ncsp, 'ALA'
  select ncsp_ala
  do sanotus with code, text_2, 'Swe', ncsp, 'ALA'
  select ncsp_ala
  do sanotus with code, english, 'Eng', ncsp, 'ALA'
  select ncsp_ala
  skip
enddo
select ncsp_koo
set filter to not released
goto top
lc_luv=' '
do while not eof()
  if lc_luv<>substr(code,1,1)
    wait window nowait 'Koodi: '+code
    lc_luv=substr(code,1,1)
  endif
  if ncsp=' '
    skip
    loop
  endif
  do sanotus with code, text, 'Fin', ncsp, ' '
  select ncsp_koo
  do sanotus with code, text_2, 'Swe', ncsp, ' '
  select ncsp_koo
  do sanotus with code, english, 'Eng', ncsp, ' '
  select ncsp_koo
  skip
enddo
do _ncsp
return

procedure sanotus
parameter sancode, sanastring, sankieli, sancsp, santype
origstring=sanastring
sanastring=ltrim(sanastring)
sanastring=trim(sanastring)
lc_n=1
do while lc_n-1<len(sanastring)
  if substr(sanastring,lc_n,1)<'A'
    sanastring=substr(sanastring,1,lc_n-1)+' '+substr(sanastring,lc_n+1,len(sanastring))
  endif
  lc_n=lc_n+1
enddo
sanastring=ltrim(rtrim(sanastring))
if len(sanastring)=0
  return
endif
lc_1=0
lc_pit=0
lc_kier=1
lc_hyv=.f.
lc_loop=.t.
do while lc_loop
  lc_lop=at(' ',sanastring,lc_kier)
  if lc_lop=0
    lc_lop=len(sanastring)+1
  endif
  if lc_1=lc_lop
    exit
  endif
  lc_apu=substr(sanastring,lc_1+1, lc_lop-lc_1-1)
  lc_apu=lower(lc_apu)
  select sanat
  seek lc_apu
  if not found()
     lc_hyv=.t.
     select ncsp_hak
     append blank
     replace code with sancode
     replace scand with jarjesty (lc_apu)+trim(jarjesty(substr(origstring, lc_lop,100)))+ ' '+ trim(jarjesty(substr(origstring,1,lc_1)))
     if lc_kier>1
       replace alku with substr(origstring,1,lc_1)
     endif
     replace haku with substr(origstring,lc_1+1, lc_lop-lc_1-1)
     replace loppu with substr(origstring, lc_lop,len(sanastring))
     replace ncsp with sancsp
     replace kieli with sankieli
     replace tyyppi with santype
  else
    replace count with count+1
    replace kieli with sankieli
  endif
  lc_1=lc_lop
  lc_kier=lc_kier+1
enddo
if not lc_hyv
  lc_1=0
  lc_lop=at(' ',sanastring,1)
  if lc_lop=0
    lc_lop=len(sanastring)+1
  endif
  if lc_1=lc_lop
    exit
  endif
  lc_apu=substr(sanastring,lc_1+1, lc_lop-lc_1-1)
  lc_apu=lower(lc_apu)
  select ncsp_hak
  append blank
  replace code with sancode
  replace scand with jarjesty (lc_apu)+trim(jarjesty(substr(origstring, lc_lop,100)))+ ' '+ trim(jarjesty(substr(origstring,1,lc_1)))
  replace haku with substr(origstring,lc_1+1, lc_lop-lc_1-1)
  replace loppu with substr(origstring, lc_lop,len(sanastring))
  replace ncsp with sancsp
  replace kieli with sankieli
  replace tyyppi with santype
endif
return

Function jarjesty
parameter lc_string
lc_palaute=lower(lc_string)
do while at('å',lc_palaute)>0
   lc_palaute = substr(lc_palaute,1, at('å',lc_palaute)-1)+'Å'+substr(lc_palaute,at('å',lc_palaute)+1,len(lc_palaute)-at('å',lc_palaute))
enddo
return lc_palaute

procedure selhaku
select 0
use ncsp_hak
select 0
use sanat
select haku
return