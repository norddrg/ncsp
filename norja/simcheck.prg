procedure simcheck
lc_loop=.t.
on key label f12 do ../norja/sim_toloc
on key label f8 do ../norja/simcom
on key label f11 do ../norja/sim_toen
on key label f10 do ../norja/simno
on key label ctrl+p do ../norja/simed
on key label ctrl+s do ../norja/simseur
on key label ctrl+t do ../norja/simlop
on key label f7 do ../norja/simloc
do ../norja/simnayt
lc_ets=.t.
return
