*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\VENTNCSP.PRG
*:
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:	
*:
*: Documented using Visual FoxPro Formatting wizard version  .05
*:******************************************************************************
*:   ventncsp
*!******************************************************************************
*!
*! Procedure VENTNCSP
*!
*!  Calls
*!      and
*!      at
*!      chr
*!      eof
*!      found
*!      len
*!      space
*!      substr
*!      to
*!      trim
*!      upper
*!
*!******************************************************************************
procedure ventncsp
  set talk off
  set console off
define window apu from 5,5 to 15,30 font max_foty, max_fosi
activate window apu
ve_laji=space(10)
@ 2,1 say 'Mikä osuus tulostetaan?'
@ 3,1 get ve_laji picture '@M kirurgia, onkologia, muu, kaikki'
read
release window apu
if ve_laji='kirurgia'
  ve_laji='KIR'
  select ncsp_luv
  set filter to not poistettu and kir
  select ncsp_ryh
  set filter to not poistettu and kir
  select ncsp_ala
  set filter to not poistettu and kir
  select ncsp_koo
  set memowidth to 256
  set filter to not poistettu and kir
  goto top
endif
if ve_laji='onkologia'
  ve_laji='ONK'
  select ncsp_luv
  set filter to not poistettu and syo
  select ncsp_ryh
  set filter to not poistettu and syo
  select ncsp_ala
  set filter to not poistettu and syo
  select ncsp_koo
  set memowidth to 256
  set filter to not poistettu and syo
  goto top
endif
if ve_laji='muu'
  ve_laji='MUU'
  select ncsp_luv
  set filter to not poistettu and muu
  select ncsp_ryh
  set filter to not poistettu and muu
  select ncsp_ala
  set filter to not poistettu and muu
  select ncsp_koo
  set memowidth to 256
  set filter to not poistettu and muu
  set order to pientpt
  goto top
endif
if ve_laji='kaikki'
  ve_laji='ALL'
  select ncsp_luv
  set filter to not poistettu
  select ncsp_ryh
  set filter to not poistettu
  select ncsp_ala
  set filter to not poistettu
  select ncsp_koo
  set memowidth to 256
  set filter to not poistettu
  goto top
endif
old_3=space(3)
old_2=space(2)
oldkoodi=space(5)
select 0
use englanti\ncsp_en
set order to code
set printer off
lc_print='\data\ncsp\ventura\VEN_'+ve_laji+'.txt'
set printer to (lc_print)
set printer on
?? '@PARAFILTR ON ='
?
select ncsp_koo
do WHILE not eof()
  apukoodi=koodi
  if ve_laji='MUU' and (apukoodi='T' or apukoodi='U' or apukoodi='X')
    apukoodi=substr(koodi,2,2)+'Z'+substr(koodi,4,2)
  endif
  if substr(apukoodi,1,1)>substr(oldkoodi,1,1)
    select ncsp_luv
    seek substr(apukoodi,1,1)
    wait window nowait koodi+' '+trim(nimike)
    ? '@LUVUT = LUKU '
    ?? trim (koodi)
    ?
    ? '@LUVUT_S = KAPITEL '
    ?? trim (koodi)
    ?
    ? '@SUOMI_L = '
    ?? trim(nimike)
    ?
    ? '@RUOTSI_L = '
    ?? trim (nimike_r)
    ?
    select ncsp_en
    loy_e=.f.
    seek (ncsp_luv.koodi)
    if found()
      loy_e=.t.
      ? '@ENGL_L = '
      ?? trim(english)
      ?
    endif
    select ncsp_luv
    if len(trim(note))>0
      do noexin with 'l', note, 'FI'
    endif
    select ncsp_luv
    if len(trim(note_r))>0
      do noexin with 'l', note_r, 'SW'
    endif
    ? '@END_L = '
    ?
  endif
  select ncsp_koo
  if substr(apukoodi,1,2)>oldkoodi
    select ncsp_ryh
    seek substr(apukoodi,1,2)
    if not found()
      seek substr(ncsp_koo.koodi,1,2)
    endif
    if found() and substr(koodi,1,2)<>old_2
      ? '@KOODI_R = '
      ?? trim(koodi)
      ?
      ? '@SUOMI_R = '
      ?? trim(nimike)
      ?
      ? '@RUOTSI_R = '
      ?? trim(nimike_r)
      ?
      select ncsp_en
      loy_e=.f.
      seek (ncsp_ryh.koodi)
      if found()
        loy_e=.t.
        ? '@ENGL_R = '
        ?? trim(english)
        ?
      endif
      select ncsp_ryh
      if len(trim(note))>0
        do noexin with 'r', note, 'FI'
      endif
      select ncsp_ryh
      if len(trim(note_r))>0
        do noexin with 'r', note_r, 'SW'
      endif
      ? '@END = '
      ?
      old_2=substr(koodi,1,2)
      select ncsp_en
    endif
  endif
  select ncsp_koo
  if substr(koodi,1,3)>oldkoodi
    select ncsp_ala
    seek substr(apukoodi,1,3)
    if not found()
      seek substr(ncsp_koo.koodi,1,3)
    endif
    if found() and substr(koodi,1,3)<>old_3
      ? '@KOODI_A = '
      ?? trim(koodi)
      ?
      ? '@SUOMI_A = '
      ?? trim(nimike)
      ?
      ? '@RUOTSI_A = '
      ?? trim (nimike_r)
      ?
      select ncsp_en
      loy_e=.f.
      seek (ncsp_ala.koodi)
      if found()
        loy_e=.t.
        ? '@ENGL_A = '
        ?? trim(english)
        ?
      endif
      select ncsp_ala
      if len(trim(note))>0
        do noexin with 'r', note, 'FI'
      endif
      select ncsp_ala
      if len(trim(note_r))>0
        do noexin with 'r', note_r, 'SW'
      endif
      ? '@END = '
      ?
      old_3=substr(koodi,1,3)
    endif
  endif
  select ncsp_koo
  ? '@KOODI = '
  ?? koodi
  ?? huom
  ?
  if ve_laji='KIR'
    ? '@VANHA = '
    ?? trim(vanha)
    ?
  endif
  ? '@SUOMI = '
  ?? trim(nimike)
  ?
  ? '@RUOTSI = '
  ?? trim(nimike_r)
  ?
  select ncsp_koo
  if len(trim(note))>0
    do noexin with 'k', note, 'FI'
  endif
  select ncsp_koo
  if len(trim(note_r))>0
    do noexin with 'k', note_r, 'SW'
  endif
  oldkoodi=koodi
  if  ve_laji='MUU' and (koodi='T' or koodi='U' or koodi='X')
    oldkoodi=substr(koodi,2,2)+"Z"+substr(koodi,4,2)
  endif
  ? '@END = '
  ?
  select ncsp_koo
  skip
enddo
set printer off
set printer to
set console on
set talk on
set memowidth to 50
select ncsp_en
use
select ncsp_koo
set order to koodi
do ncsp
return

  procedure noexin
    parameter nei_lri, nei_note, nei_kie
    nei_loop =.t.
    nei_n=0
    do WHILE nei_loop
      nei_n=nei_n+1
      do CASE
      case nei_lri='l'
        if nei_kie='FI'
          nei_text='@NOTE_LF = '
        else
          nei_text='@NOTE_LS = '
        endif
        select ncsp_luv
      case nei_lri='r'
        if nei_kie='FI'
          nei_text='@NOTE_RF = '
        else
          nei_text= '@NOTE_RS = '
        endif
        select ncsp_ryh
      case nei_lri='a'
        if nei_kie='FI'
          nei_text='@NOTE_AF = '
        else
          nei_text= '@NOTE_AS = '
        endif
        select ncsp_ala
      case nei_lri='k'
        if nei_kie='FI'
          nei_text='@NOTE_F = '
        else
          nei_text= '@NOTE_S = '
        endif
        select ncsp_koo
      endcase
      if nei_n=1
        nei_a=1
      else
        nei_a=at(chr(13),nei_note,nei_n-1)+1
      endif
      nei_l=at(chr(13),nei_note,nei_n)
      if nei_l=0
        nei_l=10000
      endif
      nei_text=nei_text+substr(nei_note,nei_a,nei_l-nei_a)
      nei_text=upper(substr(nei_text,1,1))+substr(nei_text,2,len(nei_text)-1)
      ? trim(nei_text)
      ?
      if nei_l=10000
        exit
      endif
    enddo
    return


