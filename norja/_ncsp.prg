procedure _ncsp
  clear all
  set status on
  public max_y, max_x, max_foty, max_fosi, pub_code
  public p_ncsp
  select 0
  use ..\muisti
  p_ncsp=ncsp
  use
  max_y=srows()-3
  max_x=scols()-4
  max_foty='Small Font'
  max_fosi=6
  if max_x>100
    max_foty='Arial'
    max_fosi=8
  endif
  do ../norja/ncsp
*on key label enter do a__2
*do \foxproc\scrsize
  return
