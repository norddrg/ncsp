procedure virkorj
select ncsp_en
set order to code
select ncsp_koo
set filter to not released
*goto top
do while not eof()
  if ncsp_koo.code=' '
    skip
    loop
  endif
  select ncsp_en
  set order to code
  seek ncsp_koo.ncsp
  if not found()
    set order to code_den
    seek ncsp_koo.ncsp
    if found()
      set order to code
      select ncsp_koo
      skip
      loop
    endif
    wait window 'ncsp_koo:n ncsp koodi ei l�ytynyt' nowait
    select ncsp_en
    set order to code
    exit
  endif
  do while code=ncsp_koo.ncsp
    if 'K'+code_eng=ncsp_koo.code or 'K'+code_swe=ncsp_koo.code or 'K'+code_nor=ncsp_koo.code
      if  ncsp<>' ' and code_den<>' '
        set order to code_den
        seek ncsp_koo.code
        if not found()
          set order to code
          seek ncsp_koo.ncsp
          wait window 'ncsp koodi on jo k�yt�ss�'
          return
        endif
      else
        replace ncsp_en.code_den with ncsp_koo.code
      endif
    endif
    if code_den=ncsp_koo.code
      exit
    endif
    set order to code
    select ncsp_en
    skip
  enddo
  if ncsp_en.code_den=ncsp_koo.code
    select ncsp_koo
    skip
    loop
  endif
  select ncsp_en
  seek ncsp_koo.ncsp
  if ncsp_koo.ncsp='WXX998' or ncsp_koo.ncsp='WXX999'
    select ncsp_en
    set order to code_den
    seek ncsp_koo.code
    if found()
      select ncsp_en
      set order to code
      select ncsp_koo
      skip
      loop
    endif
    set order to code_eng
    seek ncsp_koo.code
    if found() and code_den=' '
      replace code_den with ncsp_koo.code
      set order to code_den
      select ncsp_koo
      set order to code
      skip
      loop
    endif
    set order to code
    seek ncsp_koo.ncsp
    wait window 'Ncsp_koo:n code ei l�ydy' nowait
    select ncsp_koo
    do simupda
    do sim_toen
    select ncsp_koo
    skip
    loop
  endif
  if code_den=' '
    replace ncsp_en.code_den with ncsp_koo.code
  else
    do sim_toen
  endif
  select ncsp_en
  set order to code
  select ncsp_koo
  skip
enddo
