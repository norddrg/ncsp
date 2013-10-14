Procedure siirto
clear all
use ncsp
set order to koodi
delete all
pack
select 0
set safety off
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM abc.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM de.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM f.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM gh.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM j.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM k.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM lm.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM n.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM p.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM q.txt TYPE DELIMITED WITH TAB
do vaihe2
use luku_str.dbf 
copy to luku.dbf
use luku.dbf 
APPEND FROM xyz.txt TYPE DELIMITED WITH TAB
do vaihe2
set safety on
return

Procedure vaihe2
select luku
goto top
do while not eof()
  if no1<1
    skip
    loop
  endif
  lc_koodi=space(5)
  lc_nimike=space(150)
  lc_vanha=space(6)
  lc_type=space(1)
  replace lu_koodi with ltrim(lu_koodi)
  if upper(substr(lu_koodi,1,4)) = 'LUKU'
    lc_koodi=substr(lu_koodi,6,1)+space(4)
    skip
    do while lu_koodi=space(150)
      skip
    enddo
    lc_nimike=lu_koodi
    lc_type='L'
  endif
  if lu_nimi<>space(89)
    lc_koodi=substr(lu_koodi,1,5)
    lc_nimike=lu_nimi
    lc_type='P'
  endif
  if ry_nimi<>space(150)
    lc_koodi=ry_koodi+space(2)
    lc_nimike=ry_nimi
    lc_type='A'
  endif
  if koodi_al<>space(3)
    lc_koodi=koodi_al+koodi_lo
    lc_nimike=nimi
    if ""=trim (lc_nimike)
      lc_nimike=apu
    endif
    lc_type='K'
    lc_vanha=apu1
    if lc_vanha<apu2
      lc_vanha=apu2
    endif
    if lc_vanha<apu3
      lc_vanha=apu3
    endif
    if lc_vanha<apu4
      lc_vanha=apu4
    endif
    if lc_vanha<apu5
      lc_vanha=apu5
    endif
    if lc_vanha<apu6
      lc_vanha=apu6
    endif
    if lc_vanha<apu7
      lc_vanha=apu7
    endif
  endif
  select ncsp
  if lc_koodi<>space(5)
    seek (lc_koodi)
    if not found()
      append blank
      replace koodi with lc_koodi
      replace nimike with lc_nimike
      replace type with lc_type
      replace vanha with lc_vanha
    endif
  endif
  select luku
  if luku.note<>space(250)
    if len(trim(ncsp.note))>0
      replace ncsp.note with ncsp.note+chr(13)+trim(luku.note)
    else
      replace ncsp.note with trim(luku.note)
    endif
  endif
  select luku
  skip
  loop
enddo
select luku
return