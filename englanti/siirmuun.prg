procedure siirmuun
  set talk off
  set console off
  select 0
  use siirstr.dbf
  set safety off
  copy to siirto\ncsp
  use siirto\ncsp
  select ncsp_luv
  set filter to not released
  select ncsp_ryh
  set filter to not released
  select ncsp_ala
  set filter to not released
  select ncsp_koo
  set memowidth to 256
  set filter to 
  goto top
  oldkoodi=space(5)
  do WHILE not eof()
    if substr(code,1,1)>oldkoodi
      select ncsp_luv
      seek substr(ncsp_koo.code,1,1)
      insert into ncsp (code, type, text, usedate, chadate, reldate, released, note);
      values (ncsp_luv.code, 'C', ncsp_luv.text, ncsp_luv.usedate,; 
      ncsp_luv.chadate, ncsp_luv.reldate, ncsp_luv.released, ncsp_luv.note)
      select ncsp_luv
    endif
    select ncsp_koo
    if substr(code,1,2)>oldkoodi
      select ncsp_ryh
      seek substr(ncsp_koo.code,1,2)
      if found()
        insert into ncsp (code, type, text, usedate, chadate, reldate, released, note);
        values (ncsp_ryh.code, 'G', ncsp_ryh.text, ncsp_ryh.usedate,; 
        ncsp_ryh.chadate, ncsp_ryh.reldate, ncsp_ryh.released, ncsp_ryh.note)
        select ncsp_ryh
      endif
    endif
    select ncsp_koo
    if substr(code,1,3)>oldkoodi
      select ncsp_ala
      seek substr(ncsp_koo.code,1,3)
      if found()
        insert into ncsp (code, type, text, usedate, chadate, reldate, released, note);
        values (ncsp_ala.code, 'S', ncsp_ala.text, ncsp_ala.usedate,; 
        ncsp_ala.chadate, ncsp_ala.reldate, ncsp_ala.released, ncsp_ala.note)
        select ncsp_ala
      endif
    endif
    select ncsp_koo
    insert into ncsp (code, type, text, short, usedate, chadate, reldate, released, subst, ncsp, note);
    values (ncsp_koo.code, ' ', ncsp_koo.text, ncsp_koo.short, ncsp_koo.usedate,; 
    ncsp_koo.chadate, ncsp_koo.reldate, ncsp_koo.released, ncsp_koo.subst, ncsp_koo.ncsp,; 
    ncsp_koo.note)
    oldkoodi=code
    select ncsp_koo
    skip
  enddo
  select ncsp
  select ncsp_koo
  wait window 'Valmis, kiitos kärsivällisyydestä' nowait
  do ncsp
  return
