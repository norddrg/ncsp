procedure simcheck
lc_loop=.t.
on key label f12 do ../tanska/sim_toloc
on key label f8 do ../tanska/simcom
on key label f11 do ../tanska/sim_toen
on key label f10 do ../tanska/simno
on key label ctrl+p do ../tanska/simed
on key label ctrl+s do ../tanska/simseur
on key label ctrl+t do ../tanska/simlop
on key label f7 do ../tanska/simloc
do ../tanska/simnayt
lc_ets=.t.
return
