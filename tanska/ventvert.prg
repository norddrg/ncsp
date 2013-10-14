*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\VENTVERT.PRG
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
*:   ventvert
*!******************************************************************************
*!
*! Procedure VENTVERT
*!
*!  Calls
*!      at
*!      chr
*!      deleted
*!      eof
*!      len
*!      not
*!      space
*!      substr
*!      to
*!      trim
*!      upper
*!
*!******************************************************************************
procedure ventvert
  on error do ncspavaus
  select ncsp_en
  on error
  set order to code_f
  set filter to not deleted()
  goto top
  set console off
  set printer off
  lc_print='\data\ncsp\ventura\NCSP_VER.txt'
  set printer to (lc_print)
  set printer on
  ?? '@PARAFILTR ON ='
  ?
  lc_ed=space(5)
  lc_english=space(200)
  do WHILE not eof()
    lc_ots=.t.
    do CASE
    case len(trim(code))=1
      wait window nowait code+' '+trim(english)
      ? '@CHAPT_E = CHAPTER '
      ?? trim (code)
      ?
      ? '@ENGL_C = '
      ?? trim(english)
      ?
      ? '@CHAPT_F = LUKU '
      ?? trim(code_f)
      ?
      ? '@FIN_C = '
      ?? trim(finish)
      ?
      if len(trim(danish))>0
        ? '@CHAPT_D = KAPITEL '
        ?? trim(code_d)
        ?
        ? '@DAN_C = '
        ?? trim(danish)
        ?
      endif
      if len(trim(swedish))>0
        ? '@CHAPT_S = KAPITEL '
        ?? trim(code_s)
        ?
        ? '@SWE_C = '
        ?? trim(swedish)
        ?
      endif

    case len(trim(code))=2
      ? '@GRP_E = '
      ?? trim (code)
      ?
      ? '@ENGL_G = '
      ?? trim(english)
      ?
      ? '@GRP_F = '
      ?? trim(code_f)
      ?
      ? '@FIN_G = '
      ?? trim(finish)
      ?
      if len(trim(danish))>0
        ? '@GRP_D = '
        ?? trim(code_d)
        ?
        ? '@DAN_G = '
        ?? trim(danish)
        ?
      endif
      if len(trim(swedish))>0
        ? '@GRP_S = '
        ?? trim(code_s)
        ?
        ? '@SWE_G = '
        ?? trim(swedish)
        ?
      endif

    case len(trim(code))=3 and lc_ed<>code
      ? '@SUB_E = '
      ?? trim (code)
      ?
      ? '@ENGL_S = '
      ?? trim(english)
      ?
      ? '@SUB_F = '
      ?? trim(code_f)
      ?
      ? '@FIN_S = '
      ?? trim(finish)
      ?
      if len(trim(danish))>0
        ? '@SUB_D = '
        ?? trim(code_d)
        ?
        ? '@DAN_S = '
        ?? trim(danish)
        ?
      endif
      if len(trim(swedish))>0
        ? '@SUB_S = '
        ?? trim(code_s)
        ?
        ? '@SWE_S = '
        ?? trim(swedish)
        ?
      endif
    otherwise
      lc_ots=.f.
      ? '@COD_E = '
      ?? trim (code)
      ?
      ? '@ENGL = '
      if not (ncsp and english=lc_english)
        ?? trim(english)
        ?
      endif
      ? '@COD_F = '
      ?? trim(code_f)
      ?
      ? '@FIN = '
      ?? trim(finish)
      ?
      if len(trim(danish))>0
        ? '@COD_D = '
        ?? trim(code_d)
        ?
        ? '@DAN = '
        ?? trim(danish)
        ?
      endif
      if len(trim(swedish))>0
        ? '@COD_S = '
        ?? trim(code_s)
        ?
        ? '@SWE = '
        ?? trim(swedish)
        ?
      endif
    endcase
    if not sur
      ? '@ONK = '
      ?
    else
      if not ncsp
        ? '@NCSP ='
        ?
      endif
    endif
    if lc_ots
      ? '@SEUR_OTS = '
      ?
    else
      ? '@SEURAAVA = '
      ?
    endif
    select ncsp_en
    lc_ed=code
    lc_english=english
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
  do ncsp
  return

*!******************************************************************************
*!
*! Procedure NOEXIN
*!
*!  Calls
*!      at
*!      chr
*!      deleted
*!      eof
*!      len
*!      not
*!      space
*!      substr
*!      to
*!      trim
*!      upper
*!
*!******************************************************************************
procedure noexin
* Ei käytössä
  parameter nei_lri, nei_note
  nei_loop =.t.
  nei_n=0
  do WHILE nei_loop
    nei_n=nei_n+1
    do CASE
    case nei_lri='l'
      nei_text='@NOTE_LS = '
      select ncsp_luv
    case nei_lri='r'
      nei_text= '@NOTE_RS = '
      select ncsp_ryh
    case nei_lri='a'
      nei_text= '@NOTE_AS = '
      select ncsp_ala
    case nei_lri='k'
      nei_text= '@NOTE_S = '
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

*!******************************************************************************
*!
*! Procedure NCSPAVAUS
*!
*!  Calls
*!      at
*!      chr
*!      deleted
*!      eof
*!      len
*!      not
*!      space
*!      substr
*!      to
*!      trim
*!      upper
*!
*!******************************************************************************
procedure ncspavaus
  select 0
  use englanti\ncsp_en
  return
