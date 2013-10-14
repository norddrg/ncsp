procedure ansncsp
  set talk off
  set console off
select ncsp_luv
set filter to 
select ncsp_ryh
set filter to 
select ncsp_ala
set filter to 
select ncsp_koo
set memowidth to 256
set filter to 
select ncsp_luv 
set order to ncsp
select ncsp_ryh
set order to ncsp
select ncsp_ala
set order to ncsp
select ncsp_koo
set order to ncsp
goto top
old_luv=space(1)
old_ryh=space(2)
old_ala=space(4)
old_koo=space(6)
select 0
set printer off
lc_print='NCSP_ANS.TXT'
set printer to (lc_print)
set printer on
  ?? '##'
  ?? 'koodi;'
  ?? 'suomi;'
  ?? 'ruotsi;'
  ?? 'englanti;'
  ?? 'lyhyt;'
  ?? 'ohje_s;'
  ?? 'ohje_r;'
  ?? 'käyttöönottopvm;'
  ?? 'poistopvm;'
  ?? 'korvaava_koodi;'
  ?? 'ncps_plus_koodi'

select ncsp_koo
do WHILE not eof()
  apucode=ncsp
  if apucode=' '
    skip
    loop
  endif
  if substr(apucode,1,1)<>old_luv
    select ncsp_luv
    seek substr(apucode,1,1)
    wait window nowait code+' '+trim(text)
    ? '##'
    ?? trim (code)+';'
    ?? trim(text)+';'
    ?? trim (text_2)+';'
    ?? trim(english)+';'
    ?? trim(short)+';'
    ?? trim(note)+';'
    ?? note_2+';'
    ?? usedate
    ?? ';'
    ?? reldate
    ?? ';'
    ?? ' ;'
    ?? trim(ncsp)
    old_luv=trim(ncsp_luv.ncsp)
  endif
  select ncsp_koo
  if substr(apucode,1,2)<>old_ryh
    select ncsp_ryh
    seek substr(apucode,1,2)
    if found() 
      ? '##'
      ?? trim (code)+';'
      ?? trim(text)+';'
      ?? trim (text_2)+';'
      ?? trim(english)+';'
      ?? trim(short)+';'
      ?? trim(note)+';'
      ?? note_2+';'
      ?? usedate
      ?? ';'
      ?? reldate
      ?? ';'
      ?? ' ;'
      ?? trim(ncsp)
      old_ryh=trim(ncsp_ryh.ncsp)
    endif
  endif
  select ncsp_koo
  if old_ala<>substr(apucode,1,4)
    select ncsp_ala
    seek substr(apucode,1,4)
    if not found()
      seek substr(apucode,1,3)
    endif
    if found() and old_ala<>trim(ncsp)
      ? '##'
      ?? trim (code)+';'
      ?? trim(text)+';'
      ?? trim (text_2)+';'
      ?? trim(english)+';'
      ?? trim(short)+';'
      ?? trim(note)+';'
      ?? note_2+';'
      ?? usedate
      ?? ';'
      ?? reldate
      ?? ';'
      ?? ' ;'
      ?? trim(ncsp)
      old_ala = trim(ncsp_ala.ncsp)
    endif
  endif
  select ncsp_koo
  ? '##'
  ?? trim (code)+';'
  ?? trim(text)+';'
  ?? trim (text_2)+';'
  ?? trim(english)+';'
  ?? trim(short)+';'
  ?? trim(note)+';'
  ?? note_2+';'
  ?? usedate 
  ?? ';'
  ?? reldate
  ?? ';'
  ?? ncsp_koo.subst+';'
  ?? trim(ncsp)
  old_koo=ncsp
  select ncsp_koo
  skip
enddo
set printer off
set printer to
set console on
set talk on
set memowidth to 50
select ncsp_koo
set order to code
do ncsp
return
