/*
Objective: Import hd and non-hd indicators from WDI for the scorecard
Author: Zelalem Debebe
Date: October 03 2019
*/

clear
set more off	
set maxvar 32000



global root "C:\Users\WB469563\OneDrive - WBG\Documents (zdebebe@worldbank.org)\OneDrive - WBG\Documents (zdebebe@worldbank.org)\Human Capital Project\CHI_AM19_scorecard"
global charts "${root}/charts"
local outputfilepath "${root}/input"
cd "${root}"

local date: disp %tdCY-m-D date("`c(current_date)'", "DMY")
disp "`date'"

use "input/scorecardanalysis_2019-08-13.dta", clear 


ssc install wbopendata, replace		
set checksum off



tempfile tmp
wbopendata, language(en - English) indicator (EG.ELC.ACCS.ZS; EG.CFT.ACCS.ZS; SH.STA.TRAF.P5; SH.STA.HYGN.ZS; ///
		 sp.dyn.tfrt.in; SP.ADO.TFRT; SP.DYN.CONU.ZS; per_sa_allsa.cov_q1_tot; SH.STA.ODFC.ZS; SE.SEC.NENR.FE; ///
		 GC.TAX.TOTL.GD.ZS; IQ.CPA.HRES.XQ; SH.H2O.BASW.ZS; SH.STA.BASS.ZS) long clear
	
	
	
rename countrycode wbcode
rename eg_elc_accs_zs electric
rename eg_cft_accs_zs clean_fuel
rename sh_sta_traf_p5 road_traff
rename sh_sta_hygn_zs hygiene_basic
rename sh_h2o_basw_zs water_basic_plus
rename sh_sta_bass_zs sanit_basic_plus

rename sp_dyn_tfrt_in tfr
rename sp_ado_tfrt afr
rename sp_dyn_conu_zs contra

rename per_sa_allsa_cov_q1_ spc
rename sh_sta_odfc_zs od
gen odcomp=1-od
rename se_sec_nenr_fe ner_sec_f
rename gc_tax_totl_gd_zs drm
rename iq_cpa_hres_xq cpia_hr

		 
gen nyear = -year 		 
		 
// generate vars for the last and first observations in a timeseries 
foreach j of varlist electric clean_fuel road_traff hygiene_basic water_basic_plus sanit_basic_plus ///
tfr afr contra spc odcomp ner_sec_f drm cpia_hr {

sort wbcode year, stable

by wbcode (nyear), sort: gen long obsno1_`j' = _n
by wbcode : gen cnm1_`j' = sum(!missing(`j')) if !missing(`j')
bysort wbcode (cnm1_`j') : gen lastnm_`j' = `j'[1]

by wbcode: egen lastnm_`j'_y = max(cond( `j'!=., year, .))

}

drop if regionname=="Aggregates"
duplicates drop wbcode, force
keep wbcode lastnm* 

gen lasttfr= lastnm_tfr //to make the same vars as in dofile
gen yeartfr=lastnm_tfr_y 

gen lastafr= lastnm_afr  //to make the same vars as in dofile
gen lastyearafr=lastnm_afr_y 

gen contracep=lastnm_contra //to make the same vars as in dofile
gen contracep_year=lastnm_contra_y 

gen lastspc=lastnm_spc 
gen lastyearspc=lastnm_spc_y 

gen lastodcomp=lastnm_odcomp

gen lastner_sec_f=lastnm_ner_sec_f 
gen lastner_sec_f_year=lastnm_ner_sec_f_y

gen drm=lastnm_drm 
gen drm_year=lastnm_drm_y 

gen lastcpia_hr=lastnm_cpia_hr 
gen lastyearcpia_hr=lastnm_cpia_hr_y


foreach j of varlist lastnm_electric lastnm_clean_fuel lastnm_road_traff lastnm_hygiene_basic lastnm_water_basic_plus lastnm_sanit_basic_plus ///
lastnm_tfr lastnm_afr lastnm_contra lastnm_spc lastnm_odcomp lastnm_ner_sec_f lastnm_drm lastnm_cpia_hr { //turn missing if earlier than 2005
replace `j'=. if `j'_y<2005

}
sort wbcode
save `tmp', replace
		 
		
		
		
		
tempfile tmp2
use "input/social_sector_spending_reduceddataset_9Aug2019.dta", clear
gen health_pc=(domphegdp * ngdp_usd )/(100*pop_total) // calculate these separtely so i can add most recent values across sectors - to minimize missing values
gen educ_pc=(exp_total_percgdp_raw* ngdp_usd)/(100*pop_total)
gen sp_pc=(allsocialassistance_pctgdp* ngdp_usd)/(100*pop_total)

gen nyear = -year 		 
gen all_soc_ass_pctgdp=allsocialassistance_pctgdp
foreach j of varlist domphegdp exp_total_percgdp_raw all_soc_ass_pctgdp health_pc educ_pc sp_pc pop_total {
sort wbcode year, stable
by wbcode (nyear), sort: gen long no_`j' = _n
by wbcode : gen cnm1_`j' = sum(!missing(`j')) if !missing(`j')
bysort wbcode (cnm1_`j') : gen lastnm_`j' = `j'[1]

by wbcode: egen lastnm_`j'_y = max(cond( `j'!=., year, .))

}

duplicates drop wbcode, force
keep wbcode lastnm* 

foreach j of varlist lastnm_domphegdp lastnm_exp_total_percgdp_raw lastnm_all_soc_ass_pctgdp lastnm_health_pc lastnm_educ_pc lastnm_sp_pc lastnm_pop_total {
replace `j'=. if `j'_y<2005
}

gen health_ed_sp_pctgdp = lastnm_domphegdp + lastnm_exp_total_percgdp_raw + lastnm_all_soc_ass_pctgdp  //all social sector spending- note that subcomponents come from different years
gen health_ed_sp_pc=lastnm_health_pc+ lastnm_educ_pc+ lastnm_sp_pc

gen health_ed_pctgdp = lastnm_domphegdp + lastnm_exp_total_percgdp_raw // edu and health sector spending- note that subcomponents come from different years
gen health_ed_pc=lastnm_health_pc+ lastnm_educ_pc // data from different years

sort wbcode
save `tmp2', replace


			
			
				
			
			
	


use "input/scorecardanalysis_2019-08-13.dta", clear 
drop lasttfr yeartfr lastafr lastyearafr contracep contracep_year lastspc ///
lastyearspc lastodcomp lastner_sec_f lastner_sec_f_year drm drm_year lastcpia_hr lastyearcpia_hr

drop health_ed_pctgdp health_ed_pc health_ed_sp_pc health_ed_sp_pctgdp
drop _merge 
sort wbcode 

merge 1:1 wbcode using `tmp'
drop _merge
merge 1:1 wbcode using `tmp2'
drop if _merge==2
drop _merge 




label var health_ed_pc "Healtha and education spending per capita"
lab var health_ed_pctgdp "Health and education spending as % of GDP"
lab var health_ed_sp_pc "Health, educ and social protection spending per capita"
lab var health_ed_sp_pctgdp " Health, education and social protection spending as % of GDP"
lab var lastnm_domphegdp "Latest health spending as % of GDP"
lab var lastnm_domphegdp_y "year of latest health spending as % of GDP"
lab var lastnm_electric "% of pop with access to electricity- latest"
lab var lastnm_electric_y "Year of data on % of pop with electricity"
lab var lastnm_clean_fuel "proportion of pop primarily using clean cooking fuels and technologies for cooking"
lab var lastnm_road_traff "mortality caused by road traffic injury per 100k pop"

lab var lastnm_hygiene_basic "Proportion of population with Basic Hygiene services (soap and water) 2017"
label var lastnm_sanit_basic_plus "Proportion of population with at least basic sanitation 2017"
label var lastnm_water_basic_plus "Proportion of population with at least basic source of drinking water 2017"

lab var lastnm_exp_total_percgdp_raw "educ spending as % of GDP- latest"
lab var lastnm_exp_total_percgdp_raw_y "Year of latest educ spending as % of gDP"
lab var lastnm_all_soc_ass_pctgdp "Soc prot spending as % of GDP0- latest"
lab var lastnm_all_soc_ass_pctgdp_y "Year of latest soc prot spending as % of GDP"
lab var lastnm_health_pc "Health spending per capita- latest"
lab var lastnm_health_pc_y "Year of health spending per capita"
lab var lastnm_educ_pc "Educ spending per capita- latest"
lab var lastnm_educ_pc_y "Year of latest data on educ spening per capita"
lab var lastnm_sp_pc "Soc protec spending per capita- latest"
lab var lastnm_sp_pc_y "Year of lastest soc prot spending per capita"
lab var lastnm_pop_total "Latest population data"
lab var lastnm_pop_total_y "Year of latest population data"

save "input/scorecardanalysis_2019-10-03.dta", replace

exit












































