Procedure ice_conv
select ncsp_koo
set filter to
select ice
goto top
do while not eof()
 if pr1<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr1)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp1 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr1 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr2<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr2)
  if not found()
    set order to code
    seek trim(ice.pr2)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp2 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr2 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr3<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr3)
  if not found()
    set order to code
    seek trim(ice.pr3)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp3 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr3 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr4<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr4)
  if not found()
    set order to code
    seek trim(ice.pr4)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp4 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr4 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr5<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr5)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp5 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr5 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr6<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr6)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp6 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr6 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr7<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr7)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp7 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr7 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr8<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr8)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp8 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr8 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr9<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr9)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp9 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr9 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 if pr10<>' '
  select ncsp_koo
  set order to code_ice
  seek trim(ice.pr10)
  if not found()
    set order to code
    seek trim(ice.pr1)
  endif
  if found()
    do while released
      lc_subst=subst
      if subst=code
         skip
      else
        seek trim(lc_subst)
      endif
    enddo
    replace ice.ncsp10 with code
    lc_code=code
    set order to code
    seek lc_code
    do while not eof()
      if code_swe<>' '
        replace ice.spr10 with code_swe
        exit
      endif
      if code<>lc_code
        exit
      endif
      skip
    enddo 
  endif
  select ice
 endif
 skip
enddo
return