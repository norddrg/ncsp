procedure simcheck
lc_loop=.t.
on key label f12 do ..\suomi\sim_toloc
on key label f8 do ..\suomi\simcom
on key label f11 do ..\suomi\sim_toen
on key label f10 do ..\suomi\simno
on key label ctrl+p do ..\suomi\simed
on key label ctrl+s do ..\suomi\simseur
on key label ctrl+t do ..\suomi\simlop
ON KEY LABEL CTRL+b do ..\suomi\sim_edit
on key label f7 do ..\suomi\simloc
do ..\suomi\simnayt
lc_ets=.t.
return
