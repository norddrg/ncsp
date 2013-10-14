Procedure lang_def
SET SAFETY OFF
WAIT WINDOW NOWAIT 'Making textfile copies of all national versions' 
SELECT 0
use ..\suomi\ncsp_koo alias ncsp_sec
SET order to code
COPY TO ..\text\fin_ncsp_koo.txt SDF 
use ..\ruotsi\ncsp_koo alias ncsp_sec
set order to code
COPY TO ..\text\swe_ncsp_koo.txt SDF 
use ..\tanska\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\den_ncsp_koo.txt SDF 
use ..\norja\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\nor_ncsp_koo.txt SDF 
use ..\eesti\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\est_ncsp_koo.txt SDF 
use ..\islanti\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\isl_ncsp_koo.txt SDF 
use ..\englanti\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\eng_ncsp_koo.txt SDF 
use ..\latvia\ncsp_koo alias ncsp_sec
set order to code
set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
COPY TO ..\text\lat_ncsp_koo.txt SDF 
USE
SET SAFETY ON 
public p_kieli 
p_kieli='-'
do while p_kieli='-'
  define popup lansel
  define bar 1 of lansel prompt 'Danish'
  define bar 2 of lansel prompt 'Finish'
  define bar 3 of lansel prompt 'Swedish'
  define bar 4 of lansel prompt 'Norwegian'
  define bar 5 of lansel prompt 'Estonian'
  define bar 6 of lansel prompt 'Icelandic'
  DEFINE BAR 7 OF lansel PROMPT 'Latvian'
  define bar 8 of lansel prompt 'English'
  on selection popup lansel do language with prompt()
  wait window nowait 'Select the language!'
  activate popup lansel at 10,15
  release popup lansel
enddo
do ..\gemens\ncspohje
do ..\gemens\naytto
return

procedure language
parameter lc_lan
on error select 0
select ncsp_sec
use
on error
p_kieli=substr(lc_lan,1,3)
public p_filt
select 0
do case
case p_kieli='Fin'
  use ..\suomi\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_fin) into ncsp_sec
case p_kieli='Swe'
  use ..\ruotsi\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_swe) into ncsp_sec
case p_kieli='Dan'
  use ..\tanska\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_den) into ncsp_sec
case p_kieli='Nor'
  use ..\norja\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_nor) into ncsp_sec
case p_kieli='Est'
  use ..\eesti\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_est) into ncsp_sec
case p_kieli='Ice'
  use ..\islanti\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_ice) into ncsp_sec
case p_kieli='Eng'
  use ..\englanti\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_eng) into ncsp_sec
case p_kieli='Lat'
  use ..\latvia\ncsp_koo alias ncsp_sec
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))))
  select ncsp_koo
  set relation to trim(code_eng) into ncsp_sec
otherwise
  p_kieli='-'
  return
endcase
if not suodatin
  set relation to code into suod additive
endif
do ..\gemens\naytto
deactivate popup lansel
return

procedure sec_sel
select 0
return
