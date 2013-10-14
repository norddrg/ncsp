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
procedure apuvent
  set talk off
  set console off
define window apu from 5,5 to 15,60 font max_foty, max_fosi
activate window apu
ve_laji=space(10)
@ 2,1 say 'Tulostetaanko kaikki koodit, erityisalan koodit vai muutetut koodit?'
@ 3,1 get ve_laji picture '@M kaikki, erityis, muutetut'
read
ve_pvm=ctod(str(year(date()),4)+'/01/01')
if ve_laji='muutetut'
  clear
  @2,1 say 'Anna päivämäärä, jonka jälkeen tehdyt muutokset listataan'
  @ 3,1 get ve_pvm 
  read
endif
release window apu
if ve_laji='erityis'
  select ncsp_luv
  set filter to not released and suod.suod
  select ncsp_ryh
  set filter to not released and suod.suod
  select ncsp_ala
  set filter to not released and suod.suod
  select ncsp_koo
  set memowidth to 256
  lc_order=order()
  public p_posit
  p_posit = code
  suodatin=.t.
  select ncsp_koo
  set filter to not released
  set relation to
  set order to code
  select suod
  set filter to not deleted() and suod
  set relation to code into ncsp_koo
  set skip to ncsp_koo
  seek (p_posit)
  set order to (lc_order)
endif
if ve_laji='kaikki'
  select ncsp_luv
  set filter to not released
  select ncsp_ryh
  set filter to not released
  select ncsp_ala
  set filter to not released
  select ncsp_koo
  set memowidth to 256
  set filter to not released
  goto top
endif
if ve_laji='muutetut'
  select ncsp_luv 
  set filter to 
  select ncsp_ryh
  set filter to 
  select ncsp_ala
  set filter to  
  select ncsp_koo
  set memowidth to 256
  set filter to (chadate>ve_pvm or reldate>ve_pvm) and not deleted()
  goto top
endif
old_3=space(3)
old_2=space(2)
old_1=space(5)
select 0
set printer off
do case
case ve_laji='erityis'
  lc_print='..ventura\VEN_'+aktfilt+'.TXT'
case ve_laji='kaikki'
  lc_print='..\ventura\VEN_KAIK.TXT'
case ve_laji='muutetut'
  lc_print='..\ventura\VEN_MUUT.TXT'
endcase
set printer to (lc_print)
set printer on 
?? '@PARAFILTR ON ='
?
select ncsp_koo
if ve_laji='erityis'
  select suod
endif
do WHILE not eof()
  if suod.suod and chadate<ctod('1998/11/03')
    skip
    loop
  endif
  apucode=code
  if aktfilt='OTH' and (apucode='T' or apucode='U' or apucode='X')
    apucode=substr(code,2,2)+'Z'+substr(code,4,2)
  endif
  if substr(apucode,1,1)>substr(old_1,1,1)
    select ncsp_luv
    seek substr(apucode,1,1)
    do while typecode<>aktfilt and typecode<>'ZZZ'
      skip
    enddo
    wait window nowait code+' '+trim(text)
    ? '@LUVUT = LUKU '
    ?? trim (code)
    ?
    ? '@LUVUT_S = KAPITEL '
    ?? trim (code)
    ?
    ? '@SUOMI_L = '
    ?? trim(text)
    ?
    ? '@RUOTSI_L = '
    ?? trim (text_2)
    ?
    if english<>' '
      ? '@ENGL_L = '
      ?? trim(english)
      ?
    endif
    select ncsp_luv
    if len(trim(note))>0
      do noexin with 'l', note, 'FI'
    endif
    select ncsp_luv
    if len(trim(note_2))>0
      do noexin with 'l', note_2, 'SW'
    endif
    if usedate>ve_pvm
      ? '@NOTE_LF= Lisätty / tillagt '
      ?? usedate
      ?
    endif
    if reldate>ve_pvm
      ? '@NOTE_LF = Poistettu / deleterad '
      ?? reldate
      ?
      ? '@NOTE_LF = Korvaava koodi tilastokäytösssä / Substituerande kod i statisk bruk '
      ?? ncsp_koo.subst
      ?
    endif
    ? '@END_L = '
    ?
  endif
  select ncsp_koo
  if ve_laji='erityis'
    select suod
  endif
  if substr(apucode,1,2)>old_1
    select ncsp_ryh
    seek substr(apucode,1,2)
    if not found()
      seek substr(ncsp_koo.code,1,2)
    endif
    if found() and substr(code,1,2)<>old_2
      do while typecode<>aktfilt and typecode<>'ZZZ' 
        if eof()
          exit
        endif
        skip
      enddo
      ? '@KOODI_R = '
      ?? trim(code)
      ?
      ? '@SUOMI_R = '
      ?? trim(text)
      ?
      ? '@RUOTSI_R = '
      ?? trim(text_2)
      ?
      if english<>' '
        ? '@ENGL_R = '
        ?? trim(english)
        ?
      endif
      select ncsp_ryh
      if len(trim(note))>0
        do noexin with 'r', note, 'FI'
      endif
      select ncsp_ryh
      if len(trim(note_2))>0
        do noexin with 'r', note_2, 'SW'
      endif
      if usedate>ve_pvm
        ? '@NOTE_RF= Lisätty / tillagt '
        ?? usedate
        ?
      endif
      if reldate>ve_pvm
        ? '@NOTE_RF = Poistettu / deleterad '
        ?? reldate
        ?
        ? '@NOTE_RF = Korvaava koodi tilastokäytösssä / Substituerande kod i statisk bruk '
        ?? ncsp_koo.subst
        ?
      endif
      ? '@END = '
      ?
      old_2=substr(code,1,2)
    endif
  endif
  select ncsp_koo
  if ve_laji='erityis'
    select suod
  endif
  if substr(code,1,3)>old_1
    select ncsp_ala
    seek substr(apucode,1,3)
    if not found()
      seek substr(ncsp_koo.code,1,3)
    endif
    if found() and substr(code,1,3)<>old_3
      old_3=substr(code,1,3)
      do while typecode<>aktfilt and typecode<>'ZZZ' and substr(code,1,3)=old_3
        if eof()
          exit
        endif
        skip
      enddo
      if substr(code,1,3)<>old_3
        skip -1
      endif
      ? '@KOODI_A = '
      ?? trim(code)
      ?
      ? '@SUOMI_A = '
      ?? trim(text)
      ?
      ? '@RUOTSI_A = '
      ?? trim (text_2)
      ?
      if english<>' '
        ? '@ENGL_A = '
        ?? trim(english)
        ?
      endif
      select ncsp_ala
      if len(trim(note))>0
        do noexin with 'r', note, 'FI'
      endif
      select ncsp_ala
      if len(trim(note_2))>0
        do noexin with 'r', note_2, 'SW'
      endif
      if usedate>ve_pvm
        ? '@NOTE_AF= Lisätty / tillagt '
        ?? usedate
        ?
      endif
      if reldate>ve_pvm
        ? '@NOTE_AF = Poistettu / deleterad '
        ?? reldate
        ?
        ? '@NOTE_AF = Korvaava koodi tilastokäytösssä / Substituerande kod i statisk bruk '
        ?? ncsp_koo.subst
        ?
      endif
      ? '@END = '
      ?
      old_3=substr(code,1,3)
    endif
  endif
  select ncsp_koo
  ? '@KOODI = '
  ?? code
  ?
  if aktfilt='KIR' and ve_laji='erityis' 
    ? '@VANHA = '
    ?? trim(oldcode)
    ?
  endif
  ? '@SUOMI = '
  ?? trim(text)
  ?
  ? '@RUOTSI = '
  ?? trim(text_2)
  ?
  if usedate>ve_pvm
    ? '@NOTE_F= Lisätty / tillagt '
    ?? usedate
    ?
  endif
  if reldate>ve_pvm
    ? '@NOTE_F = Poistettu / deleterad '
    ?? reldate
    ?
    ? '@NOTE_F = Korvaava koodi tilastokäytösssä / Substituerande kod i statisk bruk '
    ?? ncsp_koo.subst
    ?
  endif
  select ncsp_koo
  if len(trim(note))>0
    do noexin with 'k', note, 'FI'
  endif
  select ncsp_koo
  if len(trim(note_2))>0
    do noexin with 'k', note_2, 'SW'
  endif
  old_1=code
  if  aktfilt='OTH' and (code='T' or code='U' or code='X')
    old_1=substr(code,2,2)+"Z"+substr(code,4,2)
  endif
  ? '@END = '
  ?
  select ncsp_koo
  if ve_laji='erityis'
    select suod
  endif
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
