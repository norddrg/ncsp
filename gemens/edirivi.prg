procedure edirivi
if alias()='NCSP_KOO'
  lc_text = text
  lc_cden=code_den
  lc_cfin=code_fin
  lc_cnor=code_nor
  lc_cswe=code_swe
  lc_cest=code_est
  lc_ceng=code_eng
  lc_code=code
else
  lc_text=text
endif
lc_chadate=chadate
lc_ncsp=ncsp
lc_use=usedate
if alias()='NCSP_KOO'
  edit next 1 fields ncsp, text, usedate, released, reldate, code_den, code_fin, code_nor, code_swe, code_est, code_eng, code_ice, short, code, subst, nc
  uu_text=text
else
  edit next 1 fields ncsp, text, usedate, reldate, short
  uu_text=text
endif
release window apuikk

if lc_ncsp<>ncsp or lc_text<>uu_text
  lc_ncsp_u=ncsp
  if month(date())>10
    replace usedate with ctod(str(year(date())+2,4) + '/01/01')
  else
    replace usedate with ctod(str(year(date())+1,4) + '/01/01')
  endif
  replace reldate with ctod(space(8))
  lc_found=.f.
  seek lc_ncsp
  do while ncsp=lc_ncsp and not eof()
    if month(date())<11 and reldate = ctod(str(year(date()),4) + '/12/31');
    or month(date())>10 and reldate = ctod(str(year(date())+1,4) + '/12/31')
      lc_found=.t.
      exit
    endif
    skip
  enddo
  if not lc_found
    append blank
    replace ncsp with lc_ncsp, chadate with lc_chadate, usedate with lc_use
    if month(date())>10
      replace reldate with ctod(str(year(date())+1,4) + '/12/31')
    else
      replace reldate with ctod(str(year(date()),4) + '/12/31')
    endif
    if alias()='NCSP_KOO' 
      replace text with lc_text, code_den with lc_cden,;
      code_fin with lc_cfin, code_nor with lc_cnor, code_swe with lc_cswe, code_est with lc_cest, code_eng with lc_ceng
      replace subst with lc_ncsp_u
      replace code with lc_code
      if code=' ' 
        replace code with ncsp
      endif
    else
      replace text with lc_text
    endif
    if usedate=reldate+1
      delete
    endif
  endif
endif
return
