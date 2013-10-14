procedure apu
select suuntoimenpiteet
goto top
do while not eof()
  select apu_stp
  if suuntoimenpiteet.text<>' '
    append blank
    replace usedate with ctod('01/01/2000'), released with .f., chadate with date(),;
    code with suuntoimenpiteet.text, text with suuntoimenpiteet.text2 
  else
    if len(trim(note))=0
      replace note with trim(suuntoimenpiteet.text2)
    else
      replace note with trim(note)+chr(13)+trim(suuntoimenpiteet.text2)
    endif
  endif
  select suuntoimenpiteet
  skip
enddo