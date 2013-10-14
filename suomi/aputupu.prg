procedure aputupu
select apu_tupu
goto top
do while not eof()
  if selite='Koodi'
    select sostyo
    append blank
    replace code with 'R'+apu_tupu.teksti1
    select apu_tupu
  endif
  if selite='Nimike'
    select sostyo
    replace text with apu_tupu.teksti1
    select apu_tupu
  endif
  if selite='Selite'
    select sostyo
    replace note with trim(apu_tupu.teksti1+apu_tupu.teksti2+apu_tupu.teksti3+apu_tupu.teksi4)
    select apu_tupu
  endif
  select apu_tupu
  skip
enddo
return
