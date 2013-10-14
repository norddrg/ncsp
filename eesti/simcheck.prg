procedure simcheck
lc_loop=.t.
on key label f12 do ..\eesti\sim_toloc
on key label f8 do ..\eesti\simcom
on key label f11 do ..\eesti\sim_toen
on key label f10 do ..\eesti\simno
on key label ctrl+p do ..\eesti\simed
on key label ctrl+s do ..\eesti\simseur
on key label ctrl+t do ..\eesti\simlop
on key label f7 do ..\eesti\simloc
do ..\eesti\simnayt
lc_ets=.t.
return
