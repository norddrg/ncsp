Procedure englupda
set near on
select ncsp_koo
replace all released with .t.
set order to code_nc
select 0
use englanti\ncsp_koo alias ncsp_en
set order to koodi
goto top
do while not eof()
  if len(trim(koodi))<5
    skip
    loop
  endif
  select ncsp_koo
  set order to code_nc
  set filter to ncsp and not deleted()
  seek trim(ncsp_en.koodi)
  if found()
    replace text with ncsp_en.text
    replace released with .f.
  else
    select ncsp_en
    browse window ryhmat fields koodi, text nowait save nomodify
    select ncsp_koo
    set order to code
    set filter to not released
    seek trim(ncsp_en.koodi)
    wait window nowait 'Choose the code and select - [Ctrl][W], insert a new line - [Esc]'
    browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.ncsp:2, suod.suod:2, ncsp_koo.code_nc:7,; 
    ncsp_koo.text:50, ncsp_koo.code_den, ncsp_koo.code_fin, ncsp_koo.code_swe, ncsp_koo.code_nor,ncsp_koo.code_est,ncsp_koo.code_eng,; 
    ncsp_sec.code:7, ncsp_sec.text:50,;
    ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ncsp_koo.reldate:6:r, ncsp_koo.subst:7; 
    save nomodify
    if lastkey()=27
      append blank 
      replace code with ncsp_en.koodi, code_nc with ncsp_en.koodi, text with ncsp_en.text,;
      released with .f., language with 'C',  ncsp with .t., chadate with date()
    else
      replace text with ncsp_en.text, code_nc with ncsp_en.koodi, ncps with .t. chadate with date()
    endif
  endif
  select ncsp_en
  skip
enddo
