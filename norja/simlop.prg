procedure simlop
select ncsp_koo
pub_code=code
set order to code
select ncsp_en
set order to code_nor
goto top
sl_kier=1
sl_loop=.t.
do while sl_loop
  select ncsp_en
  if eof()
    exit
  endif
  if code_fin=' ' and code_nor=' ' and code_den=' ' and code_est=' ' and code_swe=' ' and code_ice=' ' and code_eng=' ' and ncsp= ' '
    delete
    skip 
    loop
  endif
  if code_nor=' '
    skip
    loop
  endif
  if sl_kier=1
    sl_code=trim(code_nor)
    select ncsp_koo
    seek sl_code
    if not found()
      select ncsp_koo
      browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
      ncsp_koo.ncsp:9, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
      ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
      select ncsp_en
      set order to code
      browse window codes fields ncsp_en.ncsp:9, ncsp_en.nc:2, ncsp_en.code_nor:7, ncsp_en.text:50,;
      ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
      ncsp_en.reldate:6:r, ncsp_en.subst:6:r, code_den, code_eng, code_est, code_fin, code_swe save nomodify nowait
      wait window 'Local code '+sl_code+' not found in local version - remove the code from combined table? Y/N'
      if lastkey()=89 or lastkey()=121 
        replace ncsp_en.code_nor with ' '
        set order to code_nor
      else
        return
      endif
      select ncsp_en
      seek sl_code
      do while found()
        select ncsp_koo
        browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
        ncsp_koo.ncsp:9, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
        ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
        select ncsp_en
        set order to code
        browse window codes fields ncsp_en.ncsp:9, ncsp_en.nc:2, ncsp_en.code_nor:7, ncsp_en.text:50,;
        ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
        ncsp_en.reldate:6:r, ncsp_en.subst:6:r, code_den, code_eng, code_est, code_fin, code_swe save nomodify nowait
        wait window 'Local code '+sl_code+' not found in local version - delete from combined table? Y/N'
        if lastkey()=89 or lastkey()=121 
          replace ncsp_en.code_nor with ' '
          set order to code_nor
        else
          return
        endif
        if code_swe=' ' and code_nor=' ' and code_den=' ' and code_est=' ' and code_fin=' ' and code_ice=' ' and code_eng=' ' and ncsp= ' '
          delete
        endif
        seek sl_code
      enddo
      loop
    endif
    sl_kier=2
  endif
  if sl_kier=2
    select ncsp_en
    if eof()
      exit
    endif
    skip
    if code_nor=sl_code and sl_code=code_nor
      select ncsp_koo
      browse window koodit fields ncsp_koo.released:2:r, ncsp_koo.code:7, ncsp_koo.text:50, ncsp_koo.short:20,;
      ncsp_koo.ncsp:9, ncsp_koo.chadate:6 :r, ncsp_koo.usedate:6:r, ;
      ncsp_koo.reldate:6:r, ncsp_koo.english:50 nowait save nomodify
      select ncsp_en
      set order to code
      browse window codes fields ncsp_en.ncsp:9, ncsp_en.nc:2, ncsp_en.code_nor:7, ncsp_en.text:50,;
      ncsp_en.chadate:6 :r, ncsp_en.usedate:6:r, ;
      ncsp_en.reldate:6:r, ncsp_en.subst:6:r, code_den, code_eng, code_est, code_fin, code_swe, code_ice save nomodify nowait
      wait window 'Local code '+sl_code+' not found in local version - delete from combined table? Y/N'
      if lastkey()=89 or lastkey()=121 
        replace ncsp_en.code_nor with ' '
        set order to code_nor
      else
        return
      endif
      if code_swe=' ' and code_nor=' ' and code_den=' ' and code_est=' ' and code_fin=' ' and code_ice=' ' and code_eng=' ' and ncsp= ' '
        delete
      endif
      seek sl_code
      loop
    endif
    sl_kier=1
  endif
enddo
select ncsp_en
pack
do ../norja/ncsp
RETURN
