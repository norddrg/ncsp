procedure rtgupda
select suod
replace all suod with .f.
select rtgp2002
goto top
do while not eof()
  select ncsp_koo
  seek trim(rtgp2002.code)
  if found()
    replace ncsp_koo.text with rtgp2002.tutkimusni
    replace short with rtgp2002.lyhenne
  else
    insert into ncsp_koo (usedate, released, chadate, code, text, short) values (ctod('2002/01/01'), .f., date(), rtgp2002.code, rtgp2002.tutkimusni, rtgp2002.lyhenne)
  endif
  select suod 
  seek trim(rtgp2002.code)
  if found()
    replace suod.old with str(rtgp2002.old,5,0)
    replace suod.suod with .t.
    replace suod.price with 'OK'
  else
    insert into suod (code,suod, old, price) values (rtgp2002.code, .t., str(rtgp2002.old,5,0), 'OK')
  endif
  select rtgp2002
  skip
enddo
