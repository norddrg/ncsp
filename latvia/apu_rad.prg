procedure apu_rad
on error do lisaapu
select radiol
on error
goto top
do while not eof()
  select ncsp_koo
  set order to code
  seek radiol.code
  if found()
    if trim(text)<>trim(radiol.suomi) or trim(radiol.suomi)<>trim(text)
      replace text with radiol.suomi
    endif
    if trim(text_2)<>trim(radiol.ruotsi) or trim(radiol.ruotsi)<>trim(text_2)
      replace text_2 with radiol.ruotsi
    endif
  else 
    insert into ncsp_koo (code, text,text_2, released, chadate, usedate);
    values (radiol.code, radiol.suomi, radiol.ruotsi,.f.,date(), ctod('2004/01/01')) 
  endif
  select radiol
  skip
enddo
select ncsp_koo
goto top
do while not eof()
  if substr(ncsp,3,1)<>'D' or released
    skip
    loop
  endif
  select radiol
  seek trim(ncsp_koo.code)
  if not found()
     if ncsp_koo.code<>'S' and ncsp_koo.code<>'TJK' and ncsp_koo.code<>'X'
      select ncsp_koo
      wait window nowait ncsp_koo.code +' ei löydy radiol-tiedostosta'
      do naytto
      exit
     endif
  endif
  select ncsp_koo
  skip
enddo
return

procedure lisaapu
select 0
USE "c:\data\luokitukset\ncsp\radiologian ruotsinnos 2003.dbf" alias "RADIOL"
set order to code
return