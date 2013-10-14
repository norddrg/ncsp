procedure suodkay
lc_alias=alias()
lc_loop=.t.
lc_alias=alias()
lc_nyear='0'
define popup filtsel
define bar 1 of filtsel prompt '1. All'
define bar 2 of filtsel prompt '2. Valid codes'
define bar 3 of filtsel prompt '3. Codes in the filter file'
on selection popup filtsel do filtuse with prompt()
select ncsp_koo
activate popup filtsel at 10,15
select (lc_alias)
do ../englanti/naytto
return

procedure filtuse
parameter selval
select ncsp_koo
do CASE
case selval='1.'
  suodatin=.f.
  select suod
  set relation to
  select ncsp_koo
  set order to ncsp
  set filter to 
  set relation to trim(code) into suod
  select ncsp_ala
  set filter to
  select ncsp_ryh
  set filter to
  select ncsp_luv
  set filter to
case selval='2.'
  suodatin=.f.
  do valyear
  select suod
  set relation to
  select ncsp_koo
  set order to ncsp
  set relation to trim(code) into suod
  set filter to (usedate<=p_date+100 and (reldate>=p_date-(VAL(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ala
  set filter to (usedate<=p_date+100 and (reldate>=p_date-(val(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_ryh
  set filter to (usedate<=p_date+100 and (reldate>=p_date-(val(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
  select ncsp_luv
  set filter to (usedate<=p_date+100 and (reldate>=p_date-(val(lc_nyear)*365)+500 or reldate=ctod(space(8))) and usedate<>ctod(space(8)))
case selval='3.'
  set near on
  select ncsp_ala
  set filter to
  select ncsp_ryh
  set filter to
  select ncsp_luv
  set filter to
  public p_posit
  select ncsp_koo
  p_posit = code
  suodatin=.t.
  select ncsp_koo
  set relation to
  set order to code
  set filter to not released
  select suod
  set relation to
  set filter to suod
  select ncsp_koo
  set relation to substr(code,1,1)+trim(substr(code,2,6)) into suod
  set filter to suod.suod
endcase
deactivate popup filtsel
return

procedure valyear
lc_x=20
lc_y=40
val_loop=.t.
define window yearwin from lc_x,lc_y to lc_x+10,lc_y+30
activate window yearwin
do while val_loop
  valyear=str(year(p_date),4)
  @1,1 say 'Valid at year'
  @1,17 get valyear
  read  
  if len(ltrim(rtrim(valyear)))=4
    exit
  endif
  if len(ltrim(rtrim(valyear)))=1
    valyear=substr(str(year(date()),4),1,3)+ltrim(rtrim(valyear))
  endif
  if len(ltrim(rtrim(valyear)))=2
    valyear=substr(str(year(date()),4),1,2)+ltrim(rtrim(valyear))
  ENDIF
enddo
@2,1 say 'Number of incl. years '
@2, 23 get lc_nyear
read
p_date=ctod(valyear+'/01/01')
release window yearwin
return