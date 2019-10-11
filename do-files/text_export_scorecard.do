
/*
OBJECTIVE: GENERATE TEXT FOR HCI SCORECARD
AUTHOR: MARTIN DE SIMONE AND ZELALEM YILMA DEBEBE
DATE: AUGUST 07 2019

*/

clear all
set more off	
set maxvar 32000

*set up directory and filepath to database 

if ( lower("`c(username)'") == "wb469563") {
	global root "C:\Users\WB469563\OneDrive - WBG\Documents (zdebebe@worldbank.org)\OneDrive - WBG\Documents (zdebebe@worldbank.org)\Human Capital Project\CHI_AM19_scorecard"
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

use "input/scorecardanalysis_2019-10-03.dta", clear 
graph set window fontface "Fourier"




//Preliminaries 

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


* Create variable with capital The for countries with there

gen wbcountrynameB = cond(regexm(wbcountrynameb, "^the "), /* 
 */ "T"+ substr(wbcountrynameb, 2, .), wbcountrynameb)


gen af_hcitarg = 45
gen af_odtarg = 15
gen af_lastspctarg = 30
gen af_lastafrtarg = 83








foreach var of varlist lastner_sec_f drm lastcpia_hr unregpop lasttime_nostu_rep ///
lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share ///
spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share ///
do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ///
ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu ///
disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd ///
crossgpshare_edu crossgpshare_hnp crossgpshare_spj {
     egen `var'_sdr=sd(`var') if year==2017, by(region)
	 egen `var'_sdi=sd(`var') if year==2017, by(income)
	 }


gen hci_mf_100= hci_mf*100


foreach gender in mf {
foreach var of varlist lastner_sec_f hci_`gender' tnep_`gender' nostu_`gender' asr_`gender' ///
psurv_`gender' test_`gender' eyrs_`gender' lastod lastodcomp lasttfr lastafr contracep wbl ///
unregpop_share unregpopcomp lastspc ner drm lastcpia_hr unregpop lasttime_nostu_rep ///
lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share ///
spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share ///
do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ///
ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu ///
disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd ///
crossgpshare_edu crossgpshare_hnp crossgpshare_spj ///
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
gen r="R"
gen i="I"

	
//for gender analyses
gen onesvec=1
gen twosvec=2 
gen threesvec=3
xtile mquart=hci_m if year==2017, nq(4)
xtile fquart=hci_f if year==2017, nq(4)


							
////FOR FIGURE 2 
							
egen edugov_mi=mean( edugov ) if year==2017, by(wbincomegroup)
egen edugov_mr=mean( edugov ) if year==2017, by(wbregion)
egen socprotgov_mi=mean( socprotgov ) if year==2017, by(wbincomegroup)
egen socprotgov_mr=mean( socprotgov ) if year==2017, by(wbregion)
egen healthgov_mi=mean( healthgov ) if year==2017, by(wbincomegroup)
egen healthgov_mr=mean(healthgov ) if year==2017, by(wbregion)

gen x=. //for no show bars in twoway bar graphs
gen y=.
gen a=1
gen b=2
gen c=3
gen d=4
gen e=5
gen f=6
gen g=7
gen h=8
gen j=9
gen k=10
gen l=11

//FOR FIGURE 3 AND TEXT
gen log_health_ed_sp_pc = log(health_ed_sp_pc)
gen log_health_ed_pc = log(health_ed_pc) //Health and education spending per capita in logs (see another dofile I used to generate this)


gen show=1 if ///
wbcountryname=="Chad" | wbcountryname=="Bangladesh" | wbcountryname=="Ethiopia" | ///
wbcountryname=="Kenya" | wbcountryname=="Angola"| wbcountryname=="Georgia" | ///
wbcountryname=="Kazakhstan"| wbcountryname=="Brazil" | wbcountryname=="Botswana" | wbcountryname=="Slovenia" 

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

reg drm lny  if drm<25
predict pdrm
gen difdrmpred = drm-pdrm

		
egen nm=rownonmiss(lny drm hci_mf health_ed_pc) //how many countries have nonmissing data for figure 2,3 and 4
tab nm
	
replace  hcicountry=1 if (wbcountryname=="Tanzania" | wbcountryname=="Cambodia") 
replace  hcicountry=1 if (wbcountryname=="Ireland" | wbcountryname=="The Republic of Yemen") 
replace  hcicountry=1 if (wbcountryname=="The Democratic Republic of Congo" ) //we have 68 hcp countries 
	
	
///////////////////////////////////////////////for AFRICA			
gen af_hci_mf_targ =0.45 //for graph line 	
//gen hci_mf_100 = hci_mf*100
gen af_hci_targ = 45 //for text 
gen af_od_targ = 15
gen af_lastspc_targ = 30
gen af_lastafr_targ = 83


gen dif_hci_targ = hci_mf_100 - af_hci_targ
gen dif_od_targ = lastod - af_od_targ
gen dif_lastspc_targ = lastspc - af_lastspc_targ
gen dif_lastafr_targ = lastafr - af_lastafr_targ



/////////////////////////////////////////////////////////////////////////////////////////////////////////

****Creating additional variables*****
gen hdportfolio_share_diffmr = hdportfolio_share - hdportfolio_share_mr	
gen eduportfolio_share_diffmr = eduportfolio_share - eduportfolio_share_mr	
gen hnpportfolio_share_diffmr = hnpportfolio_share - hnpportfolio_share_mr	
gen spjportfolio_share_diffmr= spjportfolio_share - spjportfolio_share_mr
gen hdportfolio_share_diffmi = hdportfolio_share - hdportfolio_share_mi	
gen eduportfolio_share_diffmi = eduportfolio_share - eduportfolio_share_mi	
gen hnpportfolio_share_diffmi = hnpportfolio_share - hnpportfolio_share_mi	
gen spjportfolio_share_diffmi= spjportfolio_share - spjportfolio_share_mi
gen pipeline_hd_share_diffmr = pipeline_hd_share - pipeline_hd_share_mr	
gen pipeline_edu_share_diffmr = pipeline_edu_share - pipeline_edu_share_mr	
gen pipeline_hnp_share_diffmr = pipeline_hnp_share - pipeline_hnp_share_mr	
gen pipeline_spj_share_diffmr = pipeline_spj_share - pipeline_spj_share_mr
gen pipeline_hd_share_diffmi = pipeline_hd_share - pipeline_hd_share_mi	
gen pipeline_edu_share_diffmi = pipeline_edu_share - pipeline_edu_share_mi	
gen pipeline_hnp_share_diffmi = pipeline_hnp_share - pipeline_hnp_share_mi	
gen pipeline_spj_share_diffmi = pipeline_spj_share - pipeline_spj_share_mi
gen do_performance_hd_diffmr = do_performance_hd - do_performance_hd_mr	
gen do_performance_edu_diffmr = do_performance_edu - do_performance_edu_mr	
gen do_performance_hnp_diffmr = do_performance_hnp - do_performance_hnp_mr	
gen do_performance_spj_diffmr = do_performance_spj - do_performance_spj_mr
gen do_performance_hd_diffmi = do_performance_hd - do_performance_hd_mi	
gen do_performance_edu_diffmi = do_performance_edu - do_performance_edu_mi	
gen do_performance_hnp_diffmi = do_performance_hnp - do_performance_hnp_mi	
gen do_performance_spj_diffmi = do_performance_spj - do_performance_spj_mi
gen ip_performance_hd_diffmr = ip_performance_hd - ip_performance_hd_mr	
gen ip_performance_edu_diffmr = ip_performance_edu - ip_performance_edu_mr	
gen ip_performance_hnp_diffmr = ip_performance_hnp - ip_performance_hnp_mr	
gen ip_performance_spj_diffmr = ip_performance_spj - ip_performance_spj_mr
gen ip_performance_hd_diffmi = ip_performance_hd - ip_performance_hd_mi	
gen ip_performance_edu_diffmi = ip_performance_edu - ip_performance_edu_mi	
gen ip_performance_hnp_diffmi = ip_performance_hnp - ip_performance_hnp_mi	
gen ip_performance_spj_diffmi = ip_performance_spj - ip_performance_spj_mi
gen disburratio_hd_diffmr = disburratio_hd - disburratio_hd_mr
gen disburratio_edu_diffmr = disburratio_edu - disburratio_edu_mr
gen disburratio_hnp_diffmr = disburratio_hnp - disburratio_hnp_mr
gen disburratio_spj_diffmr = disburratio_spj - disburratio_spj_mr
gen disburratio_hd_diffmi = disburratio_hd - disburratio_hd_mi
gen disburratio_edu_diffmi = disburratio_edu - disburratio_edu_mi
gen disburratio_hnp_diffmi = disburratio_hnp - disburratio_hnp_mi
gen disburratio_spj_diffmi = disburratio_spj - disburratio_spj_mi
gen avgsize_hd_diffmr = avgsize_hd - avgsize_hd_mr
gen avgsize_edu_diffmr = avgsize_edu - avgsize_edu_mr
gen avgsize_hnp_diffmr = avgsize_hnp - avgsize_hnp_mr
gen avgsize_spj_diffmr = avgsize_spj - avgsize_spj_mr
gen avgsize_hd_diffmi = avgsize_hd - avgsize_hd_mi
gen avgsize_edu_diffmi = avgsize_edu - avgsize_edu_mi
gen avgsize_hnp_diffmi = avgsize_hnp - avgsize_hnp_mi
gen avgsize_spj_diffmi = avgsize_spj - avgsize_spj_mi
gen crossgpshare_hd_diffmr = crossgpshare_hd - crossgpshare_hd_mr
gen crossgpshare_edu_diffmr = crossgpshare_edu - crossgpshare_edu_mr	
gen crossgpshare_hnp_diffmr = crossgpshare_hnp - crossgpshare_hnp_mr
gen crossgpshare_spj_diffmr = crossgpshare_spj - crossgpshare_spj_mr
gen crossgpshare_hd_diffmi = crossgpshare_hd - crossgpshare_hd_mi
gen crossgpshare_edu_diffmi = crossgpshare_edu - crossgpshare_edu_mi	
gen crossgpshare_hnp_diffmi = crossgpshare_hnp - crossgpshare_hnp_mi
gen crossgpshare_spj_diffmi = crossgpshare_spj - crossgpshare_spj_mi
	
****Creat variables for percentiles****
xtile terc_hdportfolio_share = hdportfolio_share, nq(3)
xtile terc_eduportfolio_share = eduportfolio_share, nq(3)
xtile terc_hnpportfolio_share = hnpportfolio_share, nq(3)
xtile terc_spjportfolio_share = spjportfolio_share, nq(3)
xtile terc_pipeline_hd_share = pipeline_hd_share, nq(3)	
xtile terc_pipeline_edu_share = pipeline_edu_share, nq(3)	
xtile terc_pipeline_hnp_share = pipeline_hnp_share, nq(3)	
xtile terc_pipeline_spj_share = pipeline_spj_share, nq(3)	
xtile terc_do_performance_hd = do_performance_hd, nq(3)	
xtile terc_do_performance_edu = do_performance_edu, nq(3)
xtile terc_do_performance_hnp = do_performance_hnp, nq(3)
xtile terc_do_performance_spj = do_performance_spj, nq(3)
xtile terc_ip_performance_hd = ip_performance_hd, nq(3)	
xtile terc_ip_performance_edu = ip_performance_edu, nq(3)
xtile terc_ip_performance_hnp = ip_performance_hnp, nq(3)
xtile terc_ip_performance_spj = ip_performance_spj, nq(3)
xtile terc_disburratio_hd = disburratio_hd, nq(3)
xtile terc_disburratio_edu = disburratio_edu, nq(3)
xtile terc_disburratio_hnp = disburratio_hnp, nq(3)
xtile terc_disburratio_spj = disburratio_spj, nq(3)
xtile terc_avgsize_hd = avgsize_hd, nq(3)
xtile terc_avgsize_edu = avgsize_edu, nq(3)
xtile terc_avgsize_hnp = avgsize_hnp, nq(3)
xtile terc_avgsize_spj = avgsize_spj, nq(3)
xtile terc_crossgpshare_hd = crossgpshare_hd, nq(3)
xtile terc_crossgpshare_edu = crossgpshare_edu, nq(3)
xtile terc_crossgpshare_hnp = crossgpshare_hnp, nq(3)
xtile terc_crossgpshare_spj = crossgpshare_spj, nq(3)
	

/// round so we dont end up with > when indeed the same value in the text
foreach j of varlist lastnm_water_basic_plus lastnm_sanit_basic_plus lastnm_hygiene_basic lastnm_road_traff lastnm_clean_fuel lastnm_electric ///
 lastnm_water_basic_plus_mr lastnm_sanit_basic_plus_mr lastnm_hygiene_basic_mr lastnm_road_traff_mr lastnm_clean_fuel_mr lastnm_electric_mr ///
 lastnm_water_basic_plus_mi lastnm_sanit_basic_plus_mi lastnm_hygiene_basic_mi lastnm_road_traff_mi lastnm_clean_fuel_mi lastnm_electric_mi {
replace `j'=round(`j',1)
}


****Keep only variables that are relevant for analysis***	
*preserve
*keep wbcode lastner_sec_f lastner_sec_f_mr lastner_sec_f_mi lastner_sec_f_sdr lastner_sec_f_sdm percsatisfip_hd percsatisfip_edu percsatisfip_hnp percsatisfip_spj percsatisfdo_hd percsatisfdo_edu percsatisfdo_hnp percsatisfdo_spj avgsize_hd avgsize_edu avgsize_hnp avgsize_spj hdportfolio eduportfolio hnpportfolio spjportfolio pipeline_hd pipeline_edu pipeline_hnp pipeline_spj terc_disburratio_spj terc_avgsize_hd terc_avgsize_edu terc_avgsize_hnp terc_avgsize_spj terc_crossgpshare_hd terc_crossgpshare_edu terc_crossgpshare_hnp terc_crossgpshare_spj terc_ip_performance_hd terc_ip_performance_edu terc_ip_performance_hnp terc_ip_performance_spj terc_disburratio_hd terc_disburratio_edu terc_disburratio_hnp terc_pipeline_hnp_share terc_pipeline_spj_share terc_do_performance_hd terc_do_performance_edu terc_do_performance_hnp terc_do_performance_spj terc_hdportfolio_share 	terc_eduportfolio_share terc_hnpportfolio_share terc_spjportfolio_share terc_pipeline_hd_share terc_pipeline_edu_share  hdportfolio_share_sdr hdportfolio_share_sdi eduportfolio_share_sdr eduportfolio_share_sdi hnpportfolio_share_sdr hnpportfolio_share_sdi spjportfolio_share_sdr spjportfolio_share_sdi pipeline_hd_share_sdr pipeline_hd_share_sdi pipeline_edu_share_sdr pipeline_edu_share_sdi pipeline_hnp_share_sdr pipeline_hnp_share_sdi pipeline_spj_share_sdr pipeline_spj_share_sdi do_performance_hd_sdr do_performance_hd_sdi do_performance_edu_sdr do_performance_edu_sdi do_performance_hnp_sdr do_performance_hnp_sdi do_performance_spj_sdr do_performance_spj_sdi ip_performance_hd_sdr ip_performance_hd_sdi ip_performance_edu_sdr ip_performance_edu_sdi ip_performance_hnp_sdr ip_performance_hnp_sdi ip_performance_spj_sdr ip_performance_spj_sdi disburratio_hd_sdr disburratio_hd_sdi disburratio_edu_sdr disburratio_edu_sdi disburratio_hnp_sdr disburratio_hnp_sdi disburratio_spj_sdr disburratio_spj_sdi avgsize_hd_sdr avgsize_hd_sdi avgsize_edu_sdr avgsize_edu_sdi avgsize_hnp_sdr avgsize_hnp_sdi avgsize_spj_sdi crossgpshare_hd_sdr crossgpshare_hd_sdi crossgpshare_edu_sdr crossgpshare_edu_sdi crossgpshare_hnp_sdr crossgpshare_hnp_sdi crossgpshare_spj_sdr crossgpshare_spj_sdi crossgpshare_spj_diffmi crossgpshare_hnp_diffmi crossgpshare_edu_diffmi crossgpshare_hd_diffmi crossgpshare_spj_diffmr crossgpshare_hnp_diffmr crossgpshare_edu_diffmr crossgpshare_hd_diffmr  avgsize_spj_diffmi avgsize_hnp_diffmi avgsize_edu_diffmi avgsize_hd_diffmi avgsize_spj_diffmr  avgsize_hnp_diffmr  avgsize_edu_diffmi  avgsize_hd_diffmi avgsize_spj_diffmr avgsize_hnp_diffmr  avgsize_edu_diffmr  avgsize_hd_diffmr  disburratio_hd_diffmi disburratio_edu_diffmi disburratio_hnp_diffmi disburratio_spj_diffmi disburratio_hd_diffmr disburratio_edu_diffmr disburratio_hnp_diffmr disburratio_spj_diffmr ip_performance_spj_diffmi ip_performance_hnp_diffmi ip_performance_edu_diffmi ip_performance_hd_diffmi  ip_performance_spj_diffmr ip_performance_hnp_diffmr  ip_performance_edu_diffmr  ip_performance_hd_diffmr do_performance_spj_diffmi do_performance_hnp_diffmi do_performance_edu_diffmi do_performance_hd_diffmi do_performance_spj_diffmr do_performance_hnp_diffmr do_performance_edu_diffmr do_performance_hd_diffmr pipeline_spj_share_diffmi  pipeline_hnp_share_diffmi  pipeline_edu_share_diffmi pipeline_hd_share_diffmi pipeline_spj_share_diffmr pipeline_hnp_share_diffmr  pipeline_edu_share_diffmr  pipeline_hd_share_diffmr  spjportfolio_share_diffmi hnpportfolio_share_diffmi hdportfolio_share_diffmr  eduportfolio_share_diffmr hnpportfolio_share_diffmr spjportfolio_share_diffmr hdportfolio_share_diffmi eduportfolio_share_diffmi wbcountrynameb wbregion wbincomegroup hci_mf_100 lastspc lastspc_mr lastspc_mi lastod lastod_mr lastod_mi lasttfr lasttfr_mr lasttfr_mi lastafr lastafr_mr lastafr_mi contracep contracep_mr contracep_mi wbl wbl_mr wbl_mi hcicountry edugov edugov_mr edugov_mi healthgov healthgov_mi healthgov_mr socprotgov socprotgov_mr socprotgov_mi difhcipred drm drm_mr drm_mi difdrmpred lastcpia_hr lastcpia_hr_mr lastcpia_hr_mi unregpop unregpop_mr unregpop_mi lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj 
*save relevant_variables_3, replace
*restore
	

	
	
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


gen stat_text= "In " + wbcountrynameb + ///
", the latest available data point on stunting rate is from " ///
+ strofreal(round(lasttime_nostu_rep,1)) + ///
". Similarly, the latest available data point on Harmonized Learning Outcomes is from " ///
+ strofreal(round(lasttime_hlo_mf_rep,1)) + "."

replace stat_text="In " + wbcountrynameb + ///
", data on stunting rate and Harmonized Learning Outcomes are unavailable after year 2000." ///
if lasttime_nostu_rep==. & lasttime_hlo_mf_rep==.

  
replace stat_text="In " + wbcountrynameb + ///
", data on stunting rate are unavailable after year 2000." + ///
" The latest available data point on Harmonized Learning Outcomes is from " ///
+ strofreal(round(lasttime_hlo_mf_rep,1)) + "." ///
if lasttime_nostu_rep==. & lasttime_hlo_mf_rep!=.

replace stat_text="In " + wbcountrynameb + ///
", data on Harmonized Learning Outcomes are unavailable after year 2000." + ///
" The latest available data point on stunting rate is from " ///
+ strofreal(round(lasttime_nostu_rep,1)) + "." ///
if lasttime_nostu_rep!=. & lasttime_hlo_mf_rep==.

///////////////////////////////////////////////////////////////////

gen dpohc_text= ///
         cond(dpohc==1,                 /* 
*/ "Currently, the pipeline for " + wbcountrynameb + " includes at least one Development Policy Operation with a Human Capital-related component or prior action.",    /* 
*/       cond(dpohc==0,                         /* 
*/ "Currently, the pipeline for " + wbcountrynameb + " does not include any Development Policy Operation with a Human Capital-related component or prior action.",     /*    
*/ ""))

gen wep_text= ///
         cond(wep==1,                 /* 
*/ "Currently, " + wbcountrynameb + " has at least one active project focused on women empowerment or on sexual and reproductive health.",    /* 
*/       cond(wep==0,                         /* 
*/ "Currently, the pipeline for " + wbcountrynameb + " does not have an active project focused on women empowerment or on sexual and reproductive health.",     /*    
*/ ""))




replace pipeline_hd_share = pipeline_hd_share *100
replace pipeline_edu_share = pipeline_edu_share *100
replace pipeline_hnp_share = pipeline_hnp_share *100
replace pipeline_spj_share = pipeline_spj_share *100

replace pipeline_hd_share_diffmr = pipeline_hd_share_diffmr *100
replace pipeline_edu_share_diffmr = pipeline_edu_share_diffmr *100
replace pipeline_hnp_share_diffmr = pipeline_hnp_share_diffmr *100
replace pipeline_spj_share_diffmr = pipeline_spj_share_diffmr *100

replace pipeline_hd_share_diffmi = pipeline_hd_share_diffmi *100
replace pipeline_edu_share_diffmi = pipeline_edu_share_diffmi *100
replace pipeline_hnp_share_diffmi = pipeline_hnp_share_diffmi *100
replace pipeline_spj_share_diffmi = pipeline_spj_share_diffmi *100

destring percsatisfdo_hd percsatisfdo_edu percsatisfdo_hnp percsatisfdo_spj , replace 
destring percsatisfip_hd percsatisfip_edu percsatisfip_hnp percsatisfip_spj , replace 

replace percsatisfdo_hd = percsatisfdo_hd *100
replace percsatisfdo_edu = percsatisfdo_edu *100
replace percsatisfdo_hnp = percsatisfdo_hnp *100
replace percsatisfdo_spj = percsatisfdo_spj *100

replace percsatisfip_hd = percsatisfip_hd *100
replace percsatisfip_edu = percsatisfip_edu *100
replace percsatisfip_hnp = percsatisfip_hnp *100
replace percsatisfip_spj = percsatisfip_spj *100

replace crossgpshare_hd = crossgpshare_hd *100
replace crossgpshare_edu = crossgpshare_edu *100
replace crossgpshare_hnp = crossgpshare_hnp *100
replace crossgpshare_spj = crossgpshare_spj *100

replace crossgpshare_hd_diffmr = crossgpshare_hd_diffmr *100
replace crossgpshare_edu_diffmr = crossgpshare_edu_diffmr *100
replace crossgpshare_hnp_diffmr = crossgpshare_hnp_diffmr *100
replace crossgpshare_spj_diffmr = crossgpshare_spj_diffmr *100

replace crossgpshare_hd_diffmi = crossgpshare_hd_diffmi *100
replace crossgpshare_edu_diffmi = crossgpshare_edu_diffmi *100
replace crossgpshare_hnp_diffmi = crossgpshare_hnp_diffmi *100
replace crossgpshare_spj_diffmi = crossgpshare_spj_diffmi *100




format %9.0fc hdportfolio eduportfolio hnpportfolio spjportfolio pipeline_hd pipeline_edu pipeline_hnp pipeline_spj avgsize_hd avgsize_edu avgsize_hnp avgsize_spj avgsize_hd_diffmr avgsize_edu_diffmr avgsize_hnp_diffmr avgsize_hd_diffmi avgsize_edu_diffmi avgsize_hnp_diffmi avgsize_spj_diffmi hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share hdportfolio_share_diffmr eduportfolio_share_diffmr hnpportfolio_share_diffmr spjportfolio_share_diffmr hdportfolio_share_diffmi eduportfolio_share_diffmi hnpportfolio_share_diffmi spjportfolio_share_diffmi pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share pipeline_hd_share_diffmi pipeline_edu_share_diffmi pipeline_hnp_share_diffmi pipeline_spj_share_diffmi pipeline_hd_share_diffmr pipeline_edu_share_diffmr pipeline_hnp_share_diffmr pipeline_spj_share_diffmr percsatisfdo_hd percsatisfdo_edu percsatisfdo_hnp percsatisfdo_spj percsatisfip_hd percsatisfip_edu percsatisfip_hnp percsatisfip_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj disburratio_hd_diffmr disburratio_edu_diffmr  disburratio_hnp_diffmr disburratio_spj_diffmr disburratio_hd_diffmi disburratio_edu_diffmi  disburratio_hnp_diffmi disburratio_spj_diffmi crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj crossgpshare_hd_diffmr crossgpshare_edu_diffmr crossgpshare_hnp_diffmr crossgpshare_spj_diffmr crossgpshare_hd_diffmi crossgpshare_edu_diffmi crossgpshare_hnp_diffmi crossgpshare_spj_diffmi
format %9.0fc  avgsize_hd_diffmr avgsize_edu_diffmr avgsize_hnp_diffmr avgsize_spj_diffmr

format %9.2fc do_performance_hd do_performance_edu do_performance_hnp do_performance_spj 
format %9.2fc do_performance_hd_diffmr do_performance_edu_diffmr do_performance_hnp_diffmr do_performance_spj_diffmr
format %9.2fc do_performance_hd_diffmi do_performance_edu_diffmi do_performance_hnp_diffmi do_performance_spj_diffmi

format %9.2fc ip_performance_hd ip_performance_edu ip_performance_hnp ip_performance_spj 
format %9.2fc ip_performance_hd_diffmr ip_performance_edu_diffmr ip_performance_hnp_diffmr ip_performance_spj_diffmr
format %9.2fc ip_performance_hd_diffmi ip_performance_edu_diffmi ip_performance_hnp_diffmi ip_performance_spj_diffmi

format %9.2fc do_performance_hd_diffmr do_performance_edu_diffmr do_performance_hnp_diffmr do_performance_spj_diffmr
format %9.2fc ip_performance_hd_diffmr ip_performance_edu_diffmr ip_performance_hnp_diffmr ip_performance_spj_diffmr


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
format %9.1fc edugov
format %9.1fc edugov_mr
format %9.1fc edugov_mi
format %9.1fc healthgov
format %9.1fc healthgov_mr
format %9.1fc healthgov_mi
format %9.1fc socprotgov
format %9.1fc socprotgov_mr
format %9.1fc socprotgov_mi
format %9.1fc drm
format %9.1fc drm_mr
format %9.1fc drm_mi
format %9.1fc lastcpia_hr
format %9.1fc lastcpia_hr_mr
format %9.1fc lastcpia_hr_mi
format %9.0fc unregpop_share
format %9.0fc unregpop_share_mr
format %9.0fc unregpop_share_mi



saveold "input/textforscorecard.dta", replace


/////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////END/////////////////////////////







