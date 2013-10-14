Procedure apu_siir
select 0
use tmpluok20041.dbf alias paiv
set order to ncsp_plu

select ncsp_luv
set filter to not released
goto top
do while not eof()
  select paiv
  seek ncsp_luv.ncsp
  if found()
    replace suomi with ncsp_luv.text, ruotsi with ncsp_luv.text_2
  endif
  select ncsp_luv
  skip
enddo

select ncsp_ryh
set filter to not released
goto top
do while not eof()
  select paiv
  seek ncsp_ryh.ncsp
  if found()
    replace suomi with ncsp_ryh.text, ruotsi with ncsp_ryh.text_2
  endif
  select ncsp_ryh
  skip
enddo

select ncsp_ala
set filter to not released
goto top
do while not eof()
  select paiv
  seek ncsp_ala.ncsp
  if found()
    replace suomi with ncsp_ala.text, ruotsi with ncsp_ala.text_2
  endif
  select ncsp_ala
  skip
enddo

select ncsp_koo
set filter to not released
goto top
do while not eof()
  select paiv
  seek ncsp_koo.ncsp
  if found()
    replace suomi with ncsp_koo.text, ruotsi with ncsp_koo.text_2
  endif
  select ncsp_koo
  skip
enddo

return
