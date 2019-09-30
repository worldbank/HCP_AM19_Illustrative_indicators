clear
set more off

use scorecardanalysis12



//for regional and income average plots
*encode wbregion, gen(region)
*encode wbincomegroup, gen(income)

*gen lastodcomp = 100-lastod
*gen unregpopcomp=  100-unregpop_share

*gen tnep_mf=tner_p_mf_fill
*gen tnep_m=tner_p_m_fill
*gen tnep_f=tner_p_f_fill


*gen ner = ner_ls_mf_fill

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


							
							
							
							





***************************SLIDER WITH PLOTPLAINBLIND COLOR OPTIONS CHOSEN AMONG (*ananas, sky, turquoise, reddish, vermillion, sea, and orangebrown.)


****************************1. ALL COLORED WITH UNCERTAINITY VERSION OF SLIDERS				 
			
		
//countries of interest [insert here]
local countries "Ethiopia" 
local date "05-28-2019"

foreach ctry in `countries' {  

	foreach gender in mf {  //at this point only male+female (at later stage we can add m and f 

                             
							 
							 
							 
							 _pctile hci_`gender' if year==2017, p(33 66)
                             twoway (scatter onesvec hci_`gender' if year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec hci_`gender' if year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec hci_`gender' if wbcountryname=="`ctry'" & year==2017 & hci_`gender'>0 & hci_`gender'<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec hci_`gender' if wbcountryname=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r1))' & hci_`gender'<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec hci_`gender' if wbcountryname=="`ctry'" & year==2017 & hci_`gender'>`=scalar(r(r2))' & hci_`gender'<=1, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Human Capital Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save hci_`gender'_`ctry', replace 
							
														 _pctile lastodcomp if year==2017, p(33 66)
                             twoway (scatter onesvec lastodcomp if year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec lastodcomp if year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec lastodcomp if wbcountryname=="`ctry'" & year==2017 & lastodcomp>0 & lastodcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec lastodcomp if wbcountryname=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r1))' & lastodcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec lastodcomp if wbcountryname=="`ctry'" & year==2017 & lastodcomp>`=scalar(r(r2))' & lastodcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Percentage that does not practice Open Defecation}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save lastodcomp_`ctry', replace

														 _pctile lasttfr if year==2017, p(33 66)
                             twoway (scatter onesvec lasttfr if year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec lasttfr if year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec lasttfr if wbcountryname=="`ctry'" & year==2017 & lasttfr>0 & lasttfr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec lasttfr if wbcountryname=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r1))' & lasttfr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec lasttfr if wbcountryname=="`ctry'" & year==2017 & lasttfr>`=scalar(r(r2))' & lasttfr<=10, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Total Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save lasttfr_`ctry', replace
						
														 _pctile lastafr if year==2017, p(33 66)
                             twoway (scatter onesvec lastafr if year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec lastafr if year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec lastafr if wbcountryname=="`ctry'" & year==2017 & lastafr>0 & lastafr<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec lastafr if wbcountryname=="`ctry'" & year==2017 & lastafr>`=scalar(r(r1))' & lastafr<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec lastafr if wbcountryname=="`ctry'" & year==2017 & lastafr>`=scalar(r(r2))' & lastafr<=200, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Adolescent Fertility Rate}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save lastafr_`ctry', replace

														 _pctile contracep if year==2017, p(33 66)
                             twoway (scatter onesvec contracep if year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec contracep if year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec contracep if wbcountryname=="`ctry'" & year==2017 & contracep>0 & contracep<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec contracep if wbcountryname=="`ctry'" & year==2017 & contracep>`=scalar(r(r1))' & contracep<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec contracep if wbcountryname=="`ctry'" & year==2017 & contracep>`=scalar(r(r2))' & contracep<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Contraceptive prevalence (any methods)}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save contracep_`ctry', replace

							 												 _pctile wbl if year==2017, p(33 66)
                             twoway (scatter onesvec wbl if year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec wbl if year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec wbl if wbcountryname=="`ctry'" & year==2017 & wbl>0 & wbl<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec wbl if wbcountryname=="`ctry'" & year==2017 & wbl>`=scalar(r(r1))' & wbl<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec wbl if wbcountryname=="`ctry'" & year==2017 & wbl>`=scalar(r(r2))' & wbl<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Women, Business, and the Law Index}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save wbl_`ctry', replace

							 							 _pctile unregpopcomp if year==2017, p(33 66)
                             twoway (scatter onesvec unregpopcomp if year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec unregpopcomp if year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec unregpopcomp if wbcountryname=="`ctry'" & year==2017 & unregpopcomp>0 & unregpopcomp<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec unregpopcomp if wbcountryname=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r1))' & unregpopcomp<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec unregpopcomp if wbcountryname=="`ctry'" & year==2017 & unregpopcomp>`=scalar(r(r2))' & unregpopcomp<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Percentage of Population Registered}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save unregpopcomp_`ctry', replace
							 
							 _pctile ner if year==2017, p(33 66)
                             twoway (scatter onesvec ner if year==2017 & ner>0 & ner<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec ner if year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec ner if year==2017 & ner>`=scalar(r(r2))' & ner<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec ner if wbcountryname=="`ctry'" & year==2017 & ner>0 & ner<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec ner if wbcountryname=="`ctry'" & year==2017 & ner>`=scalar(r(r1))' & ner<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec ner if wbcountryname=="`ctry'" & year==2017 & ner>`=scalar(r(r2))' & ner<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Net enrollment rate, lower secondary}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save ner_`ctry', replace

							 							 _pctile lastspc if year==2017, p(33 66)
                             twoway (scatter onesvec lastspc if year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec lastspc if year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec lastspc if wbcountryname=="`ctry'" & year==2017 & lastspc>0 & lastspc<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec lastspc if wbcountryname=="`ctry'" & year==2017 & lastspc>`=scalar(r(r1))' & lastspc<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec lastspc if wbcountryname=="`ctry'" & year==2017 & lastspc>`=scalar(r(r2))' & lastspc<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Social Protection Coverage}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save lastspc_`ctry', replace
							 
							 							 _pctile lastner_sec_f if year==2017, p(33 66)
                             twoway (scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msymbol(Oh) msize(large) mcolor(reddish)) /// 
                             (scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msymbol(Oh) msize(large)  mcolor(orangebrown)) /// 							 
                             (scatter onesvec lastner_sec_f if year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msymbol(Oh) msize(large)  mcolor(turquoise)) ///							 
							 (scatter onesvec lastner_sec_f if wbcountryname=="`ctry'" & year==2017 & lastner_sec_f>0 & lastner_sec_f<=`=scalar(r(r1))', msize(huge) msymbol(solid)  mlc(black) mfcolor(reddish)) ///							 
                             (scatter onesvec lastner_sec_f if wbcountryname=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r1))' & lastner_sec_f<=`=scalar(r(r2))', msize(huge) msymbol(solid) mlc(black)  mfcolor(orangebrown)) /// 							 
                             (scatter onesvec lastner_sec_f if wbcountryname=="`ctry'" & year==2017 & lastner_sec_f>`=scalar(r(r2))' & lastner_sec_f<=100, msize(huge) msymbol(solid) mlc(black) mfcolor(turquoise)) /// 
		                      ,xline(`=scalar(r(r1))', lwidth(thick) lcolor(black) lpattern(solid) ) xline(`=scalar(r(r2))', lwidth(thick) lcolor(black) lpattern(solid))  ///
							legend(off) title("{bf:Female Net Enrollment Rate for Secondary School}", size(vlarge) pos(11)) xtitle("") ytitle("") yscale(range(0 2)) ylabel(none) xlabel(,labsize(large)) 
							 graph save lastner_sec_f_`ctry', replace
	 
		
							  
							  
	// Tall version of slider graph 

	
	// Tall version of slider graph 
	
	
	graph combine hci_`gender'_`ctry'.gph   lastspc_`ctry'.gph lastodcomp_`ctry'.gph, colfirst rows(2) cols(1) ysize(1) xsize(5) title("", suffix color(black) linegap(3)) /// 
	note("", size (small))
	graph save context_`gender'_`ctry', replace

	
	graph combine lasttfr_`ctry'.gph   lastafr_`ctry'.gph contracep_`ctry'.gph wbl_`ctry'.gph lastner_sec_f_`ctry'.gph, colfirst rows(5) cols(1) ysize(8) xsize(5) title("Women Empowerment" /// 
	, size(large) suffix color(black) linegap(3)) /// 
	note("", size (small))
	graph save women_`gender'_`ctry', replace

	graph combine context_`gender'_`ctry'.gph women_`gender'_`ctry'.gph, colfirst rows(2) cols(1) ysize(8) xsize(5) graphregion(margin(l=22 r=22)) graphregion(margin(zero)) title("{bf:Human Capital Context}" /// 
	, size(large) suffix color(black) linegap(3)) /// 
	note("Note:" ///
	"- Large circle represents `ctry' and small sircles represent other countries." ///
	"- Vertical lines separates terciles of the distribution." /// 
	"- Pink reflects the first tercile of the distribution, orange the second one, and" ///
	"  green the third one.", size (small))
	graph save all_`gender'_`ctry', replace
	graph export all_`gender'_`ctry'.pdf, replace
	}
	}


	
	
*********************GRAPH FOR EXPEDNTURE IN SOCIAL SECTORS using % of Government Expenditure******
gen vacuum=.
gen vacuum2=.

egen edugov_mi=mean( edugov ) if year==2017, by(wbincomegroup)
egen edugov_mr=mean( edugov ) if year==2017, by(wbregion)
egen socprotgov_mi=mean( socprotgov ) if year==2017, by(wbincomegroup)
egen socprotgov_mr=mean( socprotgov ) if year==2017, by(wbregion)
egen healthgov_mi=mean( healthgov ) if year==2017, by(wbincomegroup)
egen healthgov_mr=mean(healthgov ) if year==2017, by(wbregion)

graph hbar healthgov healthgov_mr healthgov_mi vacuum edugov edugov_mr edugov_mi vacuum2 socprotgov socprotgov_mr socprotgov_mi if wbcountryname=="Ethiopia", showyvars  bar(1, fcolor(reddish)) bar(2, fcolor(turquoise)) bar(3, fcolor(sky)) bar(4, fcolor(grey)) bar(5, fcolor(reddish)) bar(6, fcolor(turquoise)) bar(7, fcolor(sky)) bar(8, fcolor(grey)) bar(9, fcolor(reddish)) bar(10, fcolor(turquoise)) bar(11, fcolor(sky)) bar(12, fcolor(grey)) yvaroptions(relabel(1 "." 2"Health" 3"." 4 "." 5"." 6 "Education" 7 "." 8 "." 9 "." 10 "Social Protection" 11 "." 12 "."))  blabel(bar, format(%9.1f)) ytitle(% of Government Expenditure) title(Government Expenditure in Social Sectors, size (large)) legend(position(6) lab(1 "Ethiopia") lab(2 "Sub-Saharan Africa Average") lab(3 "Low Income Average") order(1 2 3) cols(3))
graph save socsec_Ethiopia, replace
graph export socsec_Ethiopia.pdf, replace

*********************GRAPH FOR EXPEDNTURE IN SOCIAL SECTORS using % of GDP******
*gen vacuum=.
*gen vacuum2=.

*egen exp_total_percgdp_raw_r_mi=mean( exp_total_percgdp_raw_r ) if year==2017, by(wbincomegroup)
*egen exp_total_percgdp_raw_r_mr=mean( exp_total_percgdp_raw_r ) if year==2017, by(wbregion)
*egen allsocialassistance_pctgdp_r_mi=mean( allsocialassistance_pctgdp_r ) if year==2017, by(wbincomegroup)
*egen allsocialassistance_pctgdp_r_mr=mean( allsocialassistance_pctgdp_r ) if year==2017, by(wbregion)
*egen domphegdp_r_mi=mean( domphegdp_r ) if year==2017, by(wbincomegroup)
*egen domphegdp_r_mr=mean(domphegdp_r ) if year==2017, by(wbregion)

*graph hbar domphegdp_r domphegdp_r_mr domphegdp_r_mi vacuum exp_total_percgdp_raw_r exp_total_percgdp_raw_r_mr exp_total_percgdp_raw_r_mi vacuum2 allsocialassistance_pctgdp_r allsocialassistance_pctgdp_r_mr allsocialassistance_pctgdp_r_mi if wbcountryname=="Ethiopia", showyvars  bar(1, fcolor(reddish)) bar(2, fcolor(turquoise)) bar(3, fcolor(sky)) bar(4, fcolor(grey)) bar(5, fcolor(reddish)) bar(6, fcolor(turquoise)) bar(7, fcolor(sky)) bar(8, fcolor(grey)) bar(9, fcolor(reddish)) bar(10, fcolor(turquoise)) bar(11, fcolor(sky)) bar(12, fcolor(grey)) yvaroptions(relabel(1 "." 2"Health" 3"." 4 "." 5"." 6 "Education" 7 "." 8 "." 9 "." 10 "Social Protection" 11 "." 12 "."))  blabel(bar, format(%9.1f)) ytitle(% of Gross Domestic Product) title(Government Expenditure in Social Sectors, size (large)) legend(position(6) lab(1 "Ethiopia") lab(2 "Sub-Saharan Africa Average") lab(3 "Low Income Average") order(1 2 3) cols(3))



******GRAPH FOR EFFICIENCY OF SPENDING******
*preserve 
*gen socsecgov= healthgov + edugov + socprotgov

*drop if socsecgov>15  
*twoway scatter hci_mf socsecgov [w=pop] ||  scatter hci_mf socsecgov [w=pop] if wbcountryname=="Nigeria" | wbcountryname=="Nigeria" |wbcountryname=="Nigeria" |wbcountryname=="Chad" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep.", mlabel(wbcountryname) mlabsize(tiny) msymbol(circle)|| lfit hci_mf socsecgov [w=pop] || scatter hci_mf socsecgov [w=pop]  if wbcountryname=="Ethiopia", mcolor(sky) msymbol(circle) fcolor(sky) legend(pos(6) col(2) order(4 "Ethiopia" 1 "Rest of the World")) xtitle(Total Spending in Social Sectors as % of Government Expenditure) ytitle(HCI) title(Spending in Social Sectors and HCI, size(large)) xsize(6) ysize(4) note("Note: The size of the circles is proportional to the population of the country", size(small))
*restore




******GRAPH FOR EFFICIENCY OF SPENDING using % GDP*****
  
*gen totsocsector= domphegdp_r + allsocialassistance_pctgdp_r + exp_total_percgdp_raw_r
*preserve
*drop if totsocsector>15
*twoway scatter hci_mf totsocsector [w=pop]|| scatter hci_mf totsocsector [w=pop] if wbcountryname=="Nigeria" | wbcountryname=="Nigeria" |wbcountryname=="Nigeria" |wbcountryname=="Chad" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep.", mlabel(wbcountryname) mlabsize(medium) msymbol(circle)|| lfit hci_mf totsocsector [w=pop], lcolor (ebblue) || scatter hci_mf totsocsector [w=pop]  if wbcountryname=="Ethiopia", mcolor(sky) mlabc(sky) msymbol(circle) fcolor(sky) legend(pos(6) col(2) order(4 "Ethiopia" 1 "Rest of the World")) xtitle(Total Spending in Social Sectors as % of GDP, size(large)) ytitle(HCI, size(large)) title(Spending in Social Sectors and HCI, size(vlarge)) xsize(6) ysize(4) note("Note: The size of the circles is proportional to the population of the country", size(medium))
*restore

******GRAPH FOR EFFICIENCY OF SPENDING using % GDP and only including a few countries*****
  
*gen totsocsector= domphegdp_r + allsocialassistance_pctgdp_r + exp_total_percgdp_raw_r
*preserve
*drop if totsocsector>15
*twoway scatter hci_mf totsocsector [w=pop], mcolor(white) || scatter hci_mf totsocsector [w=pop] if wbcountryname=="Nigeria" |wbcountryname=="Chad" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep." , mlcolor(gray) mfcolor(white) msymbol(circle)|| scatter hci_mf totsocsector [w=pop] if wbcountryname=="Nigeria" |wbcountryname=="Chad"  | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep." , mcolor(white) mlabel(wbcountryname) mlabsize(medium) msymbol(circle)|| lfit hci_mf totsocsector [w=pop], lcolor (sky) lpattern(solid) || scatter hci_mf totsocsector [w=pop]  if wbcountryname=="Ethiopia" , mlabel(wbcountryname) mcolor(white)  msymbol(circle)  mlabcolor(sky) mlabpos(12) mlabsize(medium) legend(off) xtitle(Total Spending in Social Sectors as % of GDP, size(large)) ytitle(HCI, size(large)) title(Spending in Social Sectors and HCI, size(vlarge)) xsize(6) ysize(4) note("Note: The predicted line has been calculated for a total of 112 countries, but" "only selected countries are shown. The size of the circles is proportional to" "the population of the country. Countries with spending greater than 15% of" "GDP have been excluded.", size(medium))
*restore


******GRAPH FOR EFFICIENCY OF SPENDING using per capita spending and only including a few countries*****
  
*gen totsocsector= domphegdp_r + allsocialassistance_pctgdp_r + exp_total_percgdp_raw_r
*preserve
*drop if totsocsector>15
*twoway scatter hci_mf health_ed_sp_pc [w=pop], mcolor(white) || scatter hci_mf health_ed_sp_pc [w=pop] if wbcountryname=="Nigeria" |wbcountryname=="Chad" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep." , mlcolor(gray) mfcolor(white) msymbol(circle)|| scatter hci_mf health_ed_sp_pc [w=pop] if wbcountryname=="Nigeria" |wbcountryname=="Chad"  | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep." , mcolor(white) mlabel(wbcountryname) mlabsize(medium) msymbol(circle)|| lfit hci_mf health_ed_sp_pc [w=pop], lcolor (sky) lpattern(solid) || scatter hci_mf health_ed_sp_pc [w=pop]  if wbcountryname=="Ethiopia" , mlabel(wbcountryname) mcolor(white)  msymbol(circle)  mlabcolor(sky) mlabpos(12) mlabsize(medium) legend(off) xtitle(Total Spending in Social Sectors as % of GDP, size(large)) ytitle(HCI, size(large)) title(Spending in Social Sectors and HCI, size(vlarge)) xsize(6) ysize(4) note("Note: The predicted line has been calculated for a total of 112 countries, but" "only selected countries are shown. The size of the circles is proportional to" "the population of the country. Countries with spending greater than 15% of" "GDP have been excluded.", size(medium))
*restore

******GRAPH FOR EFFICIENCY OF SPENDING using log of per capita spending and only including a few countries*****
  
gen log_health_ed_sp_pc = log(health_ed_sp_pc)
twoway scatter hci_mf log_health_ed_sp_pc [w=pop], mcolor(white) || scatter hci_mf log_health_ed_sp_pc [w=pop] if wbcountryname=="Chad" |wbcountryname=="Bangladesh" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Angola"| wbcountryname=="Georgia" | wbcountryname=="Kazakhstan"| wbcountryname=="Brazil" | wbcountryname=="Botswana" | wbcountryname=="Slovenia" , mlcolor(gray) mfcolor(white) msymbol(circle)|| scatter hci_mf log_health_ed_sp_pc [w=pop] if wbcountryname=="Chad" |wbcountryname=="Bangladesh"  | wbcountryname=="Kenya" | wbcountryname=="Angola"| wbcountryname=="Georgia" | wbcountryname=="Kazakhstan"| wbcountryname=="Brazil" | wbcountryname=="Botswana" | wbcountryname=="Slovenia", mcolor(white) mlabel(wbcountryname) mlabpos(9) mlabsize(medium) msymbol(circle)|| lfit hci_mf log_health_ed_sp_pc [w=pop], lcolor (sky) lpattern(solid) || scatter hci_mf log_health_ed_sp_pc [w=pop]  if wbcountryname=="Ethiopia" , mlabel(wbcountryname) mcolor(white)  msymbol(circle)  mlabcolor(sky) mlabpos(12) mlabsize(medium) legend(off) xtitle(Log Spending per capita in Social Sectors, size(large)) ytitle(HCI, size(large)) title(Spending in Social Sectors and HCI, size(vlarge)) xsize(6) ysize(4) note("Note: The predicted line has been calculated for a total of 115 countries, but" "only selected countries are shown. The size of the circles is proportional to" "the population of the country." , size(medium))
graph save efficiency_Ethiopia, replace
graph export efficiency_Ethiopia.pdf, replace
reg hci_mf log_health_ed_sp_pc  [w=pop]
predict phci_mf
gen difhcipred = hci_mf-phci_mf


*******GRAPH ON TAX TO GDP RATIO AND GDP*****
*twoway scatter drm lny [w=pop] || scatter drm lny [w=pop] if wbcountryname=="Nigeria" | wbcountryname=="Nigeria" |wbcountryname=="Nigeria" |wbcountryname=="Chad" |wbcountryname=="Ethiopia" | wbcountryname=="Kenya" | wbcountryname=="Rwanda"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Korea, Rep.", mlabel(wbcountryname) mlabcolor(black) mlabsize(medium) msymbol(circle) || lfit drm lny [w=pop], lcolor(ebblue) || scatter drm lny [w=pop]  if wbcountryname=="Ethiopia", mcolor(sky) msymbol(circle) fcolor(sky) legend(pos(6) col(2) order(4 "Ethiopia" 1 "Rest of the World")) xtitle(Log GDP per capita PPP, size(large)) ytitle(Tax collection as % of GDP, size(large)) title(Domestic Resource Mobilization and GDP, size(vlarge)) note("Note: The size of the circles is proportional to the population of the country", size(medium))



*******GRAPH ON TAX TO GDP RATIO AND GDP only with selected countries*****  
twoway scatter drm lny [w=pop] if drm<25, mcolor(white) || scatter drm lny [w=pop] if drm<25 & wbcountryname=="United Arab Emirates" |wbcountryname=="Mozambique" |wbcountryname=="Ethiopia" | wbcountryname=="Nigeria" | wbcountryname=="Burundi"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Singapore" , mlcolor(gray) mfcolor(white) msymbol(circle)|| lfit drm lny [w=pop] if drm<25, lcolor (sky) lpattern(solid) ||scatter drm lny [w=pop] if drm<25 &  wbcountryname=="United Arab Emirates" |wbcountryname=="Mozambique"  | wbcountryname=="Nigeria" | wbcountryname=="Burundi"| wbcountryname=="Bangladesh" | wbcountryname=="Brazil"| wbcountryname=="Turkey" | wbcountryname=="Singapore" , mcolor(white) mlabel(wbcountryname) mlabpos(12) mlabsize(medium) msymbol(circle)||  scatter drm lny [w=pop]  if drm<25 & wbcountryname=="Ethiopia" , mlabel(wbcountryname) mcolor(white)  msymbol(circle)  mlabcolor(sky) mlabpos(12) mlabsize(medium) legend(off) xtitle(Log GDP per capita PPP, size(large)) ytitle(Tax collection as % GDP, size(large)) title(Domestic Resource Mobilization and GDP, size(vlarge)) xsize(6) ysize(4) note("Note: The predicted line has been calculated for a total of 135 countries, but" "only selected countries are shown. The size of the circles is proportional to" "the population of the country. Countries with DRM greater than 25% of" "GDP have been excluded.", size(medium))
graph save drm_Ethiopia, replace
graph export drm_Ethiopia.pdf, replace
reg drm lny  [w=pop] if drm<25
predict pdrm
gen difdrmpred = drm-pdrm

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
*keep lastner_sec_f lastner_sec_f_mr lastner_sec_f_mi lastner_sec_f_sdr lastner_sec_f_sdm percsatisfip_hd percsatisfip_edu percsatisfip_hnp percsatisfip_spj percsatisfdo_hd percsatisfdo_edu percsatisfdo_hnp percsatisfdo_spj avgsize_hd avgsize_edu avgsize_hnp avgsize_spj hdportfolio eduportfolio hnpportfolio spjportfolio pipeline_hd pipeline_edu pipeline_hnp pipeline_spj terc_disburratio_spj terc_avgsize_hd terc_avgsize_edu terc_avgsize_hnp terc_avgsize_spj terc_crossgpshare_hd terc_crossgpshare_edu terc_crossgpshare_hnp terc_crossgpshare_spj terc_ip_performance_hd terc_ip_performance_edu terc_ip_performance_hnp terc_ip_performance_spj terc_disburratio_hd terc_disburratio_edu terc_disburratio_hnp terc_pipeline_hnp_share terc_pipeline_spj_share terc_do_performance_hd terc_do_performance_edu terc_do_performance_hnp terc_do_performance_spj terc_hdportfolio_share 	terc_eduportfolio_share terc_hnpportfolio_share terc_spjportfolio_share terc_pipeline_hd_share terc_pipeline_edu_share  hdportfolio_share_sdr hdportfolio_share_sdi eduportfolio_share_sdr eduportfolio_share_sdi hnpportfolio_share_sdr hnpportfolio_share_sdi spjportfolio_share_sdr spjportfolio_share_sdi pipeline_hd_share_sdr pipeline_hd_share_sdi pipeline_edu_share_sdr pipeline_edu_share_sdi pipeline_hnp_share_sdr pipeline_hnp_share_sdi pipeline_spj_share_sdr pipeline_spj_share_sdi do_performance_hd_sdr do_performance_hd_sdi do_performance_edu_sdr do_performance_edu_sdi do_performance_hnp_sdr do_performance_hnp_sdi do_performance_spj_sdr do_performance_spj_sdi ip_performance_hd_sdr ip_performance_hd_sdi ip_performance_edu_sdr ip_performance_edu_sdi ip_performance_hnp_sdr ip_performance_hnp_sdi ip_performance_spj_sdr ip_performance_spj_sdi disburratio_hd_sdr disburratio_hd_sdi disburratio_edu_sdr disburratio_edu_sdi disburratio_hnp_sdr disburratio_hnp_sdi disburratio_spj_sdr disburratio_spj_sdi avgsize_hd_sdr avgsize_hd_sdi avgsize_edu_sdr avgsize_edu_sdi avgsize_hnp_sdr avgsize_hnp_sdi avgsize_spj_sdi crossgpshare_hd_sdr crossgpshare_hd_sdi crossgpshare_edu_sdr crossgpshare_edu_sdi crossgpshare_hnp_sdr crossgpshare_hnp_sdi crossgpshare_spj_sdr crossgpshare_spj_sdi crossgpshare_spj_diffmi crossgpshare_hnp_diffmi crossgpshare_edu_diffmi crossgpshare_hd_diffmi crossgpshare_spj_diffmr crossgpshare_hnp_diffmr crossgpshare_edu_diffmr crossgpshare_hd_diffmr  avgsize_spj_diffmi avgsize_hnp_diffmi avgsize_edu_diffmi avgsize_hd_diffmi avgsize_spj_diffmr  avgsize_hnp_diffmr  avgsize_edu_diffmi  avgsize_hd_diffmi avgsize_spj_diffmr avgsize_hnp_diffmr  avgsize_edu_diffmr  avgsize_hd_diffmr  disburratio_hd_diffmi disburratio_edu_diffmi disburratio_hnp_diffmi disburratio_spj_diffmi disburratio_hd_diffmr disburratio_edu_diffmr disburratio_hnp_diffmr disburratio_spj_diffmr ip_performance_spj_diffmi ip_performance_hnp_diffmi ip_performance_edu_diffmi ip_performance_hd_diffmi  ip_performance_spj_diffmr ip_performance_hnp_diffmr  ip_performance_edu_diffmr  ip_performance_hd_diffmr do_performance_spj_diffmi do_performance_hnp_diffmi do_performance_edu_diffmi do_performance_hd_diffmi do_performance_spj_diffmr do_performance_hnp_diffmr do_performance_edu_diffmr do_performance_hd_diffmr pipeline_spj_share_diffmi  pipeline_hnp_share_diffmi  pipeline_edu_share_diffmi pipeline_hd_share_diffmi pipeline_spj_share_diffmr pipeline_hnp_share_diffmr  pipeline_edu_share_diffmr  pipeline_hd_share_diffmr  spjportfolio_share_diffmi hnpportfolio_share_diffmi hdportfolio_share_diffmr  eduportfolio_share_diffmr hnpportfolio_share_diffmr spjportfolio_share_diffmr hdportfolio_share_diffmi eduportfolio_share_diffmi wbcountryname wbregion wbincomegroup hci_mf_100 lastspc lastspc_mr lastspc_mi lastod lastod_mr lastod_mi lasttfr lasttfr_mr lasttfr_mi lastafr lastafr_mr lastafr_mi contracep contracep_mr contracep_mi wbl wbl_mr wbl_mi hcicountry edugov edugov_mr edugov_mi healthgov healthgov_mi healthgov_mr socprotgov socprotgov_mr socprotgov_mi difhcipred drm drm_mr drm_mi difdrmpred lastcpia_hr lastcpia_hr_mr lastcpia_hr_mi unregpop unregpop_mr unregpop_mi lasttime_nostu_rep lasttime_hlo_mf_rep dpohc wep hdportfolio_share eduportfolio_share hnpportfolio_share spjportfolio_share pipeline_hd_share pipeline_edu_share pipeline_hnp_share pipeline_spj_share do_performance_hd  do_performance_edu do_performance_hnp do_performance_spj ip_performance_hd  ip_performance_edu ip_performance_hnp ip_performance_spj disburratio_hd disburratio_edu disburratio_hnp disburratio_spj  avgsize_hd avgsize_edu avgsize_hnp avgsize_spj crossgpshare_hd crossgpshare_edu crossgpshare_hnp crossgpshare_spj 
*save relevant_variables_3, replace
*restore
	
	
	

	

	












