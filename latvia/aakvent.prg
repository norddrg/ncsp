PROCEDURE aakvent
lc_suod=space(10)
*@ 1,0 say 'Tulostetaanko kaikki vai suodattimeen valitut koodit?'
*@ 2,0 get lc_suod picture '@M, Kaikki, Suodat.'
*read
lc_s=.f.
*if lc_suod='S'
*  lc_s=.t.
*endif
lc_print='..\ventura\VEN_AAK.TXT'
set printer to (lc_print)
set printer on
?? '@PARAFILTR ON ='
select 0
use ncsp_hak
set order to haku
GOTO TOP
av_kir=' '
lc_time=seconds()
lc_n=0
lc_ns=0
DO WHILE NOT EOF()
   if deleted()
      skip
      loop
   endif
   if kieli='E' 
     skip
     loop
   endif
   lc_n=lc_n+1
   IF UPPER(SUBSTR(scand,1,1))<>av_kir 
      av_kir=UPPER(substr(scand,1,1))
      set printer off
      set printer to
      lc_print='..\ventura\AAK_'+av_kir+'.TXT'
      set printer to (lc_print)
      set printer on
      ?? '@PARAFILTR ON ='
      wait window nowait 'Aakkosellinen hakemisto '+av_kir
      ?
      ? '@LETTER = '
      ?? av_kir
      ?
      ? '@END = '
   ENDIF
   ?
   if tyyppi<>' '
     ? '@HEADKOO = '
   else
     ? '@KOO = '
   endif
   ?? trim(code)
   if tyyppi=' ' or tyyppi = 'A'
     ?
     ? '@NCSP = '
     ?? ncsp
   endif
   ? 
   ? '@NIMI_AL= '
   ?? alut(trim(alku))
   ?
   ? '@NIMI_HAK= '
   ?? trim(trim(haku))
   ?
   ? '@NIMI_LO= '
   ?? trim(loppu)
   ?
   ? '@END= '
   select ncsp_hak
   skip
ENDDO
select ncsp_hak
use
SET PRINTER OFF
SET PRINTER TO
SET CONSOLE ON
SET TALK ON
SET MEMOWIDTH TO 50
wait window str(lc_n)
RETURN



Function alut
parameter alkustr
u_alku=trim(alkustr)
if substr(alkustr,len(alkustr),1)='(';
or substr(alkustr,len(alkustr),1)=')';
or substr(alkustr,len(alkustr),1)='[';
or substr(alkustr,len(alkustr),1)=']';
or substr(alkustr,len(alkustr),1)='-';
or substr(alkustr,len(alkustr),1)='"';
or substr(alkustr,len(alkustr),1)="'";
or substr(alkustr,len(alkustr),1)='/';
or substr(alkustr,len(alkustr),1)='+';
or substr(alkustr,len(alkustr),1)=';';
or substr(alkustr,len(alkustr),1)=':';
or substr(alkustr,len(alkustr),1)='.'
  u_alku=trim(alkustr)
else
  if len(trim(alkustr))>0
    u_alku=trim(alkustr)+' '
  endif
endif
return u_alku

Procedure valinta
parameter valkiel
FOR gnCount = 1 TO CNTBAR('kielet')
  IF MRKBAR('kielet', gnCount) = .T.
    if PRMBAR('kielet', gnCount)='S'
      p_suomi=.t.
    endif
    if PRMBAR('kielet', gnCount)='R'
      p_ruotsi=.t.
    endif
    if PRMBAR('kielet', gnCount)='L'
      p_latina=.t.
    endif
    if PRMBAR('kielet', gnCount)='E'
      p_englanti=.t.
    endif
    if prmbar('kielet', gnCount)='V'
      deactivate popup kielet
    endif
  endif
ENDFOR
return
*: EOF: VENTTUL.PRG
