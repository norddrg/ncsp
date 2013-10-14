/* This Stata program was automatically generated by Stat/Transfer */

/* The following line should contain the complete path and name of your raw data file */
local dat_name ".\toimenpideluokitus 2009.dat"

/* The following line should contain the path to your output '.dta' file */
local dta_name ".\toimenpideluokitus 2009.dta"

/* The following line should contain the path to the data dictionary file */
local dct_name ".\toimenpideluokitus 2009.dct"

infile using `dct_name', using(`dat_name') clear 


save `dta_name', replace
