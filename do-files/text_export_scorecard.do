
/*
OBJECTIVE: GENERATE TEXT FOR HCI SCORECARD
AUTHOR: MARTIN DE SIMONE AND ZELALEM YILMA DEBEBE
DATE: AUGUST 07 2019

*/

clear all
set more off	
set maxvar 32000

*set up directory and filepath to database 

local outputfilepath "C:\Users\WB469563\OneDrive - WBG\Documents (zdebebe@worldbank.org)\OneDrive - WBG\Documents (zdebebe@worldbank.org)\Human Capital Project\HCP Africa\Scorecard"
global charts "C:\Users\WB469563\OneDrive - WBG\Documents (zdebebe@worldbank.org)\OneDrive - WBG\Documents (zdebebe@worldbank.org)\Human Capital Project\HCP Africa\Scorecard\charts"

use scorecardanalysis_2019-08-13.dta, clear
graph set window fontface "Baskerville Old Face"

//Preliminaries 

gen wbcountrynameb=""
replace wbcountrynameb="the Comoros" if wbcountryname=="Comoros"
replace wbcountrynameb="the Democratic Republic of Congo" if wbcountryname=="Democratic Republic of Congo"
replace wbcountryname="The Democratic Republic of Congo" if wbcountryname=="Democratic Republic of Congo"
replace wbcountrynameb="the Republic of Congo" if wbcountryname=="Republic of Congo"
replace wbcountryname="The Republic of Congo" if wbcountryname=="Republic of Congo"
replace wbcountrynameb="the Arab Republic of Egypt" if wbcountryname=="Arab Republic of Egypt"
replace wbcountryname="The Arab Republic of Egypt" if wbcountryname=="Arab Republic of Egypt"
replace wbcountrynameb="the Gambia" if wbcode=="GMB"
replace wbcountryname="The Gambia" if wbcode=="GMB"
replace wbcountrynameb="the Islamic Republic of Iran" if wbcountryname=="Islamic Republic of Iran"
replace wbcountryname=" The Islamic Republic of Iran" if wbcountryname=="Islamic Republic of Iran"
replace wbcountrynameb="the Republic of Korea" if wbcountryname=="Republic of Korea"
replace wbcountryname="The Republic of Korea" if wbcountryname=="Republic of Korea"
replace wbcountrynameb="the Kyrgyz Republic" if wbcountryname=="the Kyrgyz Republic"
replace wbcountryname="The Kyrgyz Republic" if wbcountryname=="the Kyrgyz Republic"
replace wbcountrynameb="Macedonia" if wbcountryname=="Macedonia, FYR"
replace wbcountryname="The Former Yugoslav Republic (FYR) of Macedonia" if wbcountryname=="Macedonia, FYR"
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


replace wbcountrynameb="the Central African Republic" if wbcountryname=="Central African Republic"
replace wbcountryname="The Central African Republic" if wbcountryname=="Central African Republic"
replace wbcountrynameb="the Democratic People's Republic of Korea" if wbcountryname=="Democratic People's Republic of Korea"
replace wbcountryname="The Democratic People's Republic of Korea" if wbcountryname=="Democratic People's Republic of Korea"
replace wbcountrynameb="the Federated States of Micronesia" if wbcountryname=="Federated States of Micronesia"
replace wbcountryname="The Federated States of Micronesia" if wbcountryname=="Federated States of Micronesia"
replace wbcountrynameb="Hong Kong" if wbcountryname=="Hong Kong SAR, China"
replace wbcountryname="Hong Kong" if wbcountryname=="Hong Kong SAR, China"
replace wbcountrynameb="the Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountryname="The Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountrynameb="the Lao People's Democratic Republic" if wbcountryname=="Lao PDR"
replace wbcountryname="The Lao People's Democratic Republic" if wbcountryname=="Lao PDR"
replace wbcountrynameb="Macao" if wbcountryname=="Macao SAR, China"
replace wbcountryname="Macao" if wbcountryname=="Macao SAR, China"
replace wbcountrynameb="the Marshall Islands" if wbcountryname=="Marshall Islands"
replace wbcountryname="The Marshall Islands" if wbcountryname=="Marshall Islands"
replace wbcountrynameb="the Northern Mariana Islands" if wbcountryname=="Northern Mariana Islands"
replace wbcountryname="The Northern Mariana Islands" if wbcountryname=="Northern Mariana Islands"
replace wbcountrynameb="the Syrian Arab Republic" if wbcountryname=="Syrian Arab Republic"
replace wbcountryname="The Syrian Arab Republic" if wbcountryname=="Syrian Arab Republic"
replace wbcountrynameb="Venezuela" if wbcountryname=="Venezuela, RB"
replace wbcountryname="Venezuela" if wbcountryname=="Venezuela, RB"
replace wbcountrynameb="the Virgin Islands" if wbcountryname=="Virgin Islands (U.S.)"
replace wbcountryname="The Virgin Islands" if wbcountryname=="Virgin Islands (U.S.)"
replace wbcountrynameb=wbcountryname if wbcountrynameb==""

foreach var of varlist lastner_sec_f drm lastcpia_hr unregpop lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj{
     egen `var'_sdr=sd(`var') if year==2017, by(region)
	 egen `var'_sdi=sd(`var') if year==2017, by(income)
	 }


gen hci_mf_100= hci_mf*100


foreach gender in mf {
foreach var of varlist lastner_sec_f hci_`gender' tnep_`gender' nostu_`gender' asr_`gender' psurv_`gender' test_`gender' eyrs_`gender' lastod lastodcomp lasttfr lastafr contracep wbl unregpop_share unregpopcomp lastspc ner drm lastcpia_hr unregpop lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj{
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
	




****Keep only variables that are relevant for analysis***	
*preserve
*keep wbcode lastner_sec_f lastner_sec_f_mr lastner_sec_f_mi lastner_sec_f_sdr lastner_sec_f_sdm percsatisfip_hd percsatisfip_edu percsatisfip_hnp percsatisfip_spj percsatisfdo_hd percsatisfdo_edu percsatisfdo_hnp percsatisfdo_spj avgsize_hd avgsize_edu avgsize_hnp avgsize_spj hdportfolio eduportfolio hnpportfolio spjportfolio pipeline_hd pipeline_edu pipeline_hnp pipeline_spj terc_disburratio_spj terc_avgsize_hd terc_avgsize_edu terc_avgsize_hnp terc_avgsize_spj terc_crossgpshare_hd terc_crossgpshare_edu terc_crossgpshare_hnp terc_crossgpshare_spj terc_ip_performance_hd terc_ip_performance_edu terc_ip_performance_hnp terc_ip_performance_spj terc_disburratio_hd terc_disburratio_edu terc_disburratio_hnp terc_pipeline_hnp_share terc_pipeline_spj_share terc_do_performance_hd terc_do_performance_edu terc_do_performance_hnp terc_do_performance_spj terc_hdportfolio_share 	terc_eduportfolio_share terc_hnpportfolio_share terc_spjportfolio_share terc_pipeline_hd_share terc_pipeline_edu_share  hdportfolio_share_sdr hdportfolio_share_sdi eduportfolio_share_sdr eduportfolio_share_sdi hnpportfolio_share_sdr hnpportfolio_share_sdi spjportfolio_share_sdr spjportfolio_share_sdi pipeline_hd_share_sdr pipeline_hd_share_sdi pipeline_edu_share_sdr pipeline_edu_share_sdi pipeline_hnp_share_sdr pipeline_hnp_share_sdi pipeline_spj_share_sdr pipeline_spj_share_sdi do_performance_hd_sdr do_performance_hd_sdi do_performance_edu_sdr do_performance_edu_sdi do_performance_hnp_sdr do_performance_hnp_sdi do_performance_spj_sdr do_performance_spj_sdi ip_performance_hd_sdr ip_performance_hd_sdi ip_performance_edu_sdr ip_performance_edu_sdi ip_performance_hnp_sdr ip_performance_hnp_sdi ip_performance_spj_sdr ip_performance_spj_sdi disburratio_hd_sdr disburratio_hd_sdi disburratio_edu_sdr disburratio_edu_sdi disburratio_hnp_sdr disburratio_hnp_sdi disburratio_spj_sdr disburratio_spj_sdi avgsize_hd_sdr avgsize_hd_sdi avgsize_edu_sdr avgsize_edu_sdi avgsize_hnp_sdr avgsize_hnp_sdi avgsize_spj_sdi crossgpshare_hd_sdr crossgpshare_hd_sdi crossgpshare_edu_sdr crossgpshare_edu_sdi crossgpshare_hnp_sdr crossgpshare_hnp_sdi crossgpshare_spj_sdr crossgpshare_spj_sdi crossgpshare_spj_diffmi crossgpshare_hnp_diffmi crossgpshare_edu_diffmi crossgpshare_hd_diffmi crossgpshare_spj_diffmr crossgpshare_hnp_diffmr crossgpshare_edu_diffmr crossgpshare_hd_diffmr  avgsize_spj_diffmi avgsize_hnp_diffmi avgsize_edu_diffmi avgsize_hd_diffmi avgsize_spj_diffmr  avgsize_hnp_diffmr  avgsize_edu_diffmi  avgsize_hd_diffmi avgsize_spj_diffmr avgsize_hnp_diffmr  avgsize_edu_diffmr  avgsize_hd_diffmr  disburratio_hd_diffmi disburratio_edu_diffmi disburratio_hnp_diffmi disburratio_spj_diffmi disburratio_hd_diffmr disburratio_edu_diffmr disburratio_hnp_diffmr disburratio_spj_diffmr ip_performance_spj_diffmi ip_performance_hnp_diffmi ip_performance_edu_diffmi ip_performance_hd_diffmi  ip_performance_spj_diffmr ip_performance_hnp_diffmr  ip_performance_edu_diffmr  ip_performance_hd_diffmr do_performance_spj_diffmi do_performance_hnp_diffmi do_performance_edu_diffmi do_performance_hd_diffmi do_performance_spj_diffmr do_performance_hnp_diffmr do_performance_edu_diffmr do_performance_hd_diffmr pipeline_spj_share_diffmi  pipeline_hnp_share_diffmi  pipeline_edu_share_diffmi pipeline_hd_share_diffmi pipeline_spj_share_diffmr pipeline_hnp_share_diffmr  pipeline_edu_share_diffmr  pipeline_hd_share_diffmr  spjportfolio_share_diffmi hnpportfolio_share_diffmi hdportfolio_share_diffmr  eduportfolio_share_diffmr hnpportfolio_share_diffmr spjportfolio_share_diffmr hdportfolio_share_diffmi eduportfolio_share_diffmi wbcountrynameb wbregion wbincomegroup hci_mf_100 lastspc lastspc_mr lastspc_mi lastod lastod_mr lastod_mi lasttfr lasttfr_mr lasttfr_mi lastafr lastafr_mr lastafr_mi contracep contracep_mr contracep_mi wbl wbl_mr wbl_mi hcicountry edugov edugov_mr edugov_mi healthgov healthgov_mi healthgov_mr socprotgov socprotgov_mr socprotgov_mi difhcipred drm drm_mr drm_mi difdrmpred lastcpia_hr lastcpia_hr_mr lastcpia_hr_mi unregpop unregpop_mr unregpop_mi lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj 
*save relevant_variables_3, replace
*restore
	
	
gen intro_text  = "This note presents a snapshot of the country's commitment on the human capital agenda and the main actions being taken by the World Bank Group to support the government."

gen hci_text = ///
  cond(hci_mf_100 != ., "In " + wbcountrynameb + " the productivity as a future worker" ///
  + " of a child born today is **" + strofreal(round(hci_mf_100,1)) + " percent**" ///
  + " as much as it could be. The HCI has three components: survival to age 5, health, and education." ///
  + " For more information on human capital outcomes and the HCI, please see the country two-pager on \boldblue{www.worldbank.org/humancapitalproject}",   ///
     "In " + wbcountrynameb + " there are no enough data to calculate the productivity as a future worker of a child born today." ///
	 + " The HCI has three components: survival to age 5, health, and education. For more information on human capital outcomes and the HCI, please see" ///
	 + " the country two-pager on \boldblue{www.worldbank.org/humancapitalproject}")
	 
	 
gen lastspc_text = ///
	cond(lastspc< lastspc_mr & lastspc<lastspc_mi, "In " + wbcountrynameb + "**" + strofreal(round(lastspc,1)) + " percent** of the population is covered by" ///
	+ " social safety net programs. This is lower than both the average for its region (" + strofreal(round(lastspc_mr,1)) + ") and the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
		cond(lastspc> lastspc_mr & lastspc>lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the population is covered by" ///
		+ " social safety net programs. This is higher than both the average for its region (" + strofreal(round(lastspc_mr,1)) + ") and the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
	   	cond(lastspc< lastspc_mr & lastspc>lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the population is covered by" ///
		+ " social safety net programs. This is lower than the average for its region (" + strofreal(round(lastspc_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
		cond(lastspc< lastspc_mr & lastspc>lastspc_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastspc,1))  + " percent** of the population is covered by" ///
		+ " social safety net programs. This is higher than the average for its region (" + strofreal(round(lastspc_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastspc_mi,1)) + ").", ///
			"In " + wbcountrynameb + ",data on the percentage of the population that is covered by social safety nets do not exist. The average for the country's region is " + strofreal(round(lastspc_mr,1)) + " percent and for its income group is " + strofreal(round(lastspc_mr,1)) + " percent." )))) 
		

gen lastod_text = ///
	cond(lastod< lastod_mr & lastod<lastod_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastod,1)) + " percent** of the population practices" ///
	+ " open defecation. This is lower than both the average for its region (" + strofreal(round(lastod_mr,1)) + ") and the average for its income group (" + strofreal(round(lastod_mi,1)) + ".", ///
		cond(lastod> lastod_mr & lastod>lastod_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is higher than both the average for its region (" + strofreal(round(lastod_mr,1)) + ") and the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
	   	cond(lastod< lastod_mr & lastod>lastod_mi,"In" + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is lower than the average for its region (" + strofreal(round(lastod_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
		cond(lastod< lastod_mr & lastod>lastod_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastod,1))  + " percent** of the population practices" ///
		+ " open defecation. This is higher than the average for its region (" + strofreal(round(lastod_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastod_mi,1)) + ").", ///
			"In " + wbcountrynameb + ", data on the percentage of the population that practices open defecation do not exist. The average for the country's region is " + strofreal(round(lastod_mr,1)) + " percent and for its income group is " + strofreal(round(lastod_mr,1)) + " percent." )))) 
	
		   
gen lasttfr_text = ///
	cond(lasttfr< lasttfr_mr & lasttfr<lasttfr_mi, "In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,1.00)) + "**." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lasttfr_mr,1)) + ") and the average for its income group (" + strofreal(round(lasttfr_mi,1)) + ").", ///
		cond(lasttfr> lasttfr_mr & lasttfr>lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,1.00)) + "**." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lasttfr_mr,1)) + ") and the average for its income group (" + strofreal(round(lasttfr_mi,1)) + ").", ///
	   	cond(lasttfr< lasttfr_mr & lasttfr>lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,1.00)) + "**." ///
		+ " This is lower than the average for its region (" + strofreal(round(lasttfr_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lasttfr_mi,1)) + ").", ///
		cond(lasttfr< lasttfr_mr & lasttfr>lasttfr_mi,"In " + wbcountrynameb + ", the total fertility rate is **" + strofreal(round(lasttfr,1.00)) + "**." ///
		+ " This is higher than the average for its region (" + strofreal(round(lasttfr_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lasttfr_mi,1)) + ").", ///
			"In " + wbcountrynameb + ", data on the total fertility rate do not exist. The average for the country's region is " + strofreal(round(lasttfr_mr,1)) + " births per woman and for its income group is " + strofreal(round(lasttfr_mr,1)) + " births per woman." )))) 
			

gen lastafr_text = ///
	cond(lastafr< lastafr_mr & lastafr<lastafr_mi, "In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lastafr_mr,1)) + ")and the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
		cond(lastafr> lastafr_mr & lastafr>lastafr_mi,"In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lastafr_mr,1)) + ") and the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
	   	cond(lastafr< lastafr_mr & lastafr>lastafr_mi,"In " + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is lower than the average for its region (" + strofreal(round(lastafr_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastafr_mi,1)) + ").", ///
		cond(lastafr< lastafr_mr & lastafr>lastafr_mi,"In" + wbcountrynameb + ", there are **" + strofreal(round(lastafr,1)) + " births** per 1,000 women ages 15-19." ///
		+ " This is higher than the average for its region" + strofreal(round(lastafr_mr,1)) + "but lower than the average for its income group " + strofreal(round(lastafr_mi,1)) + ".", ///
			"In " + wbcountrynameb + ", data on the adolescent fertility rate do not exist. The average for the country's region is " + strofreal(round(lastafr_mr,1)) + " births per 1,000 women ages 15-19 and for its income group is " + strofreal(round(lastafr_mr,1)) + "." )))) 


gen contracep_text = ///
	cond(contracep< contracep_mr & contracep<contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
	+ "method. This is lower than both the average for its region (" + strofreal(round(contracep_mr,1)) + ") and the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
		cond(contracep> contracep_mr & contracep>contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is higher than both the average for its region (" + strofreal(round(contracep_mr,1)) + ") and the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
	   	cond(contracep< contracep_mr & contracep>contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is lower than the average for its region (" + strofreal(round(contracep_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
		cond(contracep< contracep_mr & contracep>contracep_mi, "In " + wbcountrynameb + ", **" + strofreal(round(contracep,1)) + " percent** of women ages 15-49 uses some form of contraceptive " ///
		+ "method. This is higher than the average for its region (" + strofreal(round(contracep_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(contracep_mi,1)) + ").", ///
			"In " + wbcountrynameb + ", data on contraceptive methods do not exist. In the country's region, **" + strofreal(round(contracep_mr,1)) + " percent** of women ages 15-49 uses some form of contraceptive method, and in the country's income group, **" + strofreal(round(contracep_mr,1)) + " percent uses it." )))) 

			
			
gen wbl_text = ///
	cond(wbl< wbl_mr & wbl<wbl_mi, "This index measures gender inequality in the law and identifies barriers to women's economic participation, and a larger value shows higher gender equity." ///
	+ "In " + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is lower than both the average for its region (" + strofreal(round(wbl_mr,1)) + ") and the average" ///
	+ " for its income group (" + strofreal(round(wbl_mi,1)) + ").", /// 
		cond(wbl> wbl_mr & wbl>wbl_mi,  "This index measures gender inequality in the law and identifies barriers to women's economic participation, and a larger value shows higher gender equity." ///
		+ "In " + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is higher than both the average for its region (" + strofreal(round(wbl_mr,1)) + ") and the average for its income group (" + strofreal(round(wbl_mi,1)) + ").", ///
		cond(wbl< wbl_mr & wbl>wbl_mi, "This index measures gender inequality in the law and identifies barriers to women's economic participation, and a larger value shows higher gender equity." /// 
		+ "In " + wbcountrynameb +  ", the value is **"  + strofreal(round(wbl,1)) + "** out of 100. This is lower than the average for its region (" + strofreal(round(wbl_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(wbl_mi,1)) + ").", ///
		cond(wbl< wbl_mr & wbl>wbl_mi, "This index measures gender inequality in the law and identifies barriers to women's economic participation, and a larger value shows higher gender equity." /// 
		+ "In" + wbcountrynameb + ", the value is **" + strofreal(round(wbl,1)) + "** out of 100. This is higher than the average for its region" + strofreal(round(wbl_mr,1)) + "but lower than the average for its income group " + strofreal(round(wbl_mi,1)) + ".", ///
			"In " + wbcountrynameb + ", data on the women, business and the law index do not exist. The average for the country's region is " + strofreal(round(wbl_mr,1)) + "and the average for its income group is " + strofreal(round(wbl_mr,1)) + "." )))) 

			
			

gen lastner_sec_f_text = ///
	cond(lastner_sec_f< lastner_sec_f_mr & lastner_sec_f<lastner_sec_f_mi, "In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of women of secondary-school age are enroled in school." ///
	+ " This is lower than both the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") and the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
		cond(lastner_sec_f> lastner_sec_f_mr & lastner_sec_f>lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of women of secondary-school age are enroled in school." ///
		+ " This is higher than both the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") and the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
	   	cond(lastner_sec_f< lastner_sec_f_mr & lastner_sec_f>lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of women of secondary-school age are enroled in school." ///
		+ " This is lower than the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") but higher than the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
		cond(lastner_sec_f< lastner_sec_f_mr & lastner_sec_f>lastner_sec_f_mi,"In " + wbcountrynameb + ", **" + strofreal(round(lastner_sec_f,1)) + " percent** of women of secondary-school age are enroled in school." ///
		+ " This is higher than the average for its region (" + strofreal(round(lastner_sec_f_mr,1)) + ") but lower than the average for its income group (" + strofreal(round(lastner_sec_f_mi,1)) + ").", ///
			"In " + wbcountrynameb + ", data on net enrolment rates in secondary school for women do not exist. The average for the country's region is **" + strofreal(round(lastner_sec_f_mr,1)) + "** percent of women of secondary-school age enroled in school, and the average for the country's income group is **"  + strofreal(round(lastner_sec_f_mr,1)) + "**percent." )))) 
			

////////////////////////////////////
gen hci_mem = ///
  cond(hcicountry == 1, "is",   ///
  cond(hcicountry  ==0, "is not",           ///
           ""))
gen hci_memt="" + wbcountrynameb + " " + hci_mem + " part of a network of countries committed to the Human Capital agenda." 
/////////////////////////////////////
gen edu_comp_mrmi = ///
         cond(edugov< edugov_mr & edugov<edugov_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(edugov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(edugov_mi,0.1)) + ").",    /* 
*/       cond( edugov> edugov_mr & edugov>edugov_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(edugov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(edugov_mi,0.1)) + ").",     /* 
*/       cond( edugov< edugov_mr & edugov>edugov_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(edugov_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(edugov_mi,0.1)) + ").", /* 
*/       cond(edugov> edugov_mr & edugov<edugov_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(edugov_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(edugov_mi,0.1)) + ").", /*        
*/ "")))) if edugov!=.

gen edu_text="" + wbcountryname + /// we still need to specify for missing data cases
" spends **" + strofreal(round(edugov,0.1)) + ///
" percent** of its government budget on education. "  /// 
+ edu_comp_mrmi + ""

replace edu_text="In " + wbcountrynameb + ///
", data on education spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(edugov_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(edugov_mi,0.1)) + " percent." if edugov==.


////////////////////////////////////////

gen health_comp_mrmi = ///
         cond(healthgov< healthgov_mr & healthgov<healthgov_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(healthgov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(healthgov_mi,0.1)) + ").",    /* 
*/       cond( healthgov> healthgov_mr & healthgov>healthgov_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(healthgov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(healthgov_mi,0.1)) + ").",     /* 
*/       cond( healthgov< healthgov_mr & healthgov>healthgov_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(healthgov_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(healthgov_mi,0.1)) + ").", /* 
*/       cond(healthgov> healthgov_mr & healthgov<healthgov_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(healthgov_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(healthgov_mi,0.1)) + ").", /*        
*/ "")))) if healthgov!=.

gen health_text="" + wbcountryname + ///
" spends **" + strofreal(round(healthgov,0.1)) + ///
" percent** of its government budget on health. "  ///
+ health_comp_mrmi + ""

replace health_text="In " + wbcountrynameb + ///
", data on health spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(healthgov_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(healthgov_mi,0.1)) + " percent." if healthgov==.


//////////////////////////////////////////

gen socprot_comp_mrmi = ///
         cond(socprotgov< socprotgov_mr & socprotgov<socprotgov_mi,                 /* 
*/ " This is lower than both the regional average (" + strofreal(round(socprotgov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(socprotgov_mi,0.1)) + ").",    /* 
*/       cond( socprotgov> socprotgov_mr & socprotgov>socprotgov_mi,                         /* 
*/ "This is higher than both the regional average (" + strofreal(round(socprotgov_mr,0.1)) + ") and the average for its income group (" + strofreal(round(socprotgov_mi,0.1)) + ").",     /* 
*/       cond( socprotgov< socprotgov_mr & socprotgov>socprotgov_mi,                         /* 
*/ "This is lower than  the average for its region (" + strofreal(round(socprotgov_mr,0.1)) + ") but higher than the average for its income group (" + strofreal(round(socprotgov_mi,0.1)) + ").", /* 
*/       cond(socprotgov> socprotgov_mr & socprotgov<socprotgov_mi,                         /* 
*/ "This is higher than  the average for its region (" + strofreal(round(socprotgov_mr,0.1)) + ") but lower than the average for its income group (" + strofreal(round(socprotgov_mi,0.1)) + ").", /*        
*/ "")))) if socprotgov!=.

gen socprot_text="" + wbcountryname + ///
" spends **" + strofreal(round(socprotgov,0.1)) + ///
" percent** of its government budget on social protection. "  ///
+ socprot_comp_mrmi + ""

replace socprot_text="In " + wbcountrynameb + ///
", data on social protection spending do not exist." + ///
" The average for the country's region is "  + strofreal(round(socprotgov_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(socprotgov_mi,0.1)) + " percent." if socprotgov==.


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
" is **" + effic + "** than what would be predicted for its level of per capita spending on the social sectors." if health_ed_sp_pc!=. & hci_mf!=.

replace eff_text = " The HCI in " + wbcountrynameb + ///
" is **" + effic + "** than what would be predicted for its level of per capita spending on health and education." if health_ed_sp_pc==. & hci_mf!=. & health_ed_pc!=.

replace eff_text="Given the lack of data, it is not possible to predict if the HCI in " + wbcountrynameb + ///
" is higher or lower than what would be predicted for its level of per capita spending."  if (difhcipred==. | difhcipred1==. | hci_mf==.)

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
" percent** of the population does not have proof of identity."  ///
+ ident_comp + ""

replace ident_text="In " + wbcountrynameb + ///
", data on the percentage of the population that does not have proof of identity do not exist." + ///
" The average for the country's region is "  + strofreal(round(unregpop_share_mr,0.1)) + ///
" percent and for its income group is " + strofreal(round(unregpop_share_mi,0.1)) + " percent." if unregpop_share==.

////////////////////////////////////////


gen stat_text= "In " + wbcountrynameb + ///
", the latest available data on stunting rates is from " ///
+ strofreal(round(lasttime_nostu_rep,1)) + ///
". Similarly, the last available data point on Harmonized Learning Outcomes is from " ///
+ strofreal(round(lasttime_hlo_mf_rep,1)) + "."

replace stat_text="In " + wbcountrynameb + ///
", data on stunting rate and Harmonized Learning Outcomes are unavailable after year 2000." ///
if lasttime_nostu_rep==. & lasttime_hlo_mf_rep==.

  
replace stat_text="In " + wbcountrynameb + ///
", data on stunting rate are unavailable after year 2000." + ///
" The last available data point on Harmonized Learning Outcomes is from " ///
+ strofreal(round(lasttime_hlo_mf_rep,1)) + "." ///
if lasttime_nostu_rep==. & lasttime_hlo_mf_rep!=.

replace stat_text="In " + wbcountrynameb + ///
", data on Harmonized Learning Outcomes are unavailable after year 2000." + ///
" The last available data point on stunting rate is from " ///
+ strofreal(round(lasttime_nostu_rep,1)) + "." ///
if lasttime_nostu_rep!=. & lasttime_hlo_mf_rep==.


save "C:\Users\WB538904\OneDrive - WBG\CHI_AM19_scorecard\input\textforscorecard.dta", replace
/////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////END/////////////////////////////







