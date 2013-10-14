procedure simseur
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
seek sim_code
do while not eof()
 select ncsp_en
 set filter to reldate = ctod(space(8))
  if ncsp_koo.ncsp<>' '
   set order to ncsp
   seek ncsp_koo.ncsp
   if not found()
     wait window 'Error in mapping to common version' nowait
     do ..\ruotsi\simloc
     exit
   endif
 endif
 select ncsp_en
 set order to code_swe
 seek trim(ncsp_koo.code)
 if not found()
   set filter to
   seek trim(ncsp_koo.code)
 endif
 if found() and reldate<> ctod(space(8))
   replace ncsp_koo.ncsp with ncsp_en.subst
   set order to code
   seek ncsp_koo.ncsp
   if found()
     if ncsp_en.code_swe=' '
       replace ncsp_en.code_swe with ncsp_koo.code
       wait window nowait 'Mapping is modified to '+ncsp_koo.ncsp+', check the result'
     else
       append blank
       replace code with ncsp_koo.ncsp, code_swe with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
       if text=' ' 
         replace text with ncsp_koo.text
       endif
      wait window nowait ncsp_koo.code +' has be added to NCSP combined version with mapping to '+ncsp_koo.ncsp+', check the result'
     endif
     lc_found=.t.       
   endif
   select ncsp_koo
   set order to code
   su_code=ncsp_koo.code
 *  seek sim_code
   select ncsp_en
   set order to code
   seek ncsp_koo.ncsp
   su_code=ncsp_koo.code
   do ..\ruotsi\simcheck
   exit
 endif
 if not found() or reldate <> ctod(space(8))
  lc_found=.f.
  if ncsp_koo.ncsp<>' '
    select ncsp_en
    set order to ncsp
    seek trim(ncsp_koo.ncsp)
    if found() 
      if code_swe=' ' or reldate <> ctod(space(8))
        replace code_swe with ncsp_koo.code
        wait window nowait 'Missing mapping was added to NCSP common version, check the result'
        lc_found=.t.
      else
        append blank
        replace code with ncsp_koo.ncsp, code_swe with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
        if text=' ' 
          replace text with ncsp_koo.text
        endif
      wait window nowait ncsp_koo.code +' has be added to NCSP combined version with mapping to '+ncsp_koo.ncsp+', check the result'
        lc_found=.t.
      endif
      select ncsp_koo
      set order to code
      su_code=ncsp_koo.code
      select ncsp_en
      set order to code
      su_code=ncsp_koo.code
      do ..\ruotsi\simcheck
      exit
    endif
  endif
  if not lc_found
    select ncsp_en
    append blank
    replace code with ncsp_koo.code, code_swe with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
    if text=' ' 
      replace text with ncsp_koo.text
    endif
    wait window nowait ncsp_koo.code+' has be added to NCSP common version without mapping, check the result'
  endif
  select ncsp_koo
  set order to code
  seek sim_code
  select ncsp_en
  set order to code
  seek ncsp_koo.ncsp
  su_code=ncsp_koo.code
  do ..\ruotsi\simcheck
  exit
 endif
 select ncsp_koo
 skip
 sim_code=ncsp_koo.code
enddo
if eof()
  select ncsp_en
  delete all for ncsp_en.ncsp=' ' and code_den=' ' and code_swe=' ' and code_nor=' ' and code_est=' ' and code_eng=' ' and code_fin=' '
  pack
  do ..\ruotsi\ncsp
endif
return  
