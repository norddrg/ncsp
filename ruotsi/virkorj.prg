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
    set order to code_swe
    seek ncsp_koo.ncsp
    if found()
      set order to code
      select ncsp_koo
      skip
      loop
    endif
    wait window 'ncsp_koo:n ncsp koodi ei l�ytynyt'
    select ncsp_en
    set order to code
    return
  endif
  do while code=ncsp_koo.ncsp
    if code_eng=ncsp_koo.code or code_swe=ncsp_koo.code
      if  code_swe<>' ' and code_swe<>ncsp_koo.code
        set order to code_swe
        seek ncsp_koo.code
        if not found()
          set order to code
          seek ncsp_koo.ncsp
          wait window 'ncsp koodi on jo k�yt�ss�'
          return
        endif
      else
        replace ncsp_en.code_swe with ncsp_koo.code
      endif
    endif
    if code_swe=ncsp_koo.code
      exit
    endif
    set order to code
    select ncsp_en
    skip
  enddo
  if ncsp_en.code_swe=ncsp_koo.code
    select ncsp_koo
    skip
    loop
  endif
  select ncsp_en
  seek ncsp_koo.ncsp
  if ncsp_koo.ncsp='WXX998' or ncsp_koo.ncsp='WXX999'
    select ncsp_en
    set order to code_swe
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
    if found() and code_swe=' '
      replace code_swe with ncsp_koo.code
      set order to code_swe
      select ncsp_koo
      set order to code
      skip
      loop
    endif
    set order to code
    seek ncsp_koo.ncsp
    wait window 'Ncsp_koo:n code ei l�ydy'
    select ncsp_koo
    do ..\ruotsi\simupda
    do ..\ruotsi\sim_toen
    select ncsp_koo
    return
    skip
    loop
  endif
  if code_swe=' '
    replace ncsp_en.code_swe with ncsp_koo.code
  else
    do ..\ruotsi\sim_toen
  endif
  select ncsp_en
  set order to code
  select ncsp_koo
  skip
enddo
