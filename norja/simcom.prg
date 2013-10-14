procedure simcom
select ncsp_en
activate window valikko
clear
? 'Are these the same? Select from table! ' STYLE 'B'
? 'F7  = update the screen with current Norwegian code'
? 'F8  = update the screen with current common code'
? 'F12 = accept mapping from NCSP common version to NCSP Norwegian version'
? 'F11 = accept mapping from NCSP NOrwegian version to NCSP common version'
? 'F10 = no match available'
? 'Next code [Ctrl][S] Previous code [Ctrl}][P} Stop [Ctrl][T]'
?
select ncsp_koo
set order to ncsp
seek ncsp_en.ncsp
browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
ncsp_koo.ncsp:9, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
select ncsp_en
set order to code
browse window codes fields ncsp_en.ncsp:9, ncsp_en.nc:2, ncsp_en.code_nor:7, ncsp_en.text:50,;
ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
ncsp_en.reldate:6:r, ncsp_en.subst:6:r, code_den, code_fin, code_eng, code_swe, code_est save nomodify nowait
return