Procedure repfile
select 0
use repstr
COPY TO siirto2\report.dbf NEXT 0 with cdx
use siirto2\report
set order to ncsp
select ncsp_luv
set filter to
goto top
do while not eof()
  insert into report (usedate, reldate, released, subst, headline, nc, code, ncsp, text, short);
  values (ncsp_luv.usedate, ncsp_luv.reldate, ncsp_luv.released, ncsp_luv.subst, .t., .t., ncsp_luv.ncsp, ncsp_luv.ncsp, ncsp_luv.text, ncsp_luv.short)
  skip
enddo
select ncsp_ryh
set filter to
goto top
do while not eof()
  insert into report (usedate, reldate, released, subst, headline, nc, code, ncsp, text, short);
  values (ncsp_ryh.usedate, ncsp_ryh.reldate, ncsp_ryh.released, ncsp_ryh.subst, .t., .t., ncsp_ryh.ncsp, ncsp_ryh.ncsp, ncsp_ryh.text, ncsp_ryh.short)
  skip
enddo
select ncsp_ala
set filter to
goto top
do while not eof()
  insert into report (usedate, reldate, released, subst, headline, nc, code, ncsp, text, short);
  values (ncsp_ala.usedate, ncsp_ala.reldate, ncsp_ala.released, ncsp_ala.subst, .t., .t., ncsp_ala.ncsp, ncsp_ala.ncsp, ncsp_ala.text, ncsp_ala.short)
  skip
enddo
select ncsp_koo
set relation to
goto top
do while not eof()
  insert into report (usedate, reldate, released, subst, headline, nc, code, ncsp, text, code_fin, code_den, code_swe, code_nor, code_est, code_eng, short);
  values (ncsp_koo.usedate, ncsp_koo.reldate, ncsp_koo.released, ncsp_koo.subst, .f., ncsp_koo.nc, ncsp_koo.code, ncsp_koo.ncsp, ncsp_koo.text, ncsp_koo.code_fin, ncsp_koo.code_den, ncsp_koo.code_swe, ncsp_koo.code_nor, ncsp_koo.code_est, ncsp_koo.code_eng, ncsp_koo.short)
  if ncsp=' ' and not released
    on error select 0
    select ncsp_sec
    use
    on error
    select 0
    lc_found=.f.
    do case
    case ncsp_koo.code_fin<>' '
      use ..\suomi\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_fin)
      if found()
        lc_found=.t.
      endif
    case ncsp_koo.code_swe<>' '
      use ..\ruotsi\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_swe)
      if found()
        lc_found=.t.
      endif
    case ncsp_koo.code_den<>' '
      use ..\tanska\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_den)
      if found()
        lc_found=.t.
      endif
    case ncsp_koo.code_nor<>' '
      use ..\norja\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_nor)
      if found()
        lc_found=.t.
      endif
    case ncsp_koo.code_est<>' '
      use ..\eesti\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_est)
      if found()
        lc_found=.t.
      endif
    case ncsp_koo.code_eng<>' '
      use ..\eesti\ncsp_koo alias ncsp_sec
      set order to code
      seek trim(ncsp_koo.code_eng)
      if found()
        lc_found=.t.
      endif
    endcase
    if lc_found
      select report
      replace report.mapped with ncsp_sec.ncsp
    endif
    if report.mapped=' '
      select report
      replace report.mapped with '_MISSED'
    endif
  endif
  select ncsp_koo
  skip
enddo
select report
set order to code
replace all c1 with substr(code,1,1)
replace all c2 with substr(code,2,1)
replace all c3 with substr(code,3,1)
replace all c4 with substr(code,4,1)
replace all c5 with substr(code,5,1)
replace all c6 with substr(code,6,1)
do ..\gemens\_ncsp
return
