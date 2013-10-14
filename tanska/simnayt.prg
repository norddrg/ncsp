procedure simnayt
activate window valikko
clear
? 'Are these the same? Select from table! ' STYLE 'B'
? 'F7  = update the screen with current local code'
? 'F8  = update the screen with current common code'
? 'F12 = accept mapping from NCSP+ to NCSP local version'
? 'F11 = accept mapping from NCSP local version to NCSP+'
? 'F10 = no match available'
? 'Next code [Ctrl][S] Previous code [Ctrl}][P} Exit [Ctrl][T]'
?
select ncsp_koo
? 'NCSP local version' STYLE 'B'
? ncsp_koo.code +' '+trim(ncsp_koo.text)
select ncsp_en
set order to code_eng
seek SUBSTR(ncsp_koo.code,2,7)
if not found()
  ?
  ? 'Needs to be added to NCSP+!' STYLE 'B'
else
  if ncsp_en.ncsp=' '
    ? 'NCSP+ text:'
    ? space(9)+' '+trim(ncsp_en.text)
  endif
endif  
if ncsp_koo.ncsp=' '
  ?
  ? 'No mapping to NCSP+ version'
else
  set order to ncsp
  seek ncsp_koo.ncsp
  ?
  ? 'Mapped NCSP+ code:' STYLE 'B'
  ? ncsp_en.ncsp +' '+trim(ncsp_en.text)
  if ncsp_en.code_den <> ncsp_koo.code 
    if ncsp_en.code_den<>' ' 
      select ncsp_koo
      seek ncsp_en.code_eng
      ? 'NCSP+ code mapped back to: '+ncsp_koo.code+trim(ncsp_koo.text)
    else
      ? 'No mapping to NCSP+'
    endif
  endif
endif
select ncsp_koo
set filter to reldate=ctod(space(8))
seek sim_code
browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:9, ncsp_koo.text:50, ncsp_koo.short:20,;
ncsp_koo.ncsp:9, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
select ncsp_en
set filter to reldate=ctod(space(8))
set order to code
browse window codes fields ncsp_en.ncsp:9, ncsp_en.nc:2, ncsp_en.code_den:9, ncsp_en.text:50,;
ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
ncsp_en.reldate:6:r, ncsp_en.subst:6:r, code_est, code_fin, code_eng, code_nor, code_swe save nomodify nowait
return