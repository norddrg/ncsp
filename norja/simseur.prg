procedure simseur
lc_tark2=.f.
lc_tark=.f.
su_code=ncsp_koo.code
select ncsp_en
use
USE ..\gemens\ncsp_koo.dbf EXCLUSIVE alias ncsp_en
select ncsp_koo
use
use ncsp_koo.dbf
SET FILTER TO NOT released
set order to code
seek su_code
do while not eof()
 select ncsp_en
 set filter to reldate = ctod(space(8)) 
 if ncsp_koo.ncsp<>' '
   set order to ncsp
   seek ncsp_koo.ncsp
   if not found()
     wait window 'Error in mapping to common version' nowait
     do ..\norja\simloc
     exit
   endif
 endif

 select ncsp_en
 set order to code_nor
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
     if ncsp_en.code_nor=' '
       replace ncsp_en.code_nor with ncsp_koo.code
       wait window nowait 'Mapping is modified to '+ncsp_koo.ncsp+', check the result'
     else
       append blank
       replace code with ncsp_koo.ncsp, code_nor with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
       wait window nowait 'The line has be added to NCSP combined version with mapping to '+ncsp_koo.ncsp+', check the result'
     endif
     lc_found=.t.       
   endif
 endif
 if not found() or reldate <> ctod(space(8))
  lc_found=.f.
  if ncsp_koo.ncsp<>' '
    select ncsp_en
    set order to ncsp
    seek trim(ncsp_koo.ncsp)
    if found() 
      if code_nor=' ' or reldate <> ctod(space(8))
        replace code_nor with ncsp_koo.code
        wait window nowait 'Missing mapping for '+ncsp_koo.code +' - '+trim(ncsp_koo.text)+'- was added to NCSP common version, check the result'
        lc_found=.t.
        exit
      else
        append blank
        replace code with ncsp_koo.ncsp, code_nor with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
        if text=' '
          replace text with ncsp_koo.text
        endif
        wait window nowait ncsp_koo.code +' - '+trim(ncsp_koo.text)+'- has be added to NCSP common version at location '+ncsp_koo.ncsp+', check the result'
        lc_found=.t.
      endif
    endif
  endif
  if not lc_found
    select ncsp_en
    append blank
    replace code with ncsp_koo.code, code_nor with ncsp_koo.code, released with .f., text with ncsp_koo.english, usedate with ncsp_koo.usedate, chadate with date(), nc with .f. 
    wait window nowait ncsp_koo.code +' - '+trim(ncsp_koo.text)+'- has be added to NCSP common version without mapping, check the result'
    su_code=ncsp_koo.code
  endif
  do simcheck
  exit
 endif
 select ncsp_koo
 skip
 su_code=ncsp_koo.code
enddo
if eof()
  DO ..\norja\simlop
else
  SELECT ncsp_koo
  SEEK su_code
  DO ..\norja\simnayt
endif
return  
