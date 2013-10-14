procedure simcheck
lc_loop=.t.
on key label f12 do ..\ruotsi\sim_toloc
on key label f8 do ..\ruotsi\simcom
on key label f11 do ..\ruotsi\sim_toen
on key label f10 do ..\ruotsi\simno
on key label ctrl+p do ..\ruotsi\simed
on key label ctrl+s do ..\ruotsi\simseur
on key label ctrl+t do ..\ruotsi\simlop
on key label f7 do ..\ruotsi\simloc
do ..\ruotsi\simnayt
lc_ets=.t.
return
