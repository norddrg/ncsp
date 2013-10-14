procedure kasit
  lc_alias=alias()
  lc_loop=.f.
  on key label alt+b do ..\gemens\lisays
  if alias()='SUOD' or alias()='NCSP_KOO'
    select suod
    seek (substr(ncsp_koo.code,1,5))
    if not found()
      append blank
      replace code with ncsp_koo.code, suod with .f.
    endif
    select ncsp_koo
    lc_alias=alias()
    ka_chadate=chadate
    ka_usedate=usedate
    ka_reldate=reldate
    ka_released=released
    ka_subst=subst
    ka_code=code
    ka_nc=nc
    ka_text=text
    ka_short=short
    ka_code_den=code_den
    ka_code_fin=code_fin
    ka_code_nor=code_nor
    ka_code_swe=code_swe
    ka_code_est=code_est
    ka_code_eng=code_eng
    ka_code_ice=code_ice
    ka_ncsp=ncsp
    ka_headline=headline
    ka_note_e=trim(note_e)
    edit next 1 fields chadate, usedate, reldate, released, subst, code:R, nc, text, short,; 
    code_den, code_fin, code_ice, code_nor, code_swe, code_est, code_eng, ncsp, note_e, suod.suod
  else
    ka_chadate=chadate
    ka_usedate=usedate
    ka_reldate=reldate
    ka_released=released
    ka_ncsp=ncsp
    ka_text=text
    ka_note=trim(note)
    edit next 1 fields chadate, usedate, reldate, released, ncsp, text, short
  endif
  if released
    lc_loop=.t.
    do while lc_loop
    if reldate=ctod(space(8))
      if month(date())>11
        replace reldate with ctod(str(year(date())+1,4) + '/12/31')
      else
        replace reldate with ctod(str(year(date()),4) + '/12/31')
      endif
    endif
    if alias()<>'NCSP_KOO'
      if reldate<usedate and reldate<>ctod(space(8))
        delete
      endif
    else
      if reldate<usedate and reldate<>ctod(space(8)) and code_fin=' ' and code_den=' ' and code_eng=' ' and code_swe=' ' and code_nor=' ' and code_est=' '
        delete
      else
        if subst=' ' 
          wait window nowait 'You need to select the substituting code'
          edit next 1 fields chadate, usedate, reldate, released, subst, code:R, nc, text, short,; 
          code_den, code_fin, code_ice, code_nor, code_swe, code_est, code_eng, ncsp, note_e, suod.suod
          loop
        endif
      endif
    endif
    exit
    enddo
  else
    replace reldate with ctod(space(8))
  endif
  ka_cha=.f.
  if ka_text<>text
    ka_cha=.t.
  endif
  select (lc_alias)
  if ka_cha and ka_ncsp=ncsp
    ka_cha=.f.
    wait window 'Did you change the information? Y/N'
    if lastkey()=121 or lastkey()=89 
      ka_cha=.t.
      lc_loop=.f.
    endif
  endif
  select (lc_alias)
  lc_loop=.f.
  if ka_ncsp<>ncsp
    ka_cha=.t.
    lc_loop=.t.
  endif
  select (lc_alias)
  if ka_cha 
    if month(date())>11
      replace usedate with ctod(str(year(date())+2,4) + '/01/01')
    else
      replace usedate with ctod(str(year(date())+1,4) + '/01/01')
    endif
    if alias()='NCSP_KOO'
      replace code with ncsp
    endif
    replace chadate with date()
    lc_ncsp=ncsp
    append blank
    replace chadate with ka_chadate
    replace usedate with ka_usedate
    replace ncsp with ka_ncsp
    if month(date())>11
      replace reldate with ctod(str(year(date())+1,4) + '/12/31')
    else
      replace reldate with ctod(str(year(date()),4) + '/12/31')
    endif
    if alias()='NCSP_KOO'
      if usedate>reldate and code_fin=' ' and code_den=' ' and code_eng=' ' and code_swe=' ' and code_nor=' ' and code_est=' ' and code_ice=' '
        delete
      endif
    else
      if usedate>reldate
        delete
      endif
    endif
    replace released with .t.
    if alias()='NCSP_KOO'
      replace code with ka_code
      replace text with ka_text
      replace subst with lc_ncsp
      replace nc with ka_nc
      replace short with ka_short
      replace code_den with ka_code_den
      replace code_fin with ka_code_fin
      replace code_nor with ka_code_nor
      replace code_swe with ka_code_swe
      replace code_est with ka_code_est
      replace code_eng with ka_code_eng
      replace code_ice with ka_code_ice
      replace ncsp with ka_ncsp
      replace headline with ka_headline
      replace note_e with ka_note_e
      set filter to
      do while lc_loop
        select ncsp_koo
        locate all for subst=ka_code and released
        if subst=ka_code and released
          replace subst with lc_ncsp
        else
          exit
        endif
      enddo
      do while lc_loop
        select ncsp_koo
        locate all for code=ka_code and ncsp=' '
        if ncsp_koo.code=ka_code and ncsp=' '
          replace ncsp_koo.code with lc_ncsp
        else
          exit
        endif
      enddo
      seek ka_code
    else
      replace text with ka_text
      replace note with ka_note
    endif
  endif
  on key label alt+b do ..\gemens\lisays
  do ..\gemens\naytto
  return
