procedure naytto
  lc_alias=alias()
  pub_code=substr(ncsp,1,4)
define window luv_ohj from 0,luv_x to luv_y,max_x font  max_foty,  max_fosi title 'Luku'
define window ryh_ohj from luv_y,luv_x to ryh_y,max_x font max_foty,  max_fosi title 'Ryhmä'
define window ala_ohj from ryh_y,luv_x to ala_y,max_x font max_foty,  max_fosi title 'Alaryhmä'
define window koo_ohj from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'Koodi-'+aktfilt

modify memo ncsp_luv.note window luv_ohj nowait save
modify memo ncsp_ryh.note window ryh_ohj nowait save
modify memo ncsp_ala.note window ala_ohj nowait save
modify memo ncsp_koo.note_e window koo_ohj nowait save

select ncsp_sec
set filter to not released
if not (lc_alias = 'NCSP_KOO' or lc_alias = 'SUOD')
  select ncsp_koo
  if suodatin
    select suod
  endif
*   set filter to substr(code,1,3)=trim(pub_code) and not poistettu
*  seek trim(pub_code)
  browse window koodit fields suod.suod:2, ncsp_koo.nc:3, ncsp_koo.ncsp:9,; 
  ncsp_koo.text:50, ncsp_koo.code_den, ncsp_koo.code_fin, ncsp_koo.code_swe, ncsp_koo.code_nor,ncsp_koo.code_ice, ncsp_koo.code_est,ncsp_koo.code_lat, ncsp_koo.code_eng,; 
  mapped_to=ncsp_sec.ncsp:9, local_text=ncsp_sec.text:50,;
  ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ncsp_koo.reldate:6:r, ncsp_koo.subst:7; 
  nowait save nomodify
endif
if lc_alias<>'NCSP_ALA'
  select ncsp_ala
  public lc_len
  lc_len = len(trim(pub_code))
  if lc_len>3 
    lc_len=4
  endif
  set filter to trim(pub_code) = substr(ncsp,1,lc_len) and not released
  if lc_len=4
     set filter to (trim(pub_code) = substr(ncsp,1,lc_len) or trim(pub_code) = substr(ncsp,1,3) and substr(ncsp,4,1)=' ') and not released
  endif
  browse window alaryh fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2, chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
endif
if lc_alias<>'NCSP_RYH'
  select ncsp_ryh
  if p_poist
    set filter to substr(ncsp,1,2)=trim(substr(pub_code,1,2)) and not released
  else
    set filter to substr(ncsp,1,2)=trim(substr(pub_code,1,2))
  endif
  browse window ryhmat fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
endif
if lc_alias<>'NCSP_LUV'
  select ncsp_luv
  set filter to substr(ncsp,1,1)=substr(pub_code,1,1)
  browse window luvut fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
endif
do CASE
case lc_alias='NCSP_LUV'
  select ncsp_luv
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window luvut fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2, chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
case lc_alias='NCSP_RYH'
  select ncsp_ryh
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window ryhmat fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
case lc_alias='NCSP_ALA'
  select ncsp_ala
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window alaryh fields ncsp:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r nowait save nomodify
case lc_alias='NCSP_KOO' or lc_alias='SUOD'
  select (lc_alias)
  browse window koodit fields suod.suod:2, ncsp_koo.released:2, ncsp_koo.nc:3, ncsp_koo.ncsp:9,; 
  ncsp_koo.text:50, ncsp_koo.code_den, ncsp_koo.code_fin, ncsp_koo.code_ice, ncsp_koo.code_nor, ncsp_koo.code_swe, ncsp_koo.code_est,ncsp_koo.code_lat, ncsp_koo.code_eng,; 
  mapped_to=ncsp_sec.ncsp:9, local_text=ncsp_sec.text:50,;
  ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ncsp_koo.reldate:6:r, ncsp_koo.subst:7; 
  nowait save nomodify
endcase
return

