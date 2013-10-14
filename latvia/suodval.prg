procedure suodval
parameter lc_val
aktfilt=upper(substr(lc_val,rat('_',lc_val)+1,rat('.', lc_val)-rat('_',lc_val)-1))
on error select 0
select suod
on error
use (lc_val) alias suod
set order to code
deactivate popup suodval
return
