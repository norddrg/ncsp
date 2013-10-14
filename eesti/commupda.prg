Procedure commupda
close all
define window valikko from 0,0 to max_y/2,luv_x-3 font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'NCSP-Finnish'
define window codes from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'NCSP-Common version'
use ncsp_koo.dbf
set order to code
select 0
USE ..\gemens\ncsp_koo.dbf EXCLUSIVE alias ncsp_en
set order to code
set filter to not deleted()
select ncsp_koo
set filter to not released and not deleted()
goto top
do while not eof()
  select ncsp_en
  set order to code
  lc_find=.f.
  lc_ets=.f.
  lc_n=0
  seek ncsp_koo.code
  do while ncsp_en.code=ncsp_koo.code and not eof()
    if ncsp_en.code_f=ncsp_koo.code and not released
      lc_n=lc_n+1
    endif
    skip
  enddo
  if ncsp_koo.ncsp<>ncsp_koo.code and ncsp_koo.ncsp<>' ' 
    seek ncsp_koo.ncsp
    if found() and not released and lc_n=0
      lc_n=1
      skip
    endif
    do while ncsp_en.code=ncsp_koo.ncsp and not eof()
      if ncsp_en.code_f=ncsp_koo.code and not released
        lc_n=lc_n+1
      endif
       skip
    enddo
  endif
  if lc_n>1
    lc_n=0
    seek ncsp_koo.code
    do while ncsp_en.code=ncsp_koo.code and not eof()
      if ncsp_en.code_f=ncsp_koo.code 
        if not ncsp_en.nc
          replace ncsp_en.released with .t.
        else
          lc_n=lc_n+1
        endif
      endif
      skip
    enddo
    if ncsp_koo.ncsp<>ncsp_koo.code and ncsp_koo.ncsp<>' ' 
      seek ncsp_koo.ncsp
      do while ncsp_en.code=ncsp_koo.ncsp and not eof()
        if code_f=ncsp_koo.code 
          if not ncsp_en.nc
            replace ncsp_en.released with .t.
          else
            lc_n=lc_n+1
          endif
        endif
        skip
      enddo
    endif
  endif
  if lc_n=1
    seek ncsp_koo.code
    do while ncsp_en.code=ncsp_koo.code and not eof()
      if ncsp_en.code_f=ncsp_koo.code and (not released or not nc)
         lc_find=.t.
         replace released with .f.
         if ncsp_en.ncsp=' '
           replace ncsp_en.ncsp with ncsp_koo.code
         endif
         if not ncsp_en.nc
           replace ncsp_en.english with ncsp_koo.english
         endif
         if ncsp_en.english=' '
           replace ncsp_en.english with ncsp_koo.text_2
         endif
         if ncsp_en.english=' '
           replace ncsp_en.english with ncsp_koo.text
         endif
         exit
      endif
      skip
    enddo
    if ncsp_koo.ncsp<>ncsp_koo.code and ncsp_koo.ncsp<>' ' and not lc_find
      seek ncsp_koo.ncsp
      do while ncsp_en.code=ncsp_koo.ncsp and not eof()
        if nc and not released and code_f<>' '
          lc_tark=.t.
          seek ncsp_koo.code
          do while ncsp_en.code=ncsp_koo.code and not eof()
            if not released and not nc and code_f=ncsp_koo.code
              if ncsp=' '
                replace ncsp with ncsp_koo.ncsp
              endif
              lc_tark=.f.
              exit
            endif
            skip
          enddo
          if lc_tark
            insert into ncsp_en (chadate, usedate, released, code, ncsp, english, code_f, nc);
            values (ncsp_koo.chadate, ncsp_koo.usedate, .f., ncsp_koo.code, ncsp_koo.ncsp, ncsp_koo.english, ncsp_koo.code, .f.)
          endif
          if not ncsp_en.nc
            replace ncsp_en.english with ncsp_koo.english
          endif
          if ncsp_en.english=' '
            replace ncsp_en.english with ncsp_koo.text_2
          endif
          if ncsp_en.english=' '
            replace ncsp_en.english with ncsp_koo.text
          endif
          seek ncsp_koo.ncsp
          do while not eof()
            if nc and not released and code_f<>' '
              lc_find=.t.
              exit
            endif
            skip
          enddo
        endif
        if lc_find
          exit
        endif
        skip
      enddo
    endif
  endif
  if not lc_find and not ncsp_koo.released
    seek ncsp_koo.code
    if found() and ncsp_en.code_f=ncsp_koo.code
      do ..\eesti\simcheck
    else
      if ncsp_koo.ncsp<>'  '
        seek ncsp_koo.ncsp
        do while not nc and not eof()
          skip
        enddo
        do ..\eesti\simcheck
      endif
    endif
  endif
  if lc_find
    if ncsp_en.released
      replace ncsp_en.released with .f.
    endif
    if ncsp_koo.released
      replace ncsp_en.code_f with ' '
      if code_s=' ' and code_d=' ' and code_n=' 'and not nc
        replace released with .f.
      endif
    endif
  endif
  if not lc_find and not ncsp_koo.released
    insert into ncsp_en (chadate, usedate, released, code, english, code_f, nc);
    values (ncsp_koo.chadate, ncsp_koo.usedate, .f., ncsp_koo.code, ncsp_koo.english, ncsp_koo.code, .f.)
    if ncsp_en.english=' '
      replace ncsp_en.english with ncsp_koo.text_2
    endif
    if ncsp_en.english=' '
      replace ncsp_en.english with ncsp_koo.text
    endif
  endif
  if lastkey()=27
    exit
  endif
  select ncsp_koo
  skip
enddo
do ..\eesti\ncsp
return

procedure simcheck
      lc_loop=.t.
      on key label f12 do en_fin
      on key label f11 do fin_en
      on key label f10 do no_match
      do while lc_loop
        do ..\eesti\simnayt
        select ncsp_koo
        browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
        ncsp_koo.oldcode:7, ncsp_koo.ncsp:7, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
        ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
        select ncsp_en
*        set order to code
        browse window codes fields ncsp_en.released:2, ncsp_en.nc:2, ncsp_en.code:7, ncsp_en.ncsp:7, ncsp_en.english:50,;
        ncsp_en.code_f:7, ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
        ncsp_en.reldate:6:r save nomodify 
        do case
        case lastkey()= 23 or lastkey()=27
          exit
        endcase
      enddo
      lc_ets=.t.
return

procedure en_fin
if not ncsp_en.nc
  if ncsp_en.code_f=ncsp_koo.code and ncsp_koo.ncsp=ncsp_en.ncsp and released
    replace released with .f.
  else
    wait window 'Mapping has to be to a common NCSP-code'
    return
  endif
else
  replace ncsp_en.code_f with ncsp_koo.code
  replace ncsp_koo.ncsp with ncsp_en.code
endif
lc_find=.t.
do ..\eesti\simnayt
return

procedure fin_en
if not ncsp_en.nc
  if ncsp_en.code_f=ncsp_koo.code and released
    replace released with .f.
    lc_find=.t.
    do ..\eesti\simnayt
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
do while ncsp_en.code=ncsp_koo.code and not eof()
  if ncsp_en.code_f=ncsp_koo.code
    if ncsp_en.ncsp=' '
      replace ncsp_en.ncsp with ncsp_koo.code
    endif
    exit
  endif
  skip
enddo
if not (ncsp_en.code=ncsp_koo.code and ncsp_en.code_f=ncsp_koo.code and (ncsp_en.ncsp=ncsp_koo.code or ncsp_en.nc)) and not ncsp_koo.released
    insert into ncsp_en (ncsp, code, code_f, nc);
    values (ncsp_koo.ncsp, ncsp_koo.code, ncsp_koo.code, .f.)
endif
replace ncsp_en.chadate with ncsp_koo.chadate, ncsp_en.usedate with ncsp_koo.usedate
if not ncsp_en.nc
  replace ncsp_en.english with ncsp_koo.english
  if ncsp_en.english=' '
    replace ncsp_en.english with ncsp_koo.text_2
  endif
  if ncsp_en.english=' '
    replace ncsp_en.english with ncsp_koo.text
  endif
endif
replace released with .f.
lc_find=.t.
do ..\eesti\simnayt
return

procedure no_match
replace ncsp_koo.ncsp with ' '
if ncsp_en.code_f=ncsp_koo.code
  replace ncsp_en.code_f with ' '
  if not ncsp and code_s=' ' and code_d=' ' and code_n=' '
    replace released with .t.
  endif
endif
lc_find=.f.
do ..\eesti\simnayt
return

procedure simnayt
activate window valikko
clear
? 'Are these the same? Select from table! ' STYLE 'B'
? 'F12 = accept mapping from NCSP common version to NCSP finnish version'
? 'F11 = accept mapping from NCSP finnish version to NCSP common version'
? 'F10 = no match available'
? 'Accept with [Ctrl][W]'
?
? 'NCSP Finish version' STYLE 'B'
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
  seek ncsp_koo.ncsp
  ? ncsp_en.ncsp +' '+trim(ncsp_en.english)
  ? 'Mapped to: '+ncsp_en.code_f
  if lc_ncsp<>' '
    seek ncsp_koo.code
  endif
else
  ? ncsp_en.ncsp +' '+trim(ncsp_en.english)
  ? 'Mapped to: '+ncsp_en.code_f
endif
return