procedure valyear
val_loop=.t.
lc_x=20
lc_y=40
PUBLIC lc_nyear
lc_nyear='0'
define window yearwin from lc_x,lc_y to lc_x+5,lc_y+30
activate window yearwin
valyear=str(year(p_date),4)
do while val_loop
  @1,1 say 'Valid at year'
  @1,16 get valyear
  read
  if len(ltrim(rtrim(valyear)))=4
    exit
  endif
  if len(ltrim(rtrim(valyear)))=1
    valyear=substr(str(year(date()),4),1,3)+ltrim(rtrim(valyear))
  endif
  if len(ltrim(rtrim(valyear)))=2
    valyear=substr(str(year(date()),4),1,2)+ltrim(rtrim(valyear))
  endif
enddo
p_date=ctod(valyear+'/01/01')
@2,1 say 'Number of incl. years '
@2, 23 get lc_nyear
read
release window yearwin
return