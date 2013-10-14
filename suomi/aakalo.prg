procedure aakalo

lc_ncsp=ncsp
on error do apualo
release window apu
on error

activate window valikko
clear
@ 2,2 say 'NCSP Suomen versio'
@ 3,2 say 'Aakkosellisen hakemiston tarkastelu'
@ 5,2 say '[Ctrl][F6] - tyhjent‰‰ tiedoston ja k‰ynnist‰‰ uuden version muodstuksen'
@ 6,2 say '[F12] - editoi aktuellia rivi‰'
@ 7,2 say '[Alt][F12] - merkitsee sanan ei aakkostettavien listaan'
@ 8,4 say 'Merkkin‰ siirrosta t‰h‰n listaan tulee deletoitu merkki!'
@ 9,2 say '[Ctrl][F12] - tarkastelee ei aakkostettavien listaa'
@ 10,4 say 'Sana voidaan palauttaa aakostettavaksi merkitsem‰ll‰ se deletoiduksi'
@ 12,4 say 'N‰m‰ muutokset tulevat voimaan kun aakkostus suoritetaan uudestan [Ctrl][F6]'

@ 14,2 say '[F10] - Vaihda esitysj‰rjestys aakkosellinen/koodien mukainen'
@ 15,2 say '[Alt][F] - Sanahaku'
@ 16,2 say '[F9] - n‰yt‰ kaikki/n‰yt‰ deletoimattomat'

@ 17,2 say '[Alt][F6] - kopio muutoksen scand-kentt‰‰n'
@ 18,2 say '[F6] - paluu normaalitilaan'
@ 19,2 say '[F5] - Ventura tiedoston mudostaminen'

@ 21,2 SAY '[Ctrl][F1] - ohjelman lopetus Foxiin'
@ 22,2 SAY '[Alt][F1] - ohjelman uudelleen k‰ynnistys'

on key label alt+F12 
ON KEY LABEL f11 
ON KEY LABEL ctrl+f11 
on key label f10 do aakjarj

ON KEY LABEL f9 
ON KEY LABEL ctrl+f9

on key label F5 do aakvent

ON KEY LABEL f8 
ON KEY LABEL ctrl+f8 
ON KEY LABEL f7 
On key label ctrl+s 
on key label alt+s 
on key label ctrl+r 
on key label alt+r 
on key label alt+n 
ON KEY LABEL alt+x 
on key label ctrl+e 
ON KEY LABEL ctrl+p 
On key label ctrl+l 
on key label alt+l 
on key label alt+f 
ON KEY LABEL alt+f1 
ON KEY LABEL ctrl+f1 

on key label F6 do aaklop
on key label ctrl+f6 do aakkos
on key label alt+F6 do aakscand

on key label alt+f do aakhaku

on key label f9 do aakfilt
on key label F12 do aakedit
on key label alt+F12 do sanasiir
on key label Ctrl+F12 do sananay


DEFINE WINDOW aakkos FROM 0,30 TO max_y,max_x FONT  max_foty,  max_fosi
activate window aakkos

on error do sanavaus
select sanat
on error
set order to sana

on error do hakavaus
select ncsp_hak
on error
set filter to not deleted()
set order to ncsp
seek lc_ncsp
set order to haku

browse fields alkuosa=trim(alku):40, hakuosa=trim(haku):15, loppuosa= trim(loppu):40, code, ncsp, kieli save nowait window aakkos noedit nodelete
return

procedure hakavaus
select 0
use ncsp_hak
return

procedure sanavaus
select 0
use sanat
return

procedure apualo
return
