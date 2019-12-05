
/*
OBJECTIVE: GENERATE TEXT FOR ILLUSTRATIVE INDICATORS COUNTRY PROFILE
AUTHORS: MARTIN DE SIMONE AND ZELALEM YILMA DEBEBE
DATE: DECEMBER 03 2019

*/

clear all
set more off	
set maxvar 32000

*set up directory and filepath to database 


if ( lower("`c(username)'") == "wb469563") {
	global root "C:\Users\WB469563\OneDrive - WBG\Documents (zdebebe@worldbank.org)\OneDrive - WBG\Documents (zdebebe@worldbank.org)\Human Capital Project\HCP_AM19_Illustrative_indicators"
}

if ( lower("`c(username)'") == "wb384996") {
	global root "c:\Users\wb384996\OneDrive - WBG\WorldBank\CHI_AM19_scorecard"
}

if ( lower("`c(username)'") == "wb538904") {
	global root "C:\Users\WB538904\OneDrive - WBG\CHI_AM19_scorecard"
}


global charts "${root}/charts"
local outputfilepath "${root}/input"
cd "${root}"

local date: disp %tdCY-m-D date("`c(current_date)'", "DMY")
disp "`date'"
 
use "input/illustrative_indicators_2019-10-03.dta", clear 
graph set window fontface "Fourier"




//Preliminaries 

encode wbregion, gen(region)
encode  wbincomegroup, gen(income)

gen wbcountrynameb=""
replace wbcountrynameb="the Comoros" if wbcountryname=="Comoros"
replace wbcountrynameb="the DRC" if wbcountryname=="Democratic Republic of Congo"
replace wbcountryname="The Democratic Republic of Congo" if wbcountryname=="Democratic Republic of Congo"
replace wbcountrynameb="the Republic of Congo" if wbcountryname=="Republic of Congo"
replace wbcountryname="The Republic of Congo" if wbcountryname=="Republic of Congo"
replace wbcountrynameb="Egypt" if wbcountryname=="Arab Republic of Egypt"
replace wbcountryname="The Arab Republic of Egypt" if wbcountryname=="Arab Republic of Egypt"
replace wbcountrynameb="the Gambia" if wbcode=="GMB"
replace wbcountryname="The Gambia" if wbcode=="GMB"
replace wbcountrynameb="Iran" if wbcountryname=="Islamic Republic of Iran"
replace wbcountryname=" The Islamic Republic of Iran" if wbcountryname=="Islamic Republic of Iran"
replace wbcountrynameb="the Republic of Korea" if wbcountryname=="Republic of Korea"
replace wbcountryname="The Republic of Korea" if wbcountryname=="Republic of Korea"
replace wbcountrynameb="the Kyrgyz Republic" if wbcountryname=="the Kyrgyz Republic"
replace wbcountryname="The Kyrgyz Republic" if wbcountryname=="the Kyrgyz Republic"
replace wbcountrynameb="North Macedonia" if wbcountryname=="Macedonia, FYR"
replace wbcountryname="North Macedonia" if wbcountryname=="Macedonia, FYR"
replace wbcountrynameb="the Netherlands" if wbcountryname=="Netherlands"
replace wbcountryname="The Netherlands" if wbcountryname=="Netherlands"
replace wbcountrynameb="the Philippines" if wbcountryname=="Philippines"
replace wbcountryname="The Philippines" if wbcountryname=="Philippines"
replace wbcountrynameb="the Russian Federation" if wbcountryname=="Russian Federation"
replace wbcountryname="The Russian Federation" if wbcountryname=="Russian Federation"
replace wbcountrynameb="the Seychelles" if wbcountryname=="Seychelles"
replace wbcountryname="The Seychelles" if wbcountryname=="Seychelles"
replace wbcountrynameb="the Slovac Republic" if wbcountryname=="Slovac Republic"
replace wbcountryname="The Slovac Republic" if wbcountryname=="Slovac Republic"
replace wbcountrynameb="the Solomon Islands" if wbcountryname=="Solomon Islands"
replace wbcountryname="The Solomon Islands" if wbcountryname=="Solomon Islands"
replace wbcountrynameb="the United Arab Emirates" if wbcountryname=="United Arab Emirates"
replace wbcountryname="The United Arab Emirates" if wbcountryname=="United Arab Emirates"
replace wbcountrynameb="the United Kingdom" if wbcountryname=="United Kingdom"
replace wbcountryname="The United Kingdom" if wbcountryname=="United Kingdom"
replace wbcountrynameb="the United States" if wbcountryname=="United States"
replace wbcountryname="The United States" if wbcountryname=="United States"
replace wbcountrynameb="the West Bank and Gaza" if wbcountryname=="West Bank and Gaza"
replace wbcountryname="The West Bank and Gaza" if wbcountryname=="West Bank and Gaza"
replace wbcountrynameb="the Republic of Yemen" if wbcountryname=="Republic of Yemen"
replace wbcountryname="The Republic of Yemen" if wbcountryname=="Republic of Yemen"


replace wbcountrynameb="CAR" if wbcountryname=="Central African Republic"
replace wbcountryname="The Central African Republic" if wbcountryname=="Central African Republic"
replace wbcountrynameb="the Democratic People's Republic of Korea" if wbcountryname=="Democratic People's Republic of Korea"
replace wbcountryname="The Democratic People's Republic of Korea" if wbcountryname=="Democratic People's Republic of Korea"
replace wbcountrynameb="Micronesia" if wbcountryname=="Federated States of Micronesia"
replace wbcountryname="The Federated States of Micronesia" if wbcountryname=="Federated States of Micronesia"
replace wbcountrynameb="Hong Kong" if wbcountryname=="Hong Kong SAR, China"
replace wbcountryname="Hong Kong" if wbcountryname=="Hong Kong SAR, China"
replace wbcountrynameb="the Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountryname="The Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountrynameb="the Lao PDR" if wbcountryname=="Lao PDR"
replace wbcountryname="The Lao People's Democratic Republic" if wbcountryname=="Lao PDR"
replace wbcountrynameb="Macao" if wbcountryname=="Macao SAR, China"
replace wbcountryname="Macao" if wbcountryname=="Macao SAR, China"
replace wbcountrynameb="the Marshall Islands" if wbcountryname=="Marshall Islands"
replace wbcountryname="The Marshall Islands" if wbcountryname=="Marshall Islands"
replace wbcountrynameb="the Northern Mariana Islands" if wbcountryname=="Northern Mariana Islands"
replace wbcountryname="The Northern Mariana Islands" if wbcountryname=="Northern Mariana Islands"
replace wbcountrynameb="Syria" if wbcountryname=="Syrian Arab Republic"
replace wbcountryname="The Syrian Arab Republic" if wbcountryname=="Syrian Arab Republic"
replace wbcountrynameb="Venezuela" if wbcountryname=="Venezuela, RB"
replace wbcountryname="Venezuela" if wbcountryname=="Venezuela, RB"
replace wbcountrynameb="the Virgin Islands" if wbcountryname=="Virgin Islands (U.S.)"
replace wbcountryname="The Virgin Islands" if wbcountryname=="Virgin Islands (U.S.)"
replace wbcountrynameb=wbcountryname if wbcountrynameb==""


* Create variable with capital The for countries with name starting with the

gen wbcountrynameB = cond(regexm(wbcountrynameb, "^the "), /* 
 */ "T"+ substr(wbcountrynameb, 2, .), wbcountrynameb)



gen hci_mf_100= hci_mf*100

// generate regional and income averages and label them
foreach gender in mf {
foreach var of varlist lastner_sec_f hci_`gender'  nostu_`gender' asr_`gender' ///
psurv_`gender' test_`gender' eyrs_`gender' lastod lastodcomp lasttfr lastafr contracep wbl ///
unregpop_share lastspc drm lastcpia_hr  ///
lastnm_water_basic_plus lastnm_sanit_basic_plus lastnm_hygiene_basic lastnm_road_traff lastnm_clean_fuel lastnm_electric ///
lastnm_all_soc_ass_pctgdp lastnm_exp_total_percgdp_raw lastnm_domphegdp {
     egen `var'_mr=mean(`var') if year==2017, by(region)
	 egen `var'_mi=mean(`var') if year==2017, by(income)
	 }
	 }
	 	 
foreach gender in mf {
label var nostu_`gender'_mr "Region mean"
label var nostu_`gender'_mi "Income mean"
label var psurv_`gender'_mr "Region mean"
label var psurv_`gender'_mi "Income mean"

}

							

//FOR text accompanying  FIGURE 3, generate predicted error term after a linear-log regression
gen log_health_ed_sp_pc = log(health_ed_sp_pc)
gen log_health_ed_pc = log(health_ed_pc) // per capita health and education spending in logs 


reg hci_mf log_health_ed_sp_pc // use for efficiency for countries where data on SP  exist
predict phci_mf
gen difhcipred = hci_mf-phci_mf

reg hci_mf log_health_ed_pc 
predict p1hci_mf
gen difhcipred1 = hci_mf-p1hci_mf // use for efficiency for countries where data on SP does not exist


	
//FOR FIGURE 4 AND TEXT

gen show2=1 if ///
wbcountryname=="United Arab Emirates" | wbcountryname=="Mozambique" | wbcountryname=="Ethiopia" | ///
wbcountryname=="Nigeria" | wbcountryname=="Burundi"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | ///
wbcountryname=="Singapore"

	
// update the list of HCP countries
replace  hcicountry=1 if (wbcountryname=="Tanzania" | wbcountryname=="Cambodia") 
replace  hcicountry=1 if (wbcountryname=="Ireland" | wbcountryname=="The Republic of Yemen") 
replace  hcicountry=1 if (wbcountryname=="The Democratic Republic of Congo" ) //we have 68 hcp countries 
	
	
/////////////////////////////////////////////// Deviation from AFRICA HCP plan target			
gen af_hci_targ = 45 //for text 
gen af_od_targ = 15
gen af_lastspc_targ = 30
gen af_lastafr_targ = 83


gen dif_hci_targ = hci_mf_100 - af_hci_targ
gen dif_od_targ = lastod - af_od_targ
gen dif_lastspc_targ = lastspc - af_lastspc_targ
gen dif_lastafr_targ = lastafr - af_lastafr_targ




/// round so we dont end up with > when indeed the same value in the text
foreach j of varlist lastnm_water_basic_plus lastnm_sanit_basic_plus lastnm_hygiene_basic lastnm_road_traff lastnm_clean_fuel lastnm_electric ///
 lastnm_water_basic_plus_mr lastnm_sanit_basic_plus_mr lastnm_hygiene_basic_mr lastnm_road_traff_mr lastnm_clean_fuel_mr lastnm_electric_mr ///
 lastnm_water_basic_plus_mi lastnm_sanit_basic_plus_mi lastnm_hygiene_basic_mi lastnm_road_traff_mi lastnm_clean_fuel_mi lastnm_electric_mi {
replace `j'=round(`j',1)
}


	
	
///////////////////GENERATE TEXT	
	
	
	
	
	
	
	
gen intro_text  = "This note presents a snapshot of the country's commitment on the human capital agenda and the main actions being taken by the World Bank Group to support the government."

gen hci_text = ///
  cond(hci_mf_100 != . & wdr == 1, "In " + wbcountrynameb + " the productivity as a future worker" ///
  + " of a child born today is **" + strofreal(round(hci_mf_100,1)) + " percent**" ///
  + " as much as it could be. The country ranks **" + strofreal(round(hcirank,1)) + " out of 157** in the global HCI." ///
  + " For more information on human capital outcomes and the HCI, please see the country two-pager on \url{www.worldbank.org/en/publication/human-capital}.",   ///
     "In " + wbcountrynameb + " there are no enough data to calculate the productivity as a future worker of a child born today." ///
	 + " The HCI has three components: survival to age 5, health, and education. For more information on the HCI, please visit \url{www.worldbank.org/humancapitalproject}.")
	 
	 
////////////////////////////////////////////
gen lastspc_text = ///
	cond(lastspc< lastspc_mr & lastspc<lastspc_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1)) + " percent** of the poorest quintile is covered by" ///
	+ " social safety nets. This is lower than both the average for its region (" + strofreal(round(lastspc_mr,1)) + ") and the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
		cond(lastspc> lastspc_mr & lastspc>lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the poorest quintile is covered by" ///
		+ " social safety nets. This is higher than both the average for its region (" + strofreal(round(lastspc_mr,1)) + ") and the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
	   	cond(lastspc< lastspc_mr & lastspc>lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the poorest quintile is covered by" ///
		+ " social safety nets. This is lower than the average for its region (" + strofreal(round(lastspc_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
		cond(lastspc> lastspc_mr & lastspc<lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the poorest quintile is covered by" ///
		+ " social safety nets. This is higher than the average for its region (" + strofreal(round(lastspc_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
		""))))	if lastspc!=.
		
replace lastspc_text="In " + wbcountrynameb + ///
", data on the percentage of the population that is covered by social safety nets do not exist." + ///
" The average for the country's region is " + strofreal(round(lastspc_mr,1)) + " percent and for its income group is " + strofreal(round(lastspc_mr,1)) + " percent." if lastspc==.

replace lastspc_text = ///
	cond(dif_lastspc_targ>1, "In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1)) + " percent** of the poorest quintile is covered by" ///
	+ " social safety nets. This is higher than the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastspc_targ,1)) + ").", ///
		cond(dif_lastspc_targ<-1, "In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1)) + " percent** of the poorest quintile is covered by" ///
	+ " social safety nets. This is lower than the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastspc_targ,1)) + ").", ///
	 "In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1)) + " percent** of the poorest quintile is covered by" ///
	+ " social safety nets. This is roughly equal to the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastspc_targ,1)) + ").")) if wbregion=="Sub-Saharan Africa" &  lastspc!=.

	
		
replace lastspc_text="In " + wbcountrynameb + ///
", data on the percentage of the population that is covered by social safety nets do not exist." + ///
" The Africa Human Capital target for 2023 is " + strofreal(round(af_lastspc_targ,1)) + " percent." if  wbregion=="Sub-Saharan Africa" & lastspc==. 

	

	
	
	
//////////////////////////////////////////////	
gen lastod_text = ///
	cond(lastod< lastod_mr & lastod<lastod_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastod,1)) + " percent** of the population practices" ///
	+ " open defecation. This is lower than both the average for its region (" + strofreal(round(lastod_mr,1)) + ") and the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
		cond(lastod> lastod_mr & lastod>lastod_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is higher than both the average for its region (" + strofreal(round(lastod_mr,1)) + ") and the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
	   	cond(lastod< lastod_mr & lastod>lastod_mi,"In" + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is lower than the average for its region (" + strofreal(round(lastod_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
		cond(lastod> lastod_mr & lastod<lastod_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is higher than the average for its region (" + strofreal(round(lastod_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
		"")))) if lastod!=.
		
replace lastod_text="In " + wbcountrynameb + ///
", data on the percentage of the population that practices open defecation do not exist." + ///
" The average for the country's region is " + strofreal(round(lastod_mr,1)) + " percent and for its income group is " + strofreal(round(lastod_mr,1)) + " percent."  if lastod==.

replace lastod_text= ///
cond(dif_od_targ >1, "In " + wbcountrynameb + ", **" + strofreal(round(lastod,1)) + " percent** of the population practices" ///
	+ " open defecation. This is higher than the Africa Human Capital Target for 2023 (" + strofreal(round(af_od_targ,1)) + ").", ///
cond(dif_od_targ <-1, "In " + wbcountrynameb + ", **" + strofreal(round(lastod,1)) + " percent** of the population practices" ///
	+ " open defecation. This is lower than the Africa Human Capital Target for 2023 (" + strofreal(round(af_od_targ,1)) + ").", ///
    "In " + wbcountrynameb + ", **" + strofreal(round(lastod,1)) + " percent** of the population practices" ///
	+ " open defecation. This is roughly equal to the Africa Human Capital Target for 2023 (" + strofreal(round(af_od_targ,1)) + ")."))  if wbregion=="Sub-Saharan Africa" & lastod!=.
	
	
		
replace lastod_text="In " + wbcountrynameb + ///
", data on the percentage of the population that practices open defecation do not exist." + ///
" The Africa Human Capital target for 2023 is " + strofreal(round(af_od_targ,1)) + " percent." if wbregion=="Sub-Saharan Africa" & lastod==.
	
	
///////////////////////////////////////////////////////



gen lastafr_text = ///
	cond(lastafr< lastafr_mr & lastafr<lastafr_mi, "In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lastafr_mr,1)) + ") and the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
		cond(lastafr> lastafr_mr & lastafr>lastafr_mi,"In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lastafr_mr,1)) + ") and the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
	   	cond(lastafr< lastafr_mr & lastafr>lastafr_mi,"In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is lower than the average for its region (" + strofreal(round(lastafr_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
		cond(lastafr> lastafr_mr & lastafr<lastafr_mi,"In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is higher than the average for its region (" + strofreal(round(lastafr_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
		"")))) if lastafr!=.

replace lastafr_text= "In " + wbcountrynameb + ///
", data on the adolescent fertility rate do not exist." + ///
" The average for the country's region is " + strofreal(round(lastafr_mr,1)) + " births per 1,000 women ages 15-19 and for its income group is " + strofreal(round(lastafr_mr,1)) + "." if lastafr==.
 
replace lastafr_text= ///
cond(dif_lastafr_targ>1, "In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
	+ " This is higher than the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastafr_targ,1)) +  ").", ///
cond(dif_lastafr_targ<-1, "In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
	+ " This is lower than the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastafr_targ,1)) +  ").", ///
    "In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
	+ " This is roughly equal to the Africa Human Capital Target for 2023 (" + strofreal(round(af_lastafr_targ,1)) +  ").")) if  wbregion=="Sub-Saharan Africa" &  lastafr!=.
	
replace lastafr_text= "In " + wbcountrynameb + ///
", data on the adolescent fertility rate do not exist." + ///
" The Africa Human Capital target for 2023 is " + strofreal(round(af_lastafr_targ,1)) + " births per 1,000 women ages 15-19."  if wbregion=="Sub-Saharan Africa"  & lastafr==.
	
	

/////////////////////////////////

			   
gen lasttfr_text = ///
	cond(lasttfr< lasttfr_mr & lasttfr<lasttfr_mi, "In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr, 0.1)) + "** births per woman." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lasttfr_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lasttfr_mi,0.1)) + ").", ///
		cond(lasttfr> lasttfr_mr & lasttfr>lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,0.1)) + "** births per woman." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lasttfr_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lasttfr_mi,0.1)) + ").", ///
	   	cond(lasttfr< lasttfr_mr & lasttfr>lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,0.1)) + "** births per woman." ///
		+ " This is lower than the average for its region (" + strofreal(round(lasttfr_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(lasttfr_mi,0.1)) + ").", ///
		cond(lasttfr> lasttfr_mr & lasttfr<lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,0.1)) + "** births per woman." ///
		+ " This is higher than the average for its region (" + strofreal(round(lasttfr_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(lasttfr_mi,0.1)) + ").", ///
		"")))) if lasttfr!=.
		
replace lasttfr_text= "In " + wbcountrynameb + ///
", data on the total fertility rate do not exist." + ///
" The average for the country's region is " + strofreal(round(lasttfr_mr,1)) + " births per woman and for its income group is " + strofreal(round(lasttfr_mr,1)) + " births per woman." if lasttfr==.
///////////////////////////////
  
	


gen contracep_text = ///
	cond(contracep< contracep_mr & contracep<contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
	+ "method. This is lower than both the average for its region (" + strofreal(round(contracep_mr,1)) + ") and the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
		cond(contracep> contracep_mr & contracep>contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is higher than both the average for its region (" + strofreal(round(contracep_mr,1)) + ") and the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
	   	cond(contracep< contracep_mr & contracep>contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is lower than the average for its region (" + strofreal(round(contracep_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
		cond(contracep> contracep_mr & contracep<contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is higher than the average for its region (" + strofreal(round(contracep_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
		"")))) if contracep!=.
		
		
replace contracep_text= "In " + wbcountrynameb + ", data on contraceptive methods do not exist." + ///
" In the country's region, **" + strofreal(round(contracep_mr,1)) + " percent** of women ages 15-49 uses some form of contraceptive method," + ///
" and in the country's income group, **" + strofreal(round(contracep_mr,1)) + " percent uses it."  if contracep==.

////////////////////////////////

			
			

			
gen wbl_text = ///
	cond(wbl< wbl_mr & wbl<wbl_mi, "This index measures gender equality in the law (how the economic decisions women make are affected by the law), with a larger value showing higher gender equality." ///
	+ " In " + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is lower than both the average for its region (" + strofreal(round(wbl_mr,1)) + ") and the average" ///
	+ " for its income group (" + strofreal(round(wbl_mi,1)) + ").", /// 
		cond(wbl> wbl_mr & wbl>wbl_mi,  "This index measures gender equality in the law (how the economic decisions women make are affected by the law), with a larger value showing higher gender equality." ///
		+ " In " + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is higher than both the average for its region (" + strofreal(round(wbl_mr,1)) + ") and the average for its income group (" + strofreal(round(wbl_mi,1)) + ").", ///
		cond(wbl< wbl_mr & wbl>wbl_mi, "This index measures gender equality in the law (how the economic decisions women make are affected by the law), with a larger value showing higher gender equality." /// 
		+ " In " + wbcountrynameb +  ", the value is **"  + strofreal(round(wbl,1)) + "** out of 100. This is lower than the average for its region (" + strofreal(round(wbl_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(wbl_mi,1)) + ").", ///
		cond(wbl> wbl_mr & wbl<wbl_mi, "This index measures gender equality in the law (how the economic decisions women make are affected by the law), with a larger value showing higher gender equality." /// 
		+ " In " + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is higher than the average for its region" + strofreal(round(wbl_mr,1)) + "but lower than the average for its income group " + strofreal(round(wbl_mi,1)) + ".", ///
		"")))) if wbl!=.
		
		
		
replace wbl_text= "In " + wbcountrynameb + ///
", data on the women, business and the law index do not exist." + ///
" The average for the country's region is " + strofreal(round(wbl_mr,1)) + " and the average for its income group is " + strofreal(round(wbl_mr,1)) + "." if wbl==.

//////////////////////////////////////


gen lastner_sec_f_text = ///
	cond(lastner_sec_f< lastner_sec_f_mr & lastner_sec_f<lastner_sec_f_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of girls of secondary-school age are enrolled in secondary school." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") and the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
		cond(lastner_sec_f> lastner_sec_f_mr & lastner_sec_f>lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of girls of secondary-school age are enrolled in secondary school." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") and the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
	   	cond(lastner_sec_f< lastner_sec_f_mr & lastner_sec_f>lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of girls of secondary-school age are enrolled in secondary school." ///
		+ " This is lower than the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
		cond(lastner_sec_f>lastner_sec_f_mr & lastner_sec_f<lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of girls of secondary-school age are enrolled in secondary school." ///
		+ " This is higher than the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
		"")))) if lastner_sec_f!=.
		
		
		
replace lastner_sec_f_text= "In " + wbcountrynameb + ///
", data on secondary net enrolment rates for girls do not exist." + ///
" In its region **" + strofreal(round(lastner_sec_f_mr,1)) + ///
"** percent of girls of secondary-school age are enrolled in secondary school. The corresponding value for its income group is **"  + strofreal(round(lastner_sec_f_mr,1)) + "** percent." if lastner_sec_f==.
 
 
 ////////////////////////////////////////////
gen road_traff_text = ///
	cond(lastnm_road_traff< lastnm_road_traff_mr & lastnm_road_traff<lastnm_road_traff_mi, "In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1)) + " people** die due to road traffic injury" ///
	+ ". This is lower than both the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff> lastnm_road_traff_mr & lastnm_road_traff>lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is higher than both the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
	   	cond(lastnm_road_traff< lastnm_road_traff_mr & lastnm_road_traff>lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is lower than the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff> lastnm_road_traff_mr & lastnm_road_traff<lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is higher than the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff== lastnm_road_traff_mr & lastnm_road_traff==lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is similar to the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff== lastnm_road_traff_mr & lastnm_road_traff<lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is similar to the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff< lastnm_road_traff_mr & lastnm_road_traff==lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is lower than the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		cond(lastnm_road_traff== lastnm_road_traff_mr & lastnm_road_traff>lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is similar to the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
	    cond(lastnm_road_traff> lastnm_road_traff_mr & lastnm_road_traff==lastnm_road_traff_mi,"In " + wbcountrynameb + ", for every 100,000 people **" + strofreal(round(lastnm_road_traff,1))  + " people** die due to road traffic injury" ///
		+ ". This is higher than the average for its region (" + strofreal(round(lastnm_road_traff_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_road_traff_mi,1)) + ").", ///
		"")))))))))	if lastnm_road_traff!=.
		
replace road_traff_text="In " + wbcountrynameb + ///
", data on mortality due to road traffic injury do not exist." + ///
" The average number of road traffic deaths for the country's region is " + strofreal(round(lastnm_road_traff_mr,1)) + " people per 100,000 and for its income group is " + strofreal(round(lastnm_road_traff_mi,1)) + " people per 100,000." if lastnm_road_traff==.


	 
	 
////////////////////////////////////////////
gen electric_text = ///
	cond(lastnm_electric< lastnm_electric_mr & lastnm_electric<lastnm_electric_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1)) + " percent** of the population" ///
	+ " has access to electricity. This is lower than both the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric> lastnm_electric_mr & lastnm_electric>lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is higher than both the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
	   	cond(lastnm_electric< lastnm_electric_mr & lastnm_electric>lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is lower than the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric> lastnm_electric_mr & lastnm_electric<lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is higher than the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric== lastnm_electric_mr & lastnm_electric==lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is similar to the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric== lastnm_electric_mr & lastnm_electric<lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is similar to the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric< lastnm_electric_mr & lastnm_electric==lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is lower than the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric== lastnm_electric_mr & lastnm_electric>lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is similar to the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		cond(lastnm_electric> lastnm_electric_mr & lastnm_electric==lastnm_electric_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_electric,1))  + " percent** of the population" ///
		+ " has access to electricity. This is higher than the average for its region (" + strofreal(round(lastnm_electric_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_electric_mi,1)) + ").", ///
		"")))))))))	if lastnm_electric!=.
		
replace electric_text="In " + wbcountrynameb + ///
", data on the percentage of the population that has access to electricity do not exist." + ///
" The average for the country's region is " + strofreal(round(lastnm_electric_mr,1)) + " percent and for its income group is " + strofreal(round(lastnm_electric_mi,1)) + " percent." if lastnm_electric==.






////////////////////////////////////////////
gen clean_fuel_text = ///
	cond(lastnm_clean_fuel< lastnm_clean_fuel_mr & lastnm_clean_fuel<lastnm_clean_fuel_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1)) + " percent** of the population" ///
	+ " primarily uses clean cooking fuels. This is lower than both the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel> lastnm_clean_fuel_mr & lastnm_clean_fuel>lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is higher than both the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
	   	cond(lastnm_clean_fuel< lastnm_clean_fuel_mr & lastnm_clean_fuel>lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is lower than the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel> lastnm_clean_fuel_mr & lastnm_clean_fuel<lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is higher than the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel== lastnm_clean_fuel_mr & lastnm_clean_fuel==lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is similar to the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel== lastnm_clean_fuel_mr & lastnm_clean_fuel<lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is similar to the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel< lastnm_clean_fuel_mr & lastnm_clean_fuel==lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is lower than the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel== lastnm_clean_fuel_mr & lastnm_clean_fuel>lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is similar to the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		cond(lastnm_clean_fuel> lastnm_clean_fuel_mr & lastnm_clean_fuel==lastnm_clean_fuel_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_clean_fuel,1))  + " percent** of the population" ///
		+ " primarily uses clean cooking fuels. This is higher than the average for its region (" + strofreal(round(lastnm_clean_fuel_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_clean_fuel_mi,1)) + ").", ///
		"")))))))))	if lastnm_clean_fuel!=.
		
replace clean_fuel_text="In " + wbcountrynameb + ///
", data on the percentage of the population that primarily uses clean cooking fuels do not exist." + ///
" The average for the country's region is " + strofreal(round(lastnm_clean_fuel_mr,1)) + " percent and for its income group is " + strofreal(round(lastnm_clean_fuel_mi,1)) + " percent." if lastnm_clean_fuel==.









////////////////////////////////////////////
gen hygiene_basic_text = ///
	cond(lastnm_hygiene_basic< lastnm_hygiene_basic_mr & lastnm_hygiene_basic<lastnm_hygiene_basic_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1)) + " percent** of the population" ///
	+ " has basic hygiene services (soap and water). This is lower than both the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic> lastnm_hygiene_basic_mr & lastnm_hygiene_basic>lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is higher than both the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
	   	cond(lastnm_hygiene_basic< lastnm_hygiene_basic_mr & lastnm_hygiene_basic>lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is lower than the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic> lastnm_hygiene_basic_mr & lastnm_hygiene_basic<lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is higher than the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic== lastnm_hygiene_basic_mr & lastnm_hygiene_basic==lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is similar to the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic== lastnm_hygiene_basic_mr & lastnm_hygiene_basic<lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is similar to the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic< lastnm_hygiene_basic_mr & lastnm_hygiene_basic==lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is lower than the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic== lastnm_hygiene_basic_mr & lastnm_hygiene_basic>lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is similar to the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		cond(lastnm_hygiene_basic> lastnm_hygiene_basic_mr & lastnm_hygiene_basic==lastnm_hygiene_basic_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_hygiene_basic,1))  + " percent** of the population" ///
		+ " has basic hygiene services (soap and water). This is higher than the average for its region (" + strofreal(round(lastnm_hygiene_basic_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_hygiene_basic_mi,1)) + ").", ///
		"")))))))))	if lastnm_hygiene_basic!=.
		
replace hygiene_basic_text="In " + wbcountrynameb + ///
", data on the percentage of the population that has basic hygiene services (soap and water) do not exist." + ///
" The average for the country's region is " + strofreal(round(lastnm_hygiene_basic_mr,1)) + " percent and for its income group is " + strofreal(round(lastnm_hygiene_basic_mi,1)) + " percent." if lastnm_hygiene_basic==.









////////////////////////////////////////////
gen water_text = ///
	cond(lastnm_water_basic_plus< lastnm_water_basic_plus_mr & lastnm_water_basic_plus<lastnm_water_basic_plus_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1)) + " percent** of the population" ///
	+ " has at least basic source of drinking water. This is lower than both the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus> lastnm_water_basic_plus_mr & lastnm_water_basic_plus>lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is higher than both the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
	   	cond(lastnm_water_basic_plus< lastnm_water_basic_plus_mr & lastnm_water_basic_plus>lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is lower than the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus> lastnm_water_basic_plus_mr & lastnm_water_basic_plus<lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is higher than the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus== lastnm_water_basic_plus_mr & lastnm_water_basic_plus==lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is similar to the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus== lastnm_water_basic_plus_mr & lastnm_water_basic_plus<lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is similar to the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus< lastnm_water_basic_plus_mr & lastnm_water_basic_plus==lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is lower than the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus== lastnm_water_basic_plus_mr & lastnm_water_basic_plus>lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is similar to the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		cond(lastnm_water_basic_plus> lastnm_water_basic_plus_mr & lastnm_water_basic_plus==lastnm_water_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_water_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic source of drinking water. This is higher than the average for its region (" + strofreal(round(lastnm_water_basic_plus_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_water_basic_plus_mi,1)) + ").", ///
		"")))))))))	if lastnm_water_basic_plus!=.
		
replace water_text="In " + wbcountrynameb + ///
", data on the percentage of the population that has at least basic source of drinking water do not exist." + ///
" The average for the country's region is " + strofreal(round(lastnm_water_basic_plus_mr,1)) + " percent and for its income group is " + strofreal(round(lastnm_water_basic_plus_mi,1)) + " percent." if lastnm_water_basic_plus==.












////////////////////////////////////////////
gen sanit_text = ///
	cond(lastnm_sanit_basic_plus< lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus<lastnm_sanit_basic_plus_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1)) + " percent** of the population" ///
	+ " has at least basic sanitation. This is lower than both the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus> lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus>lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is higher than both the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
	   	cond(lastnm_sanit_basic_plus< lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus>lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is lower than the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus> lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus<lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is higher than the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus== lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus==lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is similar to the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") and the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus== lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus<lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is similar to the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus< lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus==lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is lower than the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus== lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus>lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is similar to the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		cond(lastnm_sanit_basic_plus> lastnm_sanit_basic_plus_mr & lastnm_sanit_basic_plus==lastnm_sanit_basic_plus_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastnm_sanit_basic_plus,1))  + " percent** of the population" ///
		+ " has at least basic sanitation. This is higher than the average for its region (" + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + ") but is similar to the average for its income group (" + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + ").", ///
		"")))))))))	if lastnm_sanit_basic_plus!=.
		
replace sanit_text="In " + wbcountrynameb + ///
", data on the percentage of the population that has at least basic sanitation do not exist." + ///
" The average for the country's region is " + strofreal(round(lastnm_sanit_basic_plus_mr,1)) + " percent and for its income group is " + strofreal(round(lastnm_sanit_basic_plus_mi,1)) + " percent." if lastnm_sanit_basic_plus==.







			
			
////////////////////////////////////
gen hci_mem = ///
  cond(hcicountry == 1, "has",   ///
  cond(hcicountry  ==0, "has not yet",           ///
           ""))
gen hci_memt="" + wbcountrynameB + " " + hci_mem + " signed up to be a member of the Human Capital Project." 
/////////////////////////////////////
gen edu_comp_mrmi = ///
         cond(lastnm_exp_total_percgdp_raw< lastnm_exp_total_percgdp_raw_mr & lastnm_exp_total_percgdp_raw<lastnm_exp_total_percgdp_raw_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(lastnm_exp_total_percgdp_raw_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_exp_total_percgdp_raw_mi,0.1)) + ").",    /* 
*/       cond( lastnm_exp_total_percgdp_raw> lastnm_exp_total_percgdp_raw_mr & lastnm_exp_total_percgdp_raw>lastnm_exp_total_percgdp_raw_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(lastnm_exp_total_percgdp_raw_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_exp_total_percgdp_raw_mi,0.1)) + ").",     /* 
*/       cond( lastnm_exp_total_percgdp_raw< lastnm_exp_total_percgdp_raw_mr & lastnm_exp_total_percgdp_raw>lastnm_exp_total_percgdp_raw_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(lastnm_exp_total_percgdp_raw_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_exp_total_percgdp_raw_mi,0.1)) + ").", /* 
*/       cond(lastnm_exp_total_percgdp_raw> lastnm_exp_total_percgdp_raw_mr & lastnm_exp_total_percgdp_raw<lastnm_exp_total_percgdp_raw_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(lastnm_exp_total_percgdp_raw_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_exp_total_percgdp_raw_mi,0.1)) + ").", /*        
*/ "")))) if lastnm_exp_total_percgdp_raw!=.

gen edu_text="" + wbcountrynameB + /// we still need to specify for missing data cases
" spends **" + strofreal(round(lastnm_exp_total_percgdp_raw,0.1)) + ///
" percent** of its GDP on education. "  /// 
+ edu_comp_mrmi + ""

replace edu_text="In " + wbcountrynameb + ///
", data on education spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(lastnm_exp_total_percgdp_raw_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(lastnm_exp_total_percgdp_raw_mi,0.1)) + " percent." if lastnm_exp_total_percgdp_raw==.


////////////////////////////////////////

gen health_comp_mrmi = ///
         cond(lastnm_domphegdp< lastnm_domphegdp_mr & lastnm_domphegdp<lastnm_domphegdp_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(lastnm_domphegdp_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_domphegdp_mi,0.1)) + ").",    /* 
*/       cond( lastnm_domphegdp> lastnm_domphegdp_mr & lastnm_domphegdp>lastnm_domphegdp_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(lastnm_domphegdp_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_domphegdp_mi,0.1)) + ").",     /* 
*/       cond( lastnm_domphegdp< lastnm_domphegdp_mr & lastnm_domphegdp>lastnm_domphegdp_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(lastnm_domphegdp_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_domphegdp_mi,0.1)) + ").", /* 
*/       cond(lastnm_domphegdp> lastnm_domphegdp_mr & lastnm_domphegdp<lastnm_domphegdp_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(lastnm_domphegdp_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_domphegdp_mi,0.1)) + ").", /*        
*/ "")))) if lastnm_domphegdp!=.

gen health_text="" + wbcountrynameB + ///
" spends **" + strofreal(round(lastnm_domphegdp,0.1)) + ///
" percent** of its GDP on health. "  ///
+ health_comp_mrmi + ""

replace health_text="In " + wbcountrynameb + ///
", data on health spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(lastnm_domphegdp_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(lastnm_domphegdp_mi,0.1)) + " percent." if lastnm_domphegdp==.


//////////////////////////////////////////

gen socprot_comp_mrmi = ///
         cond(lastnm_all_soc_ass_pctgdp< lastnm_all_soc_ass_pctgdp_mr & lastnm_all_soc_ass_pctgdp<lastnm_all_soc_ass_pctgdp_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mi,0.1)) + ").",    /* 
*/       cond( lastnm_all_soc_ass_pctgdp> lastnm_all_soc_ass_pctgdp_mr & lastnm_all_soc_ass_pctgdp>lastnm_all_soc_ass_pctgdp_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mi,0.1)) + ").",     /* 
*/       cond( lastnm_all_soc_ass_pctgdp< lastnm_all_soc_ass_pctgdp_mr & lastnm_all_soc_ass_pctgdp>lastnm_all_soc_ass_pctgdp_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mi,0.1)) + ").", /* 
*/       cond(lastnm_all_soc_ass_pctgdp> lastnm_all_soc_ass_pctgdp_mr & lastnm_all_soc_ass_pctgdp<lastnm_all_soc_ass_pctgdp_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(lastnm_all_soc_ass_pctgdp_mi,0.1)) + ").", /*        
*/ "")))) if lastnm_all_soc_ass_pctgdp!=.

gen socprot_text="" + wbcountrynameB + ///
" spends **" + strofreal(round(lastnm_all_soc_ass_pctgdp,0.1)) + ///
" percent** of its GDP on social assistance. "  ///
+ socprot_comp_mrmi + ""

replace socprot_text="In " + wbcountrynameb + ///
", data on social assistance spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(lastnm_all_soc_ass_pctgdp_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(lastnm_all_soc_ass_pctgdp_mi,0.1)) + " percent." if lastnm_all_soc_ass_pctgdp==.


///////////////////////////////////////////

gen effic = ///
  cond(difhcipred > 0, "higher",   ///
  cond(difhcipred < 0, "lower",           ///
  "")) if health_ed_sp_pc!=. & hci_mf!=.
 
replace effic = ///
  cond(difhcipred1 > 0, "higher",   ///
  cond(difhcipred1 < 0, "lower",           ///
  "")) if health_ed_sp_pc==. & health_ed_pc!=. & hci_mf!=.
 
 
gen eff_text = " The HCI in " + wbcountrynameb + ///
" is **" + effic + "** than what would be predicted for its level of per capita government spending on the social sectors." if health_ed_sp_pc!=. & hci_mf!=.

replace eff_text = " The HCI in " + wbcountrynameb + ///
" is **" + effic + "** than what would be predicted for its level of per capita government spending on health and education." if health_ed_sp_pc==. & hci_mf!=. & health_ed_pc!=.

replace eff_text="Given the lack of data, it is not possible to predict if the HCI in " + wbcountrynameb + ///
" is higher or lower than what would be predicted for its level of per capita government spending."  if (difhcipred==. | difhcipred1==. | hci_mf==.)

/////////////////////////////////////////


gen drm_comp_mrmi = ///
         cond(drm< drm_mr & drm<drm_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(drm_mr,0.1)) + ") and the average for its income group (" + strofreal(round(drm_mi,0.1)) + ").",    /* 
*/       cond( drm> drm_mr & drm>drm_mi,                         /* 
*/ " This is higher than both the regional average (" + strofreal(round(drm_mr,0.1)) + ") and the average for its income group (" + strofreal(round(drm_mi,0.1)) + ").",     /* 
*/       cond( drm< drm_mr & drm>drm_mi,                         /* 
*/ " This is lower than  the average for its region (" + strofreal(round(drm_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(drm_mi,0.1)) + ").", /* 
*/       cond(drm> drm_mr & drm<drm_mi,                         /* 
*/ " This is higher than  the average for its region (" + strofreal(round(drm_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(drm_mi,0.1)) + ").", /*        
*/ "")))) if drm!=.

gen drm_text=" The tax revenue in " + wbcountrynameb + ///
" is **" + strofreal(round(drm,0.1)) + ///
"** percent of GDP." + drm_comp_mrmi + "" 


replace drm_text="In " + wbcountrynameb + ///
", data on domestic resource mobilization do not exist." + ///
" The average for the country's region is "  + strofreal(round(drm_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(drm_mi,0.1)) + " percent." if drm==.

///////////////////////////////////////////////


gen cpia_comp_mrmi= ///
         cond(lastcpia_hr< lastcpia_hr_mr & lastcpia_hr<lastcpia_hr_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(lastcpia_hr_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastcpia_hr_mi,0.1)) + ").",    /* 
*/       cond( lastcpia_hr> lastcpia_hr_mr & lastcpia_hr>lastcpia_hr_mi,                         /* 
*/ " This is higher than both the regional average (" + strofreal(round(lastcpia_hr_mr,0.1)) + ") and the average for its income group (" + strofreal(round(lastcpia_hr_mi,0.1)) + ").",     /* 
*/       cond( lastcpia_hr< lastcpia_hr_mr & lastcpia_hr>lastcpia_hr_mi,                         /* 
*/ " This is lower than  the average for its region (" + strofreal(round(lastcpia_hr_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(lastcpia_hr_mi,0.1)) + ").", /* 
*/       cond(lastcpia_hr> lastcpia_hr_mr & lastcpia_hr<lastcpia_hr_mi,                         /* 
*/ " This is higher than  the average for its region (" + strofreal(round(lastcpia_hr_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(lastcpia_hr_mi,0.1)) + ").", /*        
*/ "")))) if lastcpia_hr!=.

gen cpia_text=" The Country Policy and Institutional Assesment rating for building human resources in "  /// 
+ wbcountrynameb + " is **" + strofreal(round(lastcpia_hr,0.1)) + ///
"** (1 is low and 6 is high)." + cpia_comp_mrmi + ///
" This indicator assesses the national policies and public" + ///
" and private sector service delivery that affect access to and quality" + /// 
" of health and education services."

replace cpia_text="In " + wbcountrynameb + ///
", data on the Country Policy and Institutional Assesment rating for building human resources do not exist." + ///
" The average for the country's region is "  + strofreal(round(lastcpia_hr_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(lastcpia_hr_mi,0.1)) + " percent." + ///
" This indicator assesses the national policies and public and private sector service delivery" + ///
" that affect access to and quality of health and education services." if lastcpia_hr==.




///////////////////////////////////////////


gen ident_comp= ///
         cond(unregpop_share< unregpop_share_mr & unregpop_share<unregpop_share_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(unregpop_share_mr,0.1)) + ") and the average for its income group (" + strofreal(round(unregpop_share_mi,0.1)) + ").",    /* 
*/       cond( unregpop_share> unregpop_share_mr & unregpop_share>unregpop_share_mi,                         /* 
*/ " This is higher than both the regional average (" + strofreal(round(unregpop_share_mr,0.1)) + ") and the average for its income group (" + strofreal(round(unregpop_share_mi,0.1)) + ").",     /* 
*/       cond( unregpop_share< unregpop_share_mr & unregpop_share>unregpop_share_mi,                         /* 
*/ " This is lower than  the average for its region (" + strofreal(round(unregpop_share_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(unregpop_share_mi,0.1)) + ").", /* 
*/       cond(unregpop_share> unregpop_share_mr & unregpop_share<unregpop_share_mi,                         /* 
*/ " This is higher than  the average for its region (" + strofreal(round(unregpop_share_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(unregpop_share_mi,0.1)) + ").", /*        
*/ "")))) if unregpop_share!=.

gen ident_text="In " + wbcountrynameb+ ///
", **" + strofreal(round(unregpop_share,0.1)) + ///
" percent** of the population is not registered."  ///
+ ident_comp + ""

replace ident_text="In " + wbcountrynameb + ///
", data on the percentage of the population that is not registered do not exist." + ///
" The average for the country's region is "  + strofreal(round(unregpop_share_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(unregpop_share_mi,0.1)) + " percent." if unregpop_share==.

////////////////////////////////////////





format %9.0fc hci_mf_100
format %9.0fc lastspc
format %9.0fc lastspc_mr
format %9.0fc lastspc_mi
format %9.0fc lastod
format %9.0fc lastod_mr
format %9.0fc lastod_mi
format %9.1fc lasttfr
format %9.1fc lasttfr_mr
format %9.1fc lasttfr_mi
format %9.0fc lastafr
format %9.0fc lastafr_mr
format %9.0fc lastafr_mi
format %9.0fc contracep
format %9.0fc contracep_mr
format %9.0fc contracep_mi
format %9.0fc wbl
format %9.0fc wbl_mr
format %9.0fc wbl_mi
format %9.0fc lastner_sec_f
format %9.0fc lastner_sec_f_mr
format %9.0fc lastner_sec_f_mi
format %9.1fc drm
format %9.1fc drm_mr
format %9.1fc drm_mi
format %9.1fc lastcpia_hr
format %9.1fc lastcpia_hr_mr
format %9.1fc lastcpia_hr_mi
format %9.0fc unregpop_share
format %9.0fc unregpop_share_mr
format %9.0fc unregpop_share_mi



save "input/text_for_illustrative_indicators.dta", replace





////////////////////////////////////////////////////////////////////////////////////END/////////////////////////////







