
//OBJECTIVE: GENERATE GRAPHS FOR SCORECARD
//AUTHORS: MARTIN and ZELALEM 
// Project: HCP 2019



clear all
set more off



if ( lower("`c(username)'") == "wb####") {   // provide user profile (UPI in WB computers)
	global root ""
}
else {
	global root ""
}


global charts "${root}/charts"
local outputfilepath "${root}/input"
cd "${root}"

local date: disp %tdCY-m-D date("`c(current_date)'", "DMY")
disp "`date'"



use "input/scorecardanalysis_2019-10-03.dta", clear 
graph set window fontface "Fourier"


//use scorecardanalysis_2019-10-03.dta, clear
//graph set window fontface "Baskerville Old Face"
set scheme plotplainblind, permanently


//Preliminaries 

foreach var of varlist lastner_sec_f drm lastcpia_hr unregpop lasttime_nostu_rep ///
lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share ///
spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share ///
pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp ///
do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ///
ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj ///
avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj {
	egen `var'_sdr=sd(`var') if year==2017, by(region)
	egen `var'_sdi=sd(`var') if year==2017, by(income)
}


gen hci_mf_100= hci_mf*100


foreach gender in mf {
	foreach var of varlist lastner_sec_f hci_`gender' tnep_`gender' nostu_`gender' ///
	asr_`gender' psurv_`gender' test_`gender' eyrs_`gender' lastod lastodcomp ///
	lasttfr lastafr contracep wbl unregpop_share unregpopcomp lastspc ner drm ///
	lastcpia_hr unregpop lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep ///
	hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share ///
	pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share ///
	do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ///
	ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj ///
	disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd ///
	avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj ///
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

gen af_hci_mf_targ =0.45 //for graph line 	
//gen hci_mf_100 = hci_mf*100
gen af_hci_targ = 45 //for text 
gen af_od_targ = 15
gen af_od_targ_comp=85 //target for the complement of OD rate
gen af_lastspc_targ = 30
gen af_lastafr_targ = 83
gen dif_hci_targ = hci_mf_100 - af_hci_targ
gen dif_od_targ = lastod - af_od_targ
gen dif_lastspc_targ = lastspc - af_lastspc_targ
gen dif_lastafr_targ = lastafr - af_lastafr_targ
////////////////////////////////////////////////////////////////////////////////////////////////////////		






// set trace on	

/* Old option

 
local x=_N
forvalues i=1/`x' {
}

*/


/* 
count
numlist "1/`r(N)'"
local obs = "`r(numlist)'"
local obs = 90

foreach i of local obs {
		if (wbregion[`i'] == "Sub-Saharan Africa") continue 
	disp "`i'-" _c
}
*/

//CODES FOR GRAPHS

//Figure 1.			

//////////////////////////////////////////////////////////////////////
count
numlist "1/`r(N)'"
local obs = "`r(numlist)'"
local obs = 42 //use this to only run for one country

foreach i of local obs {
	if (wbregion[`i'] == "fakeregion") continue 
	
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	local country=wbcountryname in `i'
	
	local date "05-28-2019"
	
	foreach gender in mf {  //at this point only male+female (at later stage we can add m and f 
		
		
		
		
		
		_pctile hci_`gender' if year==2017, p(33 66)
		twoway (scatter onesvec hci_`gender' if year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Human Capital Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save hci_`gender'_`ctry', replace 
		
		_pctile lastodcomp if year==2017, p(33 66)
		twoway (scatter onesvec lastodcomp if year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Percentage that does not Practice Open Defecation}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastodcomp_`ctry', replace
		
		_pctile lasttfr if year==2017, p(33 66)
		twoway (scatter onesvec lasttfr if year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(sky)) /// 
		(scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(gs10)) /// 							 
		(scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msymbol(Oh) msize(large)  mcolor(sea)) ///							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(sky)) ///							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(gs10)) /// 							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msize(huge) msymbol(solid) mlc(black) mfcolor(sea)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Total Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lasttfr_`ctry', replace
		
		_pctile lastafr if year==2017, p(33 66)
		twoway (scatter onesvec lastafr if year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(sky)) /// 
		(scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(gs10)) /// 							 
		(scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msymbol(Oh) msize(large)  mcolor(sea)) ///							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(sky)) ///							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(gs10)) /// 							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msize(huge) msymbol(solid) mlc(black) mfcolor(sea)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Adolescent Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastafr_`ctry', replace
		
		_pctile contracep if year==2017, p(33 66)
		twoway (scatter onesvec contracep if year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Contraceptive Prevalence (Any Methods)}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save contracep_`ctry', replace
		
		_pctile wbl if year==2017, p(33 66)
		twoway (scatter onesvec wbl if year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Women, Business, and the Law Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save wbl_`ctry', replace
		
		_pctile unregpopcomp if year==2017, p(33 66)
		twoway (scatter onesvec unregpopcomp if year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Percentage of Population Registered}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save unregpopcomp_`ctry', replace
		
		_pctile ner if year==2017, p(33 66)
		twoway (scatter onesvec ner if year==2017 & ner>0 & ner<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec ner if year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec ner if year==2017 & ner>`=scalar(r(r2))' & ner<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>0 & ner<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>`=scalar(r(r2))' & ner<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Net Enrollment Rate, Lower Secondary}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save ner_`ctry', replace
		
		_pctile lastspc if year==2017, p(33 66)
		twoway (scatter onesvec lastspc if year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Social Protection Coverage of the Poorest Quintile}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastspc_`ctry', replace
		
		_pctile lastner_sec_f if year==2017, p(33 66)
		twoway (scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Female Net Enrollment Rate for Secondary School}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastner_sec_f_`ctry', replace
		
		
		
		_pctile lastnm_sanit_basic_plus if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_sanit_basic_plus if year==2017 & lastnm_sanit_basic_plus>0 & lastnm_sanit_basic_plus<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastnm_sanit_basic_plus if year==2017 & lastnm_sanit_basic_plus>`=scalar(r(r1))' & lastnm_sanit_basic_plus<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_sanit_basic_plus if year==2017 & lastnm_sanit_basic_plus>`=scalar(r(r2))' & lastnm_sanit_basic_plus<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastnm_sanit_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_sanit_basic_plus>0 & lastnm_sanit_basic_plus<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastnm_sanit_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_sanit_basic_plus>`=scalar(r(r1))' & lastnm_sanit_basic_plus<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_sanit_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_sanit_basic_plus>`=scalar(r(r2))' & lastnm_sanit_basic_plus<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf: Percent Using at Least Basic Sanitation Services }", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_sanit_basic_plus_`ctry', replace
		
		
	
		_pctile lastnm_hygiene_basic if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_hygiene_basic if year==2017 & lastnm_hygiene_basic>0 & lastnm_hygiene_basic<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastnm_hygiene_basic if year==2017 & lastnm_hygiene_basic>`=scalar(r(r1))' & lastnm_hygiene_basic<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_hygiene_basic if year==2017 & lastnm_hygiene_basic>`=scalar(r(r2))' & lastnm_hygiene_basic<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastnm_hygiene_basic if wbcode=="`ctry'" & year==2017 & lastnm_hygiene_basic>0 & lastnm_hygiene_basic<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastnm_hygiene_basic if wbcode=="`ctry'" & year==2017 & lastnm_hygiene_basic>`=scalar(r(r1))' & lastnm_hygiene_basic<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_hygiene_basic if wbcode=="`ctry'" & year==2017 & lastnm_hygiene_basic>`=scalar(r(r2))' & lastnm_hygiene_basic<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf: Percent with Basic Handwashing Facilities }", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_hygiene_basic_`ctry', replace
		
		
		
		_pctile lastnm_water_basic_plus if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_water_basic_plus if year==2017 & lastnm_water_basic_plus>0 & lastnm_water_basic_plus<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastnm_water_basic_plus if year==2017 & lastnm_water_basic_plus>`=scalar(r(r1))' & lastnm_water_basic_plus<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_water_basic_plus if year==2017 & lastnm_water_basic_plus>`=scalar(r(r2))' & lastnm_water_basic_plus<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastnm_water_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_water_basic_plus>0 & lastnm_water_basic_plus<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastnm_water_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_water_basic_plus>`=scalar(r(r1))' & lastnm_water_basic_plus<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_water_basic_plus if wbcode=="`ctry'" & year==2017 & lastnm_water_basic_plus>`=scalar(r(r2))' & lastnm_water_basic_plus<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Percent Using at Least Basic Drinking Water Services}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_water_basic_plus_`ctry', replace
		
	  
		
		_pctile lastnm_clean_fuel  if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_clean_fuel  if year==2017 & lastnm_clean_fuel >0 & lastnm_clean_fuel <=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastnm_clean_fuel  if year==2017 & lastnm_clean_fuel >`=scalar(r(r1))' & lastnm_clean_fuel <=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_clean_fuel  if year==2017 & lastnm_clean_fuel >`=scalar(r(r2))' & lastnm_clean_fuel <=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastnm_clean_fuel  if wbcode=="`ctry'" & year==2017 & lastnm_clean_fuel >0 & lastnm_clean_fuel <=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastnm_clean_fuel  if wbcode=="`ctry'" & year==2017 & lastnm_clean_fuel >`=scalar(r(r1))' & lastnm_clean_fuel <=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_clean_fuel  if wbcode=="`ctry'" & year==2017 & lastnm_clean_fuel >`=scalar(r(r2))' & lastnm_clean_fuel <=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf: Percent Using Clean Cooking Fuel}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_clean_fuel_`ctry', replace
		
		
		_pctile lastnm_electric if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_electric if year==2017 & lastnm_electric>0 & lastnm_electric<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastnm_electric if year==2017 & lastnm_electric>`=scalar(r(r1))' & lastnm_electric<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_electric if year==2017 & lastnm_electric>`=scalar(r(r2))' & lastnm_electric<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastnm_electric if wbcode=="`ctry'" & year==2017 & lastnm_electric>0 & lastnm_electric<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastnm_electric if wbcode=="`ctry'" & year==2017 & lastnm_electric>`=scalar(r(r1))' & lastnm_electric<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_electric if wbcode=="`ctry'" & year==2017 & lastnm_electric>`=scalar(r(r2))' & lastnm_electric<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf: Percent with Access to Electricity}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_electric_`ctry', replace
		
		
		_pctile lastnm_road_traff if year==2017, p(33 66)
		twoway (scatter onesvec lastnm_road_traff if year==2017 & lastnm_road_traff>0 & lastnm_road_traff<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(turquoise)) /// 
		(scatter onesvec lastnm_road_traff if year==2017 & lastnm_road_traff>`=scalar(r(r1))' & lastnm_road_traff<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_road_traff if year==2017 & lastnm_road_traff>`=scalar(r(r2))' & lastnm_road_traff<=50, msymbol(Oh) msize(large)  mcolor(reddish)) ///							 
		(scatter onesvec lastnm_road_traff if wbcode=="`ctry'" & year==2017 & lastnm_road_traff>0 & lastnm_road_traff<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(turquoise)) ///							 
		(scatter onesvec lastnm_road_traff if wbcode=="`ctry'" & year==2017 & lastnm_road_traff>`=scalar(r(r1))' & lastnm_road_traff<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastnm_road_traff if wbcode=="`ctry'" & year==2017 & lastnm_road_traff>`=scalar(r(r2))' & lastnm_road_traff<=50, msize(huge) msymbol(solid) mlc(black) mfcolor(reddish)) /// 
		,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
		legend(off) title("{bf:Road Traffic Deaths per 100k}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastnm_road_traff_`ctry', replace
		
		
		// Tall version of slider graph 
		
		
		graph combine hci_`gender'_`ctry'.gph wbl_`ctry'.gph   ///
		lastafr_`ctry'.gph contracep_`ctry'.gph  lastspc_`ctry'.gph lastodcomp_`ctry'.gph  ///
		lastnm_hygiene_basic_`ctry'.gph lastnm_water_basic_plus_`ctry'.gph ///
		lastnm_clean_fuel_`ctry'.gph lastnm_electric_`ctry'.gph lastnm_road_traff_`ctry'.gph ///
		, colfirst rows(13) cols(1) ysize(10) xsize(5) graphregion(margin(l=22 r=22)) graphregion(margin(zero)) title("{bf: 1. Key Indicators on Human Capital}" /// 
		, size(large) suffix color(black) linegap(3)) graphregion(fcolor(white)) /// 
		note("{it:- Large circle=`country' ; small circles=other countries.}" ///
		"{it:- Vertical lines separate terciles of the distribution.}" /// 
		"{it:- Colors indicate the terciles of the distribution across countries.}" ///
		, size (small))
    graph export "$charts\all_`gender'_`ctry'.pdf", replace
    graph save "$charts\all_`gender'_`ctry'", replace
		
		erase hci_`gender'_`ctry'.gph
		erase lastodcomp_`ctry'.gph
		erase lasttfr_`ctry'.gph
		erase lastafr_`ctry'.gph
		erase contracep_`ctry'.gph
		erase wbl_`ctry'.gph
		erase unregpopcomp_`ctry'.gph
		erase ner_`ctry'.gph
		erase lastspc_`ctry'.gph
		erase lastner_sec_f_`ctry'.gph
		erase lastnm_sanit_basic_plus_`ctry'.gph
		erase lastnm_hygiene_basic_`ctry'.gph
		erase lastnm_water_basic_plus_`ctry'.gph
		erase lastnm_clean_fuel_`ctry'.gph
		erase lastnm_electric_`ctry'.gph
		erase lastnm_road_traff_`ctry'.gph
		
	}
}


//////////////////////////////////////////////////////////////////////////////////////END

//CODES FOR GRAPHS

//Figure 1.			
*##e
//////////////////////////////////////////////////////////////////////

count
numlist "1/`r(N)'"
local obs = "`r(numlist)'"
* local obs = 90

foreach i of local obs {
	if (wbregion[`i'] != "Sub-Saharan Africa") continue 
	
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	local country=wbcountryname in `i'
	local date "05-28-2019"
	
	foreach gender in mf {  //at this point only male+female (at later stage we can add m and f 
		
		
		
		
		_pctile hci_`gender' if year==2017, p(33 66)
		twoway (scatter onesvec hci_`gender' if year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec hci_`gender' if wbcode=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(0.45, lwidth(thick) lcolor(black) lpattern(solid) )  ///
		legend(off) title("{bf:Human Capital Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save hci_`gender'_`ctry', replace 
		
		
		
		_pctile lastodcomp if year==2017, p(33 66)
		twoway (scatter onesvec lastodcomp if year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastodcomp if wbcode=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(85, lwidth(thick) lcolor(black) lpattern(solid) )  ///
		legend(off) title("{bf:Percentage that does not Practice Open Defecation}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastodcomp_`ctry', replace
		
		_pctile lasttfr if year==2017, p(33 66)
		twoway (scatter onesvec lasttfr if year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(sky)) /// 
		(scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(gs10)) /// 							 
		(scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msymbol(Oh) msize(large)  mcolor(sea)) ///							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(sky)) ///							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(gs10)) /// 							 
		(scatter onesvec lasttfr if wbcode=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msize(huge) msymbol(solid) mlc(black) mfcolor(sea)) /// 
		, legend(off) title("{bf:Total Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lasttfr_`ctry', replace
		
		
		_pctile lastafr if year==2017, p(33 66)
		twoway (scatter onesvec lastafr if year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(sky)) /// 
		(scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(gs10)) /// 							 
		(scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msymbol(Oh) msize(large)  mcolor(sea)) ///							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(sky)) ///							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(gs10)) /// 							 
		(scatter onesvec lastafr if wbcode=="`ctry'" & year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msize(huge) msymbol(solid) mlc(black) mfcolor(sea)) /// 
		,xline(83, lwidth(thick) lcolor(black) lpattern(solid) ) ///
		legend(off) title("{bf:Adolescent Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastafr_`ctry', replace
		
		_pctile contracep if year==2017, p(33 66)
		twoway (scatter onesvec contracep if year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec contracep if wbcode=="`ctry'" & year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		, legend(off) title("{bf:Contraceptive Prevalence (Any Methods)}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save contracep_`ctry', replace
		
		_pctile wbl if year==2017, p(33 66)
		twoway (scatter onesvec wbl if year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec wbl if wbcode=="`ctry'" & year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		, legend(off) title("{bf:Women, Business, and the Law Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save wbl_`ctry', replace
		
		_pctile unregpopcomp if year==2017, p(33 66)
		twoway (scatter onesvec unregpopcomp if year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec unregpopcomp if wbcode=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		, legend(off) title("{bf:Percentage of Population Registered}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save unregpopcomp_`ctry', replace
		
		_pctile ner if year==2017, p(33 66)
		twoway (scatter onesvec ner if year==2017 & ner>0 & ner<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec ner if year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec ner if year==2017 & ner>`=scalar(r(r2))' & ner<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>0 & ner<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec ner if wbcode=="`ctry'" & year==2017 & ner>`=scalar(r(r2))' & ner<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		, legend(off) title("{bf:Net Enrollment Rate, Lower Secondary}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save ner_`ctry', replace
		
		
		_pctile lastspc if year==2017, p(33 66)
		twoway (scatter onesvec lastspc if year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastspc if wbcode=="`ctry'" & year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		,xline(30, lwidth(thick) lcolor(black) lpattern(solid) )  ///
		legend(off) title("{bf:Social Protection Coverage of the Poorest Quintile}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large))  graphregion(fcolor(white)) 
		graph save lastspc_`ctry', replace
		
		_pctile lastner_sec_f if year==2017, p(33 66)
		twoway (scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
		(scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
		(scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
		(scatter onesvec lastner_sec_f if wbcode=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		, legend(off) title("{bf:Female Net Enrollment Rate for Secondary School}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) graphregion(fcolor(white)) 
		graph save lastner_sec_f_`ctry', replace
		
		
		
		// Tall version of slider graph 
		
		
		graph combine hci_`gender'_`ctry'.gph  lastafr_`ctry'.gph lastspc_`ctry'.gph lastodcomp_`ctry'.gph, colfirst rows(4) cols(1) ysize(8) xsize(5) title("Indicators in the Africa Human Capital Plan", size(large) suffix color(black) linegap(3)) graphregion(fcolor(white))  /// 
		note("", size (small))
		graph save context_`gender'_`ctry', replace
		
		
		graph combine lasttfr_`ctry'.gph  contracep_`ctry'.gph wbl_`ctry'.gph lastner_sec_f_`ctry'.gph, colfirst rows(4) cols(1) ysize(8) xsize(5) title("Indicators on Women's Empowerment" /// 
		, size(large) suffix color(black) linegap(3)) graphregion(fcolor(white))  /// 
		note("", size (small))
		graph save women_`gender'_`ctry', replace
		
		graph combine context_`gender'_`ctry'.gph women_`gender'_`ctry'.gph, colfirst rows(2) cols(1) ysize(8) xsize(5) graphregion(margin(l=22 r=22)) graphregion(margin(zero)) title("{bf: 1. Human Capital Context}" /// 
		, size(large) suffix color(black) linegap(3)) graphregion(fcolor(white)) /// 
		note("{it:- Large circle=`country' ; small circles=other countries.}" ///
		"{it:- Vertical lines refer to regional targets.}" /// 
		"{it:- Colors indicate the terciles of the distribution across countries.}" ///
		, size (small))
    graph export "$charts\a_all_`gender'_`ctry'.pdf", replace
    graph save "$charts\a_all_`gender'_`ctry'", replace
		
		erase hci_`gender'_`ctry'.gph
		erase lastodcomp_`ctry'.gph
		erase lasttfr_`ctry'.gph
		erase lastafr_`ctry'.gph
		erase contracep_`ctry'.gph
		erase wbl_`ctry'.gph
		erase unregpopcomp_`ctry'.gph
		erase ner_`ctry'.gph
		erase lastspc_`ctry'.gph
		erase lastner_sec_f_`ctry'.gph
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////END




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*********************GRAPH FOR EXPEDNTURE IN SOCIAL SECTORS using % of GDP******
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
*********************GRAPH FOR EXPEDNTURE IN SOCIAL SECTORS using % of GDP******
//Figure 2.	
//COUNTRIES WITH SPJ SPENDING 

preserve //droping observations for sample with and without SPJ spending
keep if lastnm_all_soc_ass_pctgdp!=. & lastnm_all_soc_ass_pctgdp_mi!=. & lastnm_all_soc_ass_pctgdp_mr!=. ///
& lastnm_exp_total_percgdp_raw!=. & lastnm_exp_total_percgdp_raw_mi!=. & lastnm_exp_total_percgdp_raw_mr!=. ///
& lastnm_domphegdp!=. & lastnm_domphegdp_mr!=. & lastnm_domphegdp_mi!=.


local x=113
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	
	qui sum lastnm_domphegdp in `i'
	local hc=r(mean)+2 in `i' //locate where to display
	local hclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mr in `i'
	local hr=r(mean)+2 in `i' //locate where to display
	local hrlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mi in `i'
	local hi=r(mean)+2 in `i' //locate where to display
	local hilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw in `i'
	local ec=r(mean)+2 in `i' //locate where to display
	local eclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw_mr in `i'
	local er=r(mean)+2 in `i' //locate where to display
	local erlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw_mi in `i'
	local ei=r(mean)+2 in `i' //locate where to display
	local eilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp in `i'
	local sc=r(mean)+2 in `i' //locate where to display
	local sclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp_mr in `i'
	local sr=r(mean)+2 in `i' //locate where to display
	local srlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp_mi in `i'
	local si=r(mean)+2 in `i' //locate where to display
	local silabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	graph twoway ///
	(bar lastnm_domphegdp a, color(reddish)) ///
	(bar lastnm_domphegdp_mr b, color(turquoise)) ///
	(bar  lastnm_domphegdp_mi c, color(sky)) ///
	(bar x d) ///
	(bar lastnm_exp_total_percgdp_raw e, color(reddish)) ///
	(bar lastnm_exp_total_percgdp_raw_mr f, color(turquoise)) ///
	(bar lastnm_exp_total_percgdp_raw_mi g, color(sky)) ///
	(bar y h) ///
	(bar lastnm_all_soc_ass_pctgdp j, color(reddish)) ///
	(bar lastnm_all_soc_ass_pctgdp_mr k, color(turquoise)) ///
	(bar lastnm_all_soc_ass_pctgdp_mi l, color(sky)) ///
	in `i',  xlabel(  2 "Health" 6 "Education" 10 "Social Assistance") ylabel(0 (5)15) ///
	ytitle("% of GDP", size(medium)) title("2. Government Expenditure on the Social Sectors" , size(large) span) ///
	legend(label(1 "`ctry'") label(2 "`region'") label(3 "`income'")) legend(order(1 2 3) pos(5)col(3) row(1)) graphregion(fcolor(white)) ///
	graphregion(fcolor(white)) ysize(6) xsize(8) ///
	text(`hc' 1 "`hclabel'" `hr' 2 "`hrlabel'" `hi' 3 "`hilabel'" ///
	`ec' 5 "`eclabel'" `er' 6 "`erlabel'" `ei' 7 "`eilabel'" ///
	`sc' 9 "`sclabel'" `sr' 10 "`srlabel'" `si' 11 "`silabel'") 
	graph export "$charts\socsec_`ctry'.pdf", replace
	graph save "$charts\socsec_`ctry'", replace
	
}



restore
//COUNTRIES WITHOUT SPJ SPENDING 

preserve
keep if (lastnm_all_soc_ass_pctgdp==. | lastnm_all_soc_ass_pctgdp_mi==. | lastnm_all_soc_ass_pctgdp_mr==.) ///
& (lastnm_exp_total_percgdp_raw!=. & lastnm_exp_total_percgdp_raw_mi!=. & lastnm_exp_total_percgdp_raw_mr!=. ///
& lastnm_domphegdp!=. & lastnm_domphegdp_mr!=. & lastnm_domphegdp_mi!=.)



local x=61
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	
	qui sum lastnm_domphegdp in `i'
	local hc=r(mean)+2 in `i' //locate where to display
	local hclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mr in `i'
	local hr=r(mean)+2 in `i' //locate where to display
	local hrlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mi in `i'
	local hi=r(mean)+2 in `i' //locate where to display
	local hilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw in `i'
	local ec=r(mean)+2 in `i' //locate where to display
	local eclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw_mr in `i'
	local er=r(mean)+2 in `i' //locate where to display
	local erlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_exp_total_percgdp_raw_mi in `i'
	local ei=r(mean)+2 in `i' //locate where to display
	local eilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	
	graph twoway ///
	(bar lastnm_domphegdp a, color(reddish)) ///
	(bar lastnm_domphegdp_mr b, color(turquoise)) ///
	(bar  lastnm_domphegdp_mi c, color(sky)) ///
	(bar x d) ///
	(bar lastnm_exp_total_percgdp_raw e, color(reddish)) ///
	(bar lastnm_exp_total_percgdp_raw_mr f, color(turquoise)) ///
	(bar lastnm_exp_total_percgdp_raw_mi g, color(sky)) ///
	in `i' ,  xlabel(  2 "Health" 6 "Education" ) ylabel(0 (5)15) ///
	ytitle("% of GDP", size(medium)) title("2. Government Expenditure on the Social Sectors" , size(large) span) ///
	legend(label(1 "`ctry'") label(2 "`region'") label(3 "`income'")) legend(order(1 2 3) pos(5) col(2) row(1)) graphregion(fcolor(white)) ///
	graphregion(fcolor(white)) ysize(6) xsize(8) ///
	text(`hc' 1 "`hclabel'" `hr' 2 "`hrlabel'" `hi' 3 "`hilabel'" ///
	`ec' 5 "`eclabel'" `er' 6 "`erlabel'" `ei' 7 "`eilabel'") 
	graph export "$charts\socsec_`ctry'.pdf", replace
	graph save "$charts\socsec_`ctry'", replace
}


restore


//COUNTRIES WITHOUT EDU SPENDING 

preserve
keep if (lastnm_exp_total_percgdp_raw==. | lastnm_exp_total_percgdp_raw_mi==. | lastnm_exp_total_percgdp_raw_mr==.) ///
& (lastnm_all_soc_ass_pctgdp!=. & lastnm_all_soc_ass_pctgdp_mi!=. & lastnm_all_soc_ass_pctgdp_mr!=. ///
& lastnm_domphegdp!=. & lastnm_domphegdp_mr!=. & lastnm_domphegdp_mi!=.)

local x=7
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	
	qui sum lastnm_domphegdp in `i'
	local hc=r(mean)+2 in `i' //locate where to display
	local hclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mr in `i'
	local hr=r(mean)+2 in `i' //locate where to display
	local hrlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_domphegdp_mi in `i'
	local hi=r(mean)+2 in `i' //locate where to display
	local hilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp in `i'
	local spjgovc=r(mean)+2 in `i' //locate where to display
	local spjgovclabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp_mr in `i'
	local spjgovr=r(mean)+2 in `i' //locate where to display
	local spjgovrlabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	qui sum lastnm_all_soc_ass_pctgdp_mi in `i'
	local spjgovi=r(mean)+2 in `i' //locate where to display
	local spjgovilabel: disp %4.1fc round(r(mean),.1)  // option 1
	
	
	graph twoway ///
	(bar lastnm_domphegdp a, color(reddish)) ///
	(bar lastnm_domphegdp_mr b, color(turquoise)) ///
	(bar  lastnm_domphegdp_mi c, color(sky)) ///
	(bar x d) ///
	(bar lastnm_all_soc_ass_pctgdp e, color(reddish)) ///
	(bar lastnm_all_soc_ass_pctgdp_mr f, color(turquoise)) ///
	(bar lastnm_all_soc_ass_pctgdp_mi g, color(sky)) ///
	in `i' ,  xlabel(  2 "Health" 6 "Social Assistance" ) ylabel(0 (5)15) ///
	ytitle("% of GDP", size(medium)) title("2. Government Expenditure on Health & Social Assistance" , size(large) span) ///
	legend(label(1 "`ctry'") label(2 "`region'") label(3 "`income'")) legend(order(1 2 3) pos(5) col(2) row(1)) graphregion(fcolor(white)) ///
	graphregion(fcolor(white)) ysize(6) xsize(8) ///
	text(`hc' 1 "`hclabel'" `hr' 2 "`hrlabel'" `hi' 3 "`hilabel'" ///
	`ec' 5 "`spjgovclabel'" `er' 6 "`spjgovrlabel'" `ei' 7 "`spjgovilabel'") 
	graph export "$charts\socsec_`ctry'.pdf", replace
	graph save "$charts\socsec_`ctry'", replace
}






restore

////////////////////////////////////////////////////////////////////////////////////////////////////////


///Figure 3. Efficiency of spending 
/// Generate graphs for all countries incluing those without SP spending 
//////// we should then use "efficiency1" in the 2pager if SP spending is missing. This is the best way i think.

local x=217
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	
	twoway ///
	(scatter hci_mf log_health_ed_pc, mcolor(white) msize(vsmall)  msymbol(circle)) ///
	(scatter hci_mf log_health_ed_pc if show==1, mlcolor(gray) mfcolor(white) msymbol(circle) mlabel(wbcountryname) mlabcolor(gray) mlabpos(9) mlabsize(medium)) ///
	(scatter hci_mf log_health_ed_pc if wbcode=="`ctry'" , mlabel(wbcountryname) mcolor(green) msymbol(solid) mlabcolor(green) mlabpos(9) mlabsize(medium)) ///
	(lfit hci_mf log_health_ed_pc , lcolor (sky) lpattern(solid)) ///
	, legend(off) xtitle(Log Spending Per Capita in Health and Education, size(large)) ytitle(HCI, size(large)) ///
	title("3. Spending on Health and Education and HCI", size(vlarge)) xsize(6) ysize(4) ///
	note("{it: - A selection of 146 countries in the regression are displayed.}" , size(medium) color(gray))
	graph export "$charts\efficiency_`ctry'.pdf", replace
	graph save "$charts\efficiency_`ctry'", replace
}

///Figure 3. Efficiency of spending 
/// countries with SP spending
preserve
keep if health_ed_sp_pc!=.
local x=115
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	
	twoway ///
	(scatter hci_mf log_health_ed_sp_pc, mcolor(white) msize(vsmall)  msymbol(circle)) ///
	(scatter hci_mf log_health_ed_sp_pc if show==1, mlcolor(gray) mfcolor(white) msymbol(circle) mlabel(wbcountryname) mlabcolor(gray) mlabpos(9) mlabsize(medium)) ///
	(scatter hci_mf log_health_ed_sp_pc if wbcode=="`ctry'" , mlabel(wbcountryname) mcolor(green) msymbol(solid)  mlabcolor(green) mlabpos(9) mlabsize(medium)) ///
	(lfit hci_mf log_health_ed_sp_pc , lcolor (sky) lpattern(solid)) ///
	, legend(off) xtitle(Log Spending Per Capita in Social Sectors, size(large)) ytitle(HCI, size(large)) ///
	title("3. Spending on Social Sectors and HCI", size(vlarge)) xsize(6) ysize(4) ///
	note("{it: - A selection out of 101 countries in the regression are displayed.}" , size(medium) color(gray))
	graph export "$charts\efficiency_`ctry'.pdf", replace
	graph save "$charts\efficiency_`ctry'", replace
}
restore


//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Figure 4*****GRAPH ON TAX TO GDP RATIO AND GDP... only with selected countries*****  

local x=217
forvalues i=1/`x' {
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	
	twoway ///
	(scatter drm lny if drm<33, mcolor(white) msize(vsmall) msymbol(circle)) ///
	(scatter drm lny  if drm<33 & show2==1, mlcolor(gray) mfcolor(white) msymbol(circle) mlabel(wbcountryname) mlabcolor(gray) mlabpos(9) mlabsize(medium)) ///
	(scatter drm lny  if drm<33 &  wbcode=="`ctry'" , mlabel(wbcountryname) mcolor(green)  msymbol(solid)  mlabcolor(green) mlabpos(9) mlabsize(medium)) ///
	,legend(off) xtitle(Log GDP Per Capita at PPP, size(large)) ytitle(Tax Collection as % GDP, size(large)) ///
	title("4. Domestic Resource Mobilization", size(vlarge)) xsize(6) ysize(4) ///
	note("{it: - A selection of countries are displayed.}" ///
	"{it:- Countries with DRM greater than 33% of GDP are excluded.}" , size(medium) color(gray))
	graph export "$charts\drm_`ctry'.pdf", replace
	graph save "$charts\drm_`ctry'", replace
}













