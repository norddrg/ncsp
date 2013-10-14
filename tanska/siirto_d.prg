Procedure siirto_D
clear all
clear
set talk off
set status on

select 0
USE ncsp_en.dbf
delete all
pack
set order to koodi
select 0
USE apu.dbf

select 0
USE siirto.dbf
select siirto
delete all
pack
append from chaptera.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterb.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterc.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterd.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chaptere.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterf.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterg.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterh.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterj.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterk.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterl.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterm.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chaptern.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterp.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterq.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chaptert.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapteru.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterx.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chaptery.txt TYPE SDF
do siirto2
select siirto
delete all
pack
append from chapterz.txt TYPE SDF
do siirto2
set talk on
select ncsp_da
browse last save nowait
return

procedure siirto2
lc_nimike=space(100)
lc_koodi= space(6)
select siirto
goto top
lc_text=' '
lc_loop=.t.
lc_kasit=space(5)
do while not eof()
   lc_text=teksti(nimi)
   lc_koodi=trim(koodi)
   if len(lc_koodi)=0
     skip
     loop
   endif
   if AT('last digit of', lc_text)>0
      select apu
      delete all
      pack
      select siirto
      skip
      do while lc_loop
          lc_text=teksti(text)
          if len(lc_koodi)>1
            exit
          endif
          lc_nimike= lower(lc_nimike)
          lc_nimike= teksti(lc_nimike)
          INSERT INTO apu (koodi, tanska)  VALUES (lc_koodi, lc_nimike)
          select siirto
          skip
      enddo
      loop
   endif
   if len(koodi) >6
      do while at(' ',lc_koodi)>0
         lc_koodi = substr (lc_koodi,1,at(' ',lc_koodi)-1)+substr(lc_koodi,at(' ',lc_koodi)+1,6)
      enddo
      lc_nimike=teksti(lc_nimike)
   else
      if len(trim(ncsp_en.note_d))=0
        replace ncsp_en.note_d with lc_koodi
      else 
        replace ncsp_en.note_d with trim(ncsp_en.note_d)+chr(13)+lc_koodi
      endif
   endif
   if len(lc_koodi)=5 and (substr(lc_koodi,5,1)='x' or substr(lc_koodi,5,1)='y')
     select apu
     goto top
     do while not eof()
       lc_koodi=substr(lc_koodi,1,4)+substr(apu.koodi,1,1)
       lc_yhd=trim(lc_nimike)+'; '+apu.tanska
       select ncsp_en
       seek lc_koodi
       if not found()
           INSERT INTO ncsp_en (koodi, tanska)  VALUES (lc_koodi, lc_yhd)
       endif
       select apu
       skip
     enddo
   else
     if len(lc_koodi)>1 and substr(lc_koodi,2,1)='x'
       select apu
       goto top
       do while not eof()
         lc_koodi=substr(lc_koodi,1,1)+substr(apu.koodi,1,1)+substr(lc_koodi,3,3)
         lc_yhd=trim(lc_nimike)+'; '+apu.tanska
         select ncsp_en
         seek lc_koodi
         if not found()
           INSERT INTO ncsp_en (koodi, tanska)  VALUES (lc_koodi, lc_yhd)
         endif
         select apu
         skip
       enddo
     else
       select ncsp_en
       seek lc_koodi
       if not found()
         INSERT INTO ncsp_en (koodi, tanska)  VALUES (lc_koodi, lc_nimike)    
       endif
     endif
   endif  
   if len(lc_koodi)<5 
     lc_kasit=lc_koodi
   endif
   select siirto
   skip
enddo
return

Function teksti
parameter loc_text
do while asc(loc_text)=9
  loc_text=substr(loc_text,2,200)
enddo
loc_text=rtrim(ltrim(loc_text))
return loc_text
