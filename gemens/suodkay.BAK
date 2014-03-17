procedure suodkay
lc_loop=.t.
do while lc_loop
  lc_alias=alias()
  define popup filtsel
  define bar 1 of filtsel prompt '1. All'
  define bar 2 of filtsel prompt '2. All valid codes'
  define bar 3 of filtsel prompt '3. Valid common version codes'
  define bar 4 of filtsel prompt '4. Codes in a filter file'
  define bar 5 of filtsel prompt '5. All valid codes in NCSP order'
  define bar 6 of filtsel prompt '6. All valid codes in the active national version'
  on selection popup filtsel do filtuse with prompt()
  select ncsp_koo
  activate popup filtsel at 10,15
enddo
select (lc_alias)
do ..\gemens\naytto
return

procedure filtuse
parameter selected
lc_loop=.f.
select suod
lc_order=order()
set order to code
set relation to
select ncsp_koo
do case
case p_kieli='Fin'
  select ncsp_koo
  set relation to code_fin into ncsp_sec
case p_kieli='Swe'
  select ncsp_koo
  set relation to code_swe into ncsp_sec
case p_kieli='Dan'
  select ncsp_koo
  set relation to code_den into ncsp_sec
case p_kieli='Nor'
  select ncsp_koo
  set relation to code_nor into ncsp_sec
case p_kieli='Est'
  select ncsp_koo
  set relation to code_est into ncsp_sec
case p_kieli='Ice'
  select ncsp_koo
  set relation to code_ice into ncsp_sec
case p_kieli='Eng'
  select ncsp_koo
  set relation to code_eng into ncsp_sec
case p_kieli='Lat'
  select ncsp_koo
  set relation to code_lat into ncsp_sec
endcase
set relation to code into suod additive
set order to (lc_order)
suodatin=.f.
if selected='1.'
  p_poist=.f.
else
  p_poist=.t.
endif
do CASE
case selected='1.'
  set filter to 
  select ncsp_ala
  set filter to
  select ncsp_ryh
  set filter to
  select ncsp_luv
  set filter to
case selected='2.'
  do ..\gemens\valyear
  set order to code
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)));
  or (ncsp_sec.usedate<=p_date and (ncsp_sec.reldate>=p_date or reldate=ctod(space(8))) and ncsp_sec.usedate<>ctod(space(8)))
  select ncsp_ala
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ryh
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_luv
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
case selected='3.'
  do ..\gemens\valyear
  set order to ncsp
  set filter to ncsp<>' ' and (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ala
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ryh
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_luv
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
case selected='4.'
  select ncsp_koo
  set relation to code into ncsp_sec
  select suod
  set relation to code into ncsp_koo
  set filter to not ncsp_koo.released and suod
  set skip to ncsp_koo
  set order to (lc_order)
  suodatin=.t.
  select ncsp_ala
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ryh
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_luv
  set filter to (usedate<=p_date and (reldate>=p_date or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
case selected='5.'
  select ncsp_koo
  set order to ncsp
  set filter to not released
case selected='6.'
  select ncsp_koo
  set order to code
  set filter to Ncsp_sec.code<>" " AND NOT Ncsp_sec.released
  select ncsp_ala
  set filter to
  select ncsp_ryh
  set filter to
  select ncsp_luv
  set filter to
otherwise
  lc_loop=.t.
  return
endcase
select (lc_alias)
do ..\gemens\naytto
deactivate popup filtsel
return
