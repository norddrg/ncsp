procedure naytto
  if kieli='S'
    do nayt_su
  else
    do nayt_sv
  endif
  return

procedure nayt_su
  lc_alias=alias()
  pub_code=substr(code,1,3)
define window luv_ohj from 0,luv_x to luv_y,max_x font  max_foty,  max_fosi title 'Luku'
define window ryh_ohj from luv_y,luv_x to ryh_y,max_x font max_foty,  max_fosi title 'Ryhm�'
define window ala_ohj from ryh_y,luv_x to ala_y,max_x font max_foty,  max_fosi title 'Alaryhm�'
define window koo_ohj from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'Koodit'

modify memo ncsp_luv.note window luv_ohj nowait save
modify memo ncsp_ryh.note window ryh_ohj nowait save
modify memo ncsp_ala.note window ala_ohj nowait save
modify memo ncsp_koo.note window koo_ohj nowait save

if not (lc_alias = 'NCSP_KOO' or lc_alias = 'SUOD')
  select ncsp_koo
  if suodatin
    select suod
  endif
  goto top
  set filter to substr(code,1,3)=trim(pub_code) and not released
  seek trim(pub_code)
  browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
  suod.old:7, suod.price:3, ncsp_koo.ncsp:9, suod.suod:2, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
  ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_ALA'
  select ncsp_ala
  goto top
  set filter to substr(code,1,3)=trim(pub_code) and not released
  browse window alaryh fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_RYH'
  select ncsp_ryh
  goto top
  if p_poist
    set filter to substr(code,1,2)=trim(substr(pub_code,1,2)) and not released
  else
    set filter to substr(code,1,2)=trim(substr(pub_code,1,2))
  endif
  browse window ryhmat fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_LUV'
  select ncsp_luv
  goto top
  set filter to substr(code,1,1)=substr(pub_code,1,1)
  browse window luvut fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
do CASE
case lc_alias='NCSP_LUV'
  select ncsp_luv
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window luvut fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_RYH'
  select ncsp_ryh
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window ryhmat fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_ALA'
  select ncsp_ala
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window alaryh fields released:2:r, code:7, typecode:3, text:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_KOO' or lc_alias='SUOD'
  select ncsp_koo
  if suodatin
    select suod
  endif
  browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
  suod.old:7, suod.price:3, ncsp_koo.ncsp:9, suod.suod:2, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
  ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
endcase
return

procedure nayt_sv
    lc_alias=alias()
    pub_code=substr(code,1,3)
define window luv_ohj from 0,luv_x to luv_y,max_x font  max_foty,  max_fosi title 'Luku'
define window ryh_ohj from luv_y,luv_x to ryh_y,max_x font max_foty,  max_fosi title 'Ryhm�'
define window ala_ohj from ryh_y,luv_x to ala_y,max_x font max_foty,  max_fosi title 'Alaryhm�'
define window koo_ohj from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'Koodi'

modify memo ncsp_luv.note_2 window luv_ohj nowait save
modify memo ncsp_ryh.note_2 window ryh_ohj nowait save
modify memo ncsp_ala.note_2 window ala_ohj nowait save
modify memo ncsp_koo.note_2 window koo_ohj nowait save

if not (lc_alias='NCSP_KOO' or lc_alias='SUOD')
  select ncsp_koo
  if suodatin
    select suod
  endif
  goto top
*   set filter to substr(koodi,1,3)=trim(pub_) and not poistettu
  seek trim(pub_code)
  browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text_2:50, ncsp_koo.short:20,;
  suod.old:7, suod.price:3, ncsp_koo.ncsp:9, suod.suod:2, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
  ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_ALA'
  select ncsp_ala
  goto top
  if p_poist
    set filter to substr(code,1,3)=trim(pub_code) and not released
  else
    set filter to substr(code,1,3)=trim(pub_code)
  endif
  browse window alaryh fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_RYH'
  select ncsp_ryh
  goto top
  if p_poist
    set filter to substr(code,1,2)=trim(substr(pub_code,1,2)) and not released
  else
    set filter to substr(code,1,2)=trim(substr(pub_code,1,2))
  endif
  browse window ryhmat fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
if lc_alias<>'NCSP_LUV'
  select ncsp_luv
  goto top
  set filter to substr(code,1,1)=substr(pub_code,1,1)
  browse window luvut fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
endif
do CASE
case lc_alias='NCSP_LUV'
  select ncsp_luv
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window luvut fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_RYH'
  select ncsp_ryh
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window ryhmat fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_ALA'
  select ncsp_ala
  if p_poist
    set filter to not released
  else
    set filter to
  endif
  browse window alaryh fields released:2:r, code:7, typecode:3, text_2:50, short:20, suod.suod:2,  chadate:6 :r,; 
  usedate:6:r, reldate:6:r, english:50 nowait save nomodify
case lc_alias='NCSP_KOO' or lc_alias='SUOD'
  select (lc_alias)
  browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text_2:50, ncsp_koo.short:20,;
  suod.old:7, suod.price:3, ncsp_koo.ncsp:9, suod.suod:2, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
  ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
endcase
return

