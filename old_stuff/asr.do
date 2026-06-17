use "C:\Users\Omar Lizardo\Google Drive\MISC DATA SOURCES\GSS\2002.dta", clear

* ssc install ipf

*/generating culture scale*/
for var  visitart gomusic seemovie readfict popmusic drama dance : recode X 2/8=0
for var  visitart gomusic seemovie readfict popmusic drama dance : drop if X==.
gen cult=seemovie+popmusic+readfict+visitart+gomusic

*/recoding variables*/
recode cult 0/1=1 2/3=2 4/5=3,g(cultrec)
recode incom16 1/2=1 3=2 4/5=3 8=. 
recode numcntct 0/10=1 11/25=2 26/500=3 998=.,g(netrec)

*/labeling variables*/
lab def inc 1 "below average" 2 "average" 3 "above average"
lab val incom16 inc
lab def lmh 1 low 2 medium 3 high
lab val cultrec lmh
lab val netrec lmh

/*display three-way table*/
table incom16 cultrec netrec

*/fitting log-linear models*/
for var incom16 netrec cultrec : drop if X==. /*making sure there are no missing values*/
gen G2=.
gen gp=.
gen df=.
gen bic=.
local mod1 incom16+netrec+cultrec /*independence*/
local mod2 incom16*netrec+netrec*cultrec /*network model*/
local mod3 incom16*cultrec+cultrec*netrec /*culture conversion*/
local mod4 incom16*cultrec+incom16*netrec  /*spurious association*/
local mod5 incom16*cultrec+incom16*netrec+netrec*cultrec /*no three-way interaction*/
forval i=1/5 {
	qui ipf,fit(`mod`i'')
	replace G=`r(g2)' in `i'
	replace gp=`r(pvg)' in `i'
	replace df=`r(df)' in `i'
	replace bic=`r(g2)'-(log(_N)*`r(df)' ) in `i'
	}
format G gp bic %9.3f
list G gp df bic in 1/5,clean
