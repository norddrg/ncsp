procedure paiv_apu
select ncsp_koo
replace all released with .t.
select ncsp_2007
goto top
do while not eof()
  select ncsp_koo
  seek ncsp_2007.ncsp
  if found()
    replace ncsp_koo.released with .f.
    replace ncsp_koo.text with ncsp_2007.text, ncsp_koo.english with ncsp_2007.text
  else
    append blank
    replace chadate with ctod('01/01/2007'), usedate with ctod('01/01/2007'), released with .f., code with ncsp_2007.ncsp, ncsp with ncsp_2007.ncsp, text with ncsp_2007.text, english with ncsp_2007.text
  endif
  select ncsp_2007
  skip
enddo
return