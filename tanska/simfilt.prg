procedure simfilt
select ncsp_en
if filter()= '.NOT.RELEASED'
  set filter to Ncsp_en.ncsp#" ".AND..NOT.released
else
  set filter to .NOT.released
endif
do ../tanska/simnayt
return