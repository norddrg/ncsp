Procedure simupda
select ncsp_koo
public su_code
su_code=code
close all
set near on
define window valikko from 1,1 to max_y/2,luv_x-3 font  max_foty,  max_fosi
define window koodit from ala_y,3 to max_y,luv_x font  max_foty,  max_fosi Title 'NCSP-Local version'
define window codes from ala_y,luv_x to max_y,max_x font max_foty,  max_fosi title 'NCSP-Common version'
use ncsp_koo.dbf
set order to code
select 0
USE ..\gemens\ncsp_koo.dbf EXCLUSIVE alias ncsp_en
set order to code
lc_tark2=.f.
lc_tark=.f.
select ncsp_koo
set filter to 
goto top
do while not eof()
  if ncsp_koo.code=' '
    skip
    loop
  endif
  select ncsp_en
  seek ncsp_koo.ncsp
  if released
    IF ncsp_koo.released
      replace ncsp_koo.ncsp with ncsp_en.subst
    else
      do while ncsp_en.code_swe<>ncsp_koo.code and ncsp_en.code=ncsp_koo.ncsp and not eof()
        skip
      ENDDO
      if released and ncsp_en.code_swe=ncsp_koo.code
        replace ncsp_koo.ncsp with ncsp_en.subst
      endif
    endif
  endif
  select ncsp_koo
  skip
enddo
select ncsp_en
set order to code_swe
set filter to not released
select ncsp_koo
SET FILTER TO not released and not deleted()
seek su_code
public sim_code
sim_code=ncsp_koo.code
do ..\ruotsi\simcheck
return
