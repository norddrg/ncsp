Procedure update_d
clear all
public max_y, max_x, max_foty, max_fosi
max_y=srows()-3
max_x=scols()-4
max_foty='Small Font'
max_fosi=6
if max_x>100
  max_foty='Arial'
  max_fosi=8
endif
DEFINE WINDOW ncsp_all FROM 0,0 TO max_y-10,max_x FONT  max_foty,  max_fosi
define window apu from max_y-8,0 to max_y, max_x font max_foty, max_fosi
use \data\ncsp\englanti\ncsp_en.dbf
set order to code_d
set filter to not deleted()
activate window ncsp_all
browse fields change:8, code:7, language:1, headline:1, ncsp:1, sur:1, onk:1, oth:1, code_nc:7, english:30, code_f:7, finish:30, finish_s:30, code_d:7, danish:30, code_s:7, swedish:30, code_n:7, norw:30 nowait save
select 0
use \data\ncsp\tanska\ncsp_da.dbf
set order to koodi
lc_n=0
goto top
do while not eof()
  select ncsp_en
  seek trim(ncsp_da.koodi)
  if found() and code_d=ncsp_da.koodi)
    replace danish with ncsp_da.tanska
  else
    lc_n=lc_n+1
    activate window apu
    clear
    @ 1,1 say ncsp_da.koodi
    @ 2,1 say ncsp_da.tanska
    activate window ncsp_all
    browse fields change:8, code:7, language:1, headline:1, ncsp:1, sur:1, onk:1, oth:1, code_nc:7, english:30, code_f:7, finish:30, finish_s:30, code_d:7, danish:30, code_s:7, swedish:30, code_n:7, norw:30 save
    wait window nowait str(lc_n)
    do case
    case lastkey()=27
      insert into ncsp_en (change, code, language, headline, ncsp, sur, onk, oth, code_d, danish);
      values (date(), ncsp_da.koodi, 'D',.f., .f., .t., .f., .f., ncsp_da.koodi, ncsp_da.tanska)
      if len(trim(ncsp_da.koodi))<5
         replace headline with .t.
      endif
    case lastkey()=23
      replace danish with ncsp_da.tanska, code_d with ncsp_da.koodi
    otherwise
      loop
    endcase
    activate window ncsp_all
    browse fields change:8, code:7, language:1, headline:1, ncsp:1, sur:1, onk:1, oth:1, code_nc:7, english:30, code_f:7, finish:30, finish_s:30, code_d:7, danish:30, code_s:7, swedish:30, code_n:7, norw:30 nowait save
  endif
  select ncsp_da
  skip
enddo
select ncsp_en
set filter to code_d<>' '
lc_n2=0
goto top
do while not eof()
  if len(trim(ncsp_en.code_d))<3
    skip
    loop
  endif
  select ncsp_da
  seek ncsp_en.code_d
  if not found()
    lc_n2=lc_n2+1
    wait window nowait str(lc_n2)
    select ncsp_en
    if language='C' or  code_f<>' ' or code_s<>' '
       replace code_d with ' '
       replace danish with ' '
    else
       delete
    endif
  endif
  select ncsp_en
  skip
enddo
return
