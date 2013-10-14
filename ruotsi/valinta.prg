*:******************************************************************************
*:
*: Procedure File E:\DATA\NCSP\VALINTA.PRG
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
*:   valinta
*!******************************************************************************
*!
*! Procedure VALINTA
*!
*!  Calls
*!      space
*!
*!******************************************************************************
procedure valinta
define window apu from 5,5 to 15,30 font max_foty, max_fosi
activate window apu
ve_laji=space(10)
@ 2,1 say 'Mikä osuus tulostetaan?'
@ 3,1 get ve_laji picture '@M kirurgia, onkologia'
read
release window apu
do CASE
case ve_laji='kirurgia'
  laji='K'
case ve_laji='onkologia'
  laji='O'
endcase
do ..\ruotsi\naytto
return
