*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\SIIRMUUN.PRG
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
*:   siirmuun
*!******************************************************************************
*!
*! Procedure SIIRMUUN
*!
*!  Calls
*!      deleted
*!      eof
*!      found
*!      len
*!      ncsp
*!      space
*!      substr
*!      to
*!      trim
*!      values
*!
*!******************************************************************************
procedure siirmuun
  set talk off
  set console off
  select 0
  use siirstr.dbf
  set safety off
  copy to siirto\ncsp
  copy to siirto\ncsp_db4;
  fields code, type, text, text_2, short, english, usedate, chadate, reldate, released, subst, suod.old, ncsp, suod.price;
  type foxplus
  set safety on
  use siirto\ncsp
  select ncsp_luv
  set filter to not deleted()
  select ncsp_ryh
  set filter to not deleted()
  select ncsp_ala
  set filter to not deleted()
  select ncsp_koo
  set memowidth to 256
  set filter to not deleted()
  goto top
  oldkoodi=space(5)
  do WHILE not eof()
    if substr(code,1,1)>oldkoodi
      select ncsp_luv
      seek substr(ncsp_koo.code,1,1)
      set printer off
      wait window nowait code+' '+trim(text)
      lc_print='siirto\L_'+trim(ncsp_luv.code)+'.txt'
      set printer to (lc_print)
      set printer on
      ? '###'
      ? '#KOODI_L  '
      ?? trim (code) at 12
      ? '#MUUT_PVM '
      ?? chadate at 12
      ? '#KAYTPVM '
      ?? usedate at 12
      ? '#POISTPVM'
      ?? reldate at 12
      if released
        ? '#POISTETTU'
      endif
      ? '#SUOMI  '
      ?? trim(text) at 12
      ? '#RUOTSI '
      if len(trim(text_2)) >0
        ?? trim(text_2) at 12
      else
        ?? '---' at 12
      endif
      ? '#ENGL  '
      ?? trim(english) at 12
      insert into ncsp (code, type, text, text_2, english, usedate, chadate, reldate, released, note, note_2);
      values (ncsp_luv.code, 'L', ncsp_luv.text, ncsp_luv.text_2, ncsp_luv.english, ncsp_luv.usedate,; 
      ncsp_luv.chadate, ncsp_luv.reldate, ncsp_luv.released, ncsp_luv.note, ncsp_luv.note_2)
      select ncsp_luv
      if len(trim(note))>0 or len(trim(note_2))>0
        ? '#OHJE_S  '
        ? trim(note)
        ? '#OHJE_R '
        if len(trim(note_2))>0
          ? trim(note_2)
        else
          ? '---'
        endif
      endif
    endif
    select ncsp_koo
    if substr(code,1,2)>oldkoodi
      select ncsp_ryh
      seek substr(ncsp_koo.code,1,2)
      if found()
        ? '###'
        ? '#KOODI_R  '
        ?? trim(code) at 12
        ? '#MUUT_PVM '
        ?? chadate at 12
        ? '#KAYTPVM '
        ?? usedate at 12
        ? '#POISTPVM'
        ?? reldate at 12
        if released
          ? '#POISTETTU'
        endif
        ? '#SUOMI  '
        ?? trim(text) at 12
        ? '#RUOTSI '
        if len(trim(text_2)) >0
          ?? trim(text_2) at 12
        else
          ?? '---' at 12
        endif
        ? '#ENGL  '
        ?? trim(english) at 12
        insert into ncsp (code, type, text, text_2, english, usedate, chadate, reldate, released, note, note_2);
        values (ncsp_ryh.code, 'R', ncsp_ryh.text, ncsp_ryh.text_2, ncsp_ryh.english, ncsp_ryh.usedate,; 
        ncsp_ryh.chadate, ncsp_ryh.reldate, ncsp_ryh.released, ncsp_ryh.note, ncsp_ryh.note_2)
        select ncsp_ryh
        if len(trim(note))>0 or len(trim(note_2))>0
          ? '#OHJE_S  '
          ? trim(note)
          ? '#OHJE_R '
          if len(trim(note_2))>0
            ? trim(note_2)
          else
            ? '---'
          endif
        endif
      endif
    endif
    select ncsp_koo
    if substr(code,1,3)>oldkoodi
      select ncsp_ala
      seek substr(ncsp_koo.code,1,3)
      if found()
        ? '###'
        ? '#KOODI_A  '
        ?? trim(code) at 12
        ? '#MUUT_PVM '
        ?? chadate at 12
        ? '#KAYTPVM '
        ?? usedate at 12
        ? '#POISTPVM'
        ?? reldate at 12
        if released
          ? '#POISTETTU'
        endif
        ? '#SUOMI  '
        ?? trim(text) at 12
        ? '#RUOTSI '
        if len(trim(text_2))>0
          ?? trim(text_2) at 12
        else
          ?? '---' at 12
        endif
        ? '#ENGL  '
        ?? trim(english) at 12
        insert into ncsp (code, type, text, text_2, english, usedate, chadate, reldate, released, note, note_2);
        values (ncsp_ala.code, 'A', ncsp_ala.text, ncsp_ala.text_2, ncsp_ala.english, ncsp_ala.usedate,; 
        ncsp_ala.chadate, ncsp_ala.reldate, ncsp_ala.released, ncsp_ala.note, ncsp_ala.note_2)
        select ncsp_ala
        if len(trim(note))>0 or len(trim(note_2))>0
          ? '#OHJE_S  '
          ? trim(note)
          ? '#OHJE_R '
          if len(trim(note_2))>0
            ? trim(note_2)
          else
            ? '---'
          endif
        endif
      endif
    endif
    select ncsp_koo
    ? '###'
    ? '#KOODI  '
    ?? code at 12
    ? '#MUUT_PVM '
    ?? chadate at 12
    ? '#KAYTPVM '
    ?? usedate at 12
    ? '#POISTPVM'
    ?? reldate at 12
    if released
      ? '#POISTETTU'
    endif
    ? '#VANHA  '
    ?? oldcode at 12
    ? '#SUOMI  '
    ?? trim(text) at 12
    ? '#RUOTSI '
    if len(trim(text_2))>0
      ?? trim(text_2) at 12
    else
      ?? '---' at 12
    endif
    ? '#LYHENNE '
    ?? trim(short) at 12
    insert into ncsp (code, type, text, text_2, english, short, usedate, chadate, reldate, released, subst, ncsp, note, note_2, old_csp);
    values (ncsp_koo.code, ' ', ncsp_koo.text, ncsp_koo.text_2, ncsp_koo.english, ncsp_koo.short, ncsp_koo.usedate,; 
    ncsp_koo.chadate, ncsp_koo.reldate, ncsp_koo.released, ncsp_koo.subst, ncsp_koo.ncsp,; 
    ncsp_koo.note, ncsp_koo.note_2, suod.old)
    if len(trim(note))>0 or len(trim(note_2))>0
      ? '#OHJE_S  '
      ? trim(note)
      ? '#OHJE_R '
      if len(trim(note_2))>0
        ? trim(note_2)
      else
        ? '---'
      endif
    endif
    oldkoodi=code
    select ncsp_koo
    skip
  enddo
  set printer off
  set printer to
  set console on
  set talk on
  set memowidth to 50
  set safety off
  select ncsp
  wait window 'Kopiointi SDF-tiedostoon' nowait
  copy to siirto\ncsp_ans.txt type sdf;
  fields code, type, text, text_2, short, english, usedate, chadate, reldate, released, subst, oldcode, ncsp
  set safety on
  erase siirto\ncsp_asc.txt
  lc_loop=.t.
  use siirto\ncsp_db4
*  on error loop
  do WHILE lc_loop
    wait window 'Tallenna tiedosto NCSP_ANS.TXT (C:\DATA)ASCII muodossa nimellä NCSP_ASC.TXT'
    wait window 'Teitkö muutoksen?'
    append from siirto\ncsp_asc.txt type sdf
    exit
  enddo
  select ncsp_db4
  browse
  use
  select ncsp_koo
  wait window 'Valmis, kiitos kärsivällisyydestä' nowait
  do ..\ruotsi\ncsp
  return
