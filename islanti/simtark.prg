procedure simtark
  lc_find=.f.
  lc_ets=.f.
  lc_tark=.f.
  lc_n=0
  lc_loop=.t.
  select ncsp_en
  set order to ncsp
  seek ncsp_koo.ncsp
  if found()
    lc_find=.t.
    if ncsp_en.code_ice<>ncsp_koo.code
      lc_tark=.t.
      if ncsp_en.code_ice=' ' and ncsp_en.ncsp=ncsp_koo.ncsp
        replace ncsp_en.code_ice with ncsp_koo.code
        lc_tark=.f.
      endif
    else
      if ncsp_koo.english=' '
        replace ncsp_koo.english with ncsp_en.english
      endif
      if ncsp_koo.ncsp=' '
        replace ncsp_koo.ncsp with ncsp_en.code
      endif
    endif
  endif
  select ncsp_en
  set order to code_ice
  seek ncsp_koo.code
  if found()
    lc_find=.t.
    if ncsp_en.ncsp=' ' or ncsp_en.reldate<>ctod(space(8))
      lc_tark=.t.
    endif
    do while lc_loop 
      seek ncsp_koo.code
      if eof() 
        exit
      else
        skip
        if ncsp_en.code_ice<>ncsp_koo.code 
          exit
        else
          replace ncsp_en.code_ice with ' '
          if ncsp_en.code_den=' ' and ncsp_en.code_swe=' ' and ncsp_en.code_nor=' ' and ncsp_en.code_est=' ' and ncsp_en.code_eng=' ' and ncsp_en.code_fin=' ' and ncsp_en.ncsp= ' '
            replace released with .t.
            delete
          endif
        endif
      endif
    enddo
  endif
  if not lc_find
    lc_tark=.t.
    select ncsp_en
    set order to ncsp
    seek ncsp_koo.ncsp
    if found() 
      if ncsp_en.code_ice<>ncsp_koo.code
        insert into ncsp_en (code, code_ice, released, usedate, chadate, text);
        values (ncsp_koo.code, ncsp_koo.code, .f., ncsp_koo.usedate, ncsp_koo.chadate, ncsp_koo.text)
        if text=' '
          replace text with ncsp_koo.text_2
        endif
      endif
      select ncsp_en
      seek ncsp_koo.ncsp
    else
      seek ncsp_koo.code
    endif
    if not found()
      set order to code
      seek ncsp_koo.code
    endif
    set order to code
  endif
return
