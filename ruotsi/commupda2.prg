Procedure commupda
close all
set near on
define window valikko from 0,0 to max_y/2,luv_x-3 font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'NCSP-Finnish'
define window codes from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'NCSP-Common version'
use ncsp_koo.dbf
set order to code
select 0
USE ..\gemens\ncsp_koo.dbf EXCLUSIVE alias ncsp_en
set order to code_d
set filter to not released
replace all nc with .f.
lc_tark2=.f.
select ncsp_koo
set filter to not released and not deleted()
goto top
do while not eof()
  if ncsp_koo.code=' '
    replace released with .t.
    delete
    skip
    loop
  endif
  if ncsp_koo.released
    skip
    loop
  endif
  lc_find=.f.
  lc_ets=.f.
  lc_tark=.f.
  lc_n=0
  lc_loop=.t.
  select ncsp_en
  set order to ncsp
  seek ncsp_koo.code
  if found()
    lc_find=.t.
    if ncsp_en.code_d<>ncsp_koo.code
      lc_tark=.t.
      if ncsp_en.code_d=' ' and ncsp_koo.ncsp=ncsp_en.ncsp
        replace ncsp_en.code_d with ncsp_koo.code
      endif
    else
      replace nc with .t.
      if ncsp_koo.english=' '
        replace ncsp_koo.english with ncsp_en.english
      endif
      if ncsp_koo.ncsp=' '
        replace ncsp_koo.ncsp with ncsp_en.code
      endif
    endif
  endif
  select ncsp_en
  set order to code_d
  seek ncsp_koo.code
  if found()
    lc_find=.t.
    replace nc with .t.
    do while lc_loop 
      seek ncsp_koo.code
      if eof() 
        exit
      else
        skip
        if ncsp_en.code_d<>ncsp_koo.code 
          exit
        else
          replace ncsp_en.code_d with ' '
          if ncsp_en.code_n=' ' and ncsp_en.code_s=' ' and ncsp_en.code_f=' ' and not nc
            replace released with .t.
            delete
          endif
        endif
      endif
    enddo
  endif
  if not lc_find
    lc_tark=.t.
    select ncsp_en
    set order to ncsp
    seek ncsp_koo.ncsp
    if not found() 
      seek ncsp_koo.code
    endif
    if not found()
      set order to code
      seek ncsp_koo.code
    endif
    set order to code
  endif
  if lc_tark and not lc_tark2
    lc_tark2=.t.
    do ..\ruotsi\simcheck
    if lastkey()=27
      exit
    endif
    loop
  endif
  select ncsp_koo
  lc_tark2=.f.
  skip
enddo
select ncsp_en
if lastkey()<>27
  replace all code_d with ' ' for not nc
  delete all for code_f=' ' and code_d=' ' and code_s=' ' and code_n=' ' and ncsp=' '
  pack
endif
replace all nc with .f.
replace all nc with .t. for ncsp<>' '
do ..\ruotsi\ncsp
return

procedure simcheck
      lc_loop=.t.
      on key label f12 do ..\ruotsi\en_fin
      on key label f11 do ..\ruotsi\fin_en
      on key label f10 do ..\ruotsi\no_match
      do while lc_loop
        do ..\ruotsi\simnayt
        select ncsp_koo
        browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
        ncsp_koo.oldcode:7, ncsp_koo.ncsp:7, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
        ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
        select ncsp_en
        set order to code
        browse window codes fields ncsp_en.released:2, ncsp_en.code:7, ncsp_en.ncsp:7, ncsp_en.english:50,;
        ncsp_en.code_d:7, ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
        ncsp_en.reldate:6:r save nomodify 
        do case
        case lastkey()= 23 or lastkey()=27
          exit
        endcase
      enddo
      lc_ets=.t.
return

procedure en_fin
if ncsp_en.ncsp=' '
  if ncsp_en.code_d=ncsp_koo.code and ncsp_koo.ncsp=ncsp_en.ncsp and released
    replace released with .f.
  else
    wait window 'Mapping has to be to a common NCSP-code'
    return
  endif
else
  replace ncsp_en.code_d with ncsp_koo.code
  replace ncsp_koo.ncsp with ncsp_en.code
  if ncsp_koo.english=' '
    replace ncsp_koo.english with ncsp_en.english
  endif
endif
lc_find=.t.
do ..\ruotsi\simnayt
return

procedure fin_en
if ncsp_en.ncsp=' '
  if ncsp_en.code_d=ncsp_koo.code and released
    replace released with .f.
    lc_find=.t.
    do ..\ruotsi\simnayt
    return
  else
    wait window 'Mapping has to be to a common NCSP-code'
    return
  endif
endif
replace ncsp_koo.ncsp with ncsp_en.ncsp
select ncsp_en
set order to code
seek ncsp_koo.code
insert into ncsp_en (code, code_d, nc);
values (ncsp_koo.code, ncsp_koo.code, .t.)
replace ncsp_en.chadate with ncsp_koo.chadate, ncsp_en.usedate with ncsp_koo.usedate
replace ncsp_en.english with ncsp_koo.english
if ncsp_en.english=' '
  replace ncsp_en.english with ncsp_koo.text_2
endif
if ncsp_en.english=' '
  replace ncsp_en.english with ncsp_koo.text
endif
replace released with .f.
lc_find=.t.
do ..\ruotsi\simnayt
return

procedure no_match
replace ncsp_koo.ncsp with ' '
Select ncsp
replace all ncsp_en.code_d with ' ', ncsp_en.nc with .f. for ncsp_en.code_d=ncsp_koo.code
lc_find=.f.
select ncsp_en
set order to code
seek ncsp_koo.code
do ..\ruotsi\simnayt
return

procedure simnayt
activate window valikko
clear
? 'Are these the same? Select from table! ' STYLE 'B'
? 'F12 = accept mapping from NCSP common version to NCSP Norwegian version'
? 'F11 = accept mapping from NCSP Norwegian version to NCSP common version'
? 'F10 = no match available'
? 'Accept with [Ctrl][W]'
?
? 'NCSP Norwegian version' STYLE 'B'
? ncsp_koo.code +' '+trim(ncsp_koo.text)
if ncsp_koo.ncsp<>' '
  ? 'Mapped to: '+ncsp_koo.ncsp
else
  ? 'No mapping available' STYLE 'B'
endif
select ncsp_en
?
? 'NCSP common version' STYLE 'B'
if not ncsp_en.nc
  lc_ncsp=ncsp_en.ncsp
  if ncsp_koo.ncsp<>' '
    seek ncsp_koo.ncsp
  endif
  ? ncsp_en.ncsp +' '+trim(ncsp_en.english)
  ? 'Mapped to: '+ncsp_en.code_d
  if lc_ncsp<>' '
    seek ncsp_koo.code
  endif
else
  ? ncsp_en.ncsp +' '+trim(ncsp_en.english)
  ? 'Mapped to: '+ncsp_en.code_d
endif
return