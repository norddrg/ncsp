Procedure imp_finapu
select 0
USE "tp_luok_2014.dbf" alias newtpl
select ncsp_koo
set filter to 
replace all released with .t. for not substr(code,1,2)<'A'
select newtpl
SET FILTER TO LEN(TRIM(tunniste))>4
goto top
do while not eof()
  select ncsp_koo
  seek trim(newtpl.tunniste)
  if found()
    replace released with .f., usedate WITH newtpl.voimassaol
    IF chadate=CTOD(SPACE(9))
      replace chadate WITH newtpl.muutospvm
    ENDIF
    IF newtpl.voimassao1<CTOD('2030/12/31')
      replace reldate WITH newtpl.voimassao1, released WITH .t.
    ELSE 
      replace reldate WITH CTOD(SPACE(8))
    ENDIF 
    if trim(text)<>trim(newtpl.pitk__nimi)or TRIM(newtpl.pitk__nimi)<>TRIM(text)
       replace text with newtpl.pitk__nimi
       replace chadate with newtpl.muutospvm
    ENDIF
    IF TRIM(newtpl.lyhenne) <> TRIM(short)
      replace short WITH newtpl.lyhenne
    ENDIF
    IF LEN(TRIM(ncsp_koo.text_2))=0 AND LEN(TRIM(newtpl.l_ngt_namn))=0 AND newtpl.voimassao1=DATE()+365
      EDIT
      loop
    endif
    IF TRIM(text_2)<>TRIM(newtpl.l_ngt_namn) OR TRIM(newtpl.l_ngt_namn)<>TRIM(text_2) 
      IF LEN(TRIM(newtpl.l_ngt_namn))>0
        replace text_2 WITH newtpl.l_ngt_namn
      endif
    ENDIF   
    IF ncsp_koo.english= ' ' AND newtpl.long_name=' ' AND newtpl.voimassao1=DATE()+365
      EDIT
      loop
    endif
    IF TRIM(english)<>TRIM(newtpl.long_name) OR TRIM(newtpl.long_name)<>TRIM(english) 
      IF LEN(TRIM(newtpl.long_name))>0
        replace english WITH newtpl.long_name
      endif
    ENDIF       
  else
    append blank
    replace code with newtpl.tunniste
    replace text with newtpl.pitk__nimi
    replace text_2 with newtpl.l_ngt_namn
    replace usedate with newtpl.voimassaol
    REPLACE chadate WITH newtpl.muutospvm
    replace short WITH newtpl.lyhenne
    replace english WITH newtpl.long_name
    IF len(TRIM(newtpl.huom_))>0
      replace note WITH newtpl.huom_
    ENDIF 
    IF LEN(TRIM(newtpl.pois_lukie))>0
      IF LEN(TRIM(note))>0
        replace note WITH TRIM(note_2)+' '+newtpl.pois_lukie
      ELSE 
        replace note WITH newtpl.pois_lukie
      ENDIF 
    ENDIF
    IF LEN(TRIM(newtpl.mukaan_luk))>0
      IF LEN(TRIM(note))>0
        replace note WITH TRIM(note_2)+' '+newtpl.mukaan_luk
      ELSE 
        replace note WITH newtpl.mukaan_luk        
      ENDIF 
    ENDIF     

    IF len(TRIM(newtpl.anm_))>0
      replace note_2 WITH newtpl.anm_
    ENDIF 
    IF LEN(TRIM(newtpl.exkluderar))>0
      IF LEN(TRIM(note_2))>0
        replace note_2 WITH TRIM(note_2)+' '+newtpl.exkluderar
      ELSE 
        replace note_2 WITH newtpl.exkluderar
      ENDIF 
    ENDIF
    IF LEN(TRIM(newtpl.inkluderar))>0
      IF LEN(TRIM(note_2))>0
        replace note_2 WITH TRIM(note_2)+' '+newtpl.inkluderar
      ELSE 
        replace note_2 WITH newtpl.inkluderar        
      ENDIF 
    ENDIF     

  *  IF len(TRIM(newtpl.note))>0
  *    replace note_e WITH newtpl.note
  *  ENDIF 

  ENDIF
  select newtpl
  skip
enddo
select ncsp_koo
set filter to released and reldate=ctod(space(8))
replace all reldate with ctod('2013/12/31')
return