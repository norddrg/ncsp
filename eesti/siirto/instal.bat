echo off
type a:read.me|more 
pause
echo T�m� ohjelma purkaa tiedostossa NCSP_S.ZIP olevan suomalaisen ICD-10 
echo tietokannan version siihen hakemistoon josta k�ynnistit ohjelman.
echo Tarvitset tilaa riippuen tiedostomuodosta edell� esitetyn m��r�n.
Echo *
echo Jos olet k�ynnist�nyt ohjelman levykeasemasta (A tai B) purkaminen ei
echo onnistu!
echo *
echo Jos kaikki ei ole kunnossa, paina [Ctrl][C]
pause
echo on
a:pkunzip /d a:/NCSP_S.zip
