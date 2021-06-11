Analysis of PUMS data

***to produce person level estimates use appropriate weighting [fw=pwgtp]
***Survey Set the data to produce more accurate standard errors.

svyset [pw=pwgtp], sdr(pwgtp1-pwgtp80) vce(sdr)

***///generating variable for pumas in DFW metro area:
***Note MetroDFW is already defined in our PUMS file.
/*recode puma (1901/1907=1)(2001/2006=1)(2301/2322=1)///
	(2501/2516=1)(else=0), gen(metrodfw)*/
	
***keeping only the observations in metrodfw and for 2019
keep if metrodfw==1 & year==2019

	
***///setting race variables
***Race Variables are already defined. Need to drop before recreating
drop white
*asian indian alone
recode rac3p (004=1)(else=0), gen(asianindian)
*white alone
recode rac3p (001=1)(else=0), gen(white)
*african american
recode rac3p (002=1)(else=0), gen(africanamerican)

*create a race comparison variable for races of interest
	la def racecomp 1 "Asian Indian Alone" 2 "White Alone" 3 "Black Alone" 4 "All Other"
	recode rac3p (4=1)(1=2)(2=3)(.=.)(else=4), gen(racecomp)
	la val racecomp racecomp
	la var racecomp "Racial Group"

***///Wages or salary
**wagp is the variable indicating wages or salary income in the past 12 months
	svy: mean wagp, over(racecomp)
	/*mean(wagp) if asianindian==1 [fw=pwgtp]
	mean(wagp) if white==1 [fw=pwgtp]*/

***///Field of study
**fod1p & fod2p are the variables identifying the field of study for bachelor's degree
**fod1p has too many categories. Let's Collapse Them
	tostring fod1p, gen(fod1ps)
	gen fodcol = ustrleft(fod1ps, 2)
	la def degree 11 Agriculture 13 "Environmental Science" 14 Architecture ///
		15 "Ethnic/Civilization Studies" 19 Communications 20 "Comm Tech" ///
		21 "Computer Science" 22 "Cosmetology and Cullinary Arts" ///
		23 Education 24 Engineering 25 "Engineering Technology" ///
		26 Languages 29 "Family and Consumer Science" 32 "Legal Studies" ///
		33 English 34 Humanities 35 "Library Science" 36 Biology ///
		37 Mathematics 38 "Military Technologies" 40 "Interdisciplinary Studies" ///
		41 "Physical Fitness" 48 "Philosophy and Religion" 49 "Theology" ///
		50 "Physical Sciences" 51 Nuclear 52 Psychology 53 "Criminal Justice and Fire" ///
		54 "Public Administration" 55 "Social Science" 56 Construction ///
		57 "Electrical and Mechanical" 59 "Transportation Science" ///
		60 "Fine Arts" 61 "Medical and Health" 62 Business 64 History
	destring fodcol, replace
	la val fodcol degree
	la var fodcol "Field of Degree"
	svy: prop fodcol, over(racecomp)
	/*svy: tab2 fod1p racecomp, col nof
	tab fod1p if white==1 [fw=pwgtp]
	tab fod1p if africanamerican==1 [fw=pwgtp]*/

***///Educational attainment
** SCHL is the educational attainment variable
** We created a recoded educational attainment variable with labels - edattain
	/*Master's degree or higher includes values of schl>=22
	gen ms_higher=0
	replace ms_higher=1 if schl>=22
	tab ms_higher if asianindian==1 [fw=pwgtp]
	tab ms_higher if white==1 [fw=pwgtp]
	tab ms_higher if africanamerican==1 [fw=pwgtp]*/
	svy: prop edattain, over(racecomp)
	
***///Occupation
** occp is the occupation variable
** way to many categories. Let's create a new collapsed variable.
	la def occupation 1 "Management Occupations" ///
		2 "Business and Financial Operations Occupations" ///
		3 "Computer and Mathematical Occupations" ///
		4 "Architecture and Engineering Occupations" ///
		5 "Life, Physical, and Social Science Occupations" ///
		6 "Community and Social Service Occupations" ///
		7 "Legal Occupations" ///
		8 "Educational Instruction, and Library Occupations" ///
		9 "Arts, Design, Entertainment, Sports, and Media Occupations" ///
		10 "Healthcare Practitioners and Technical Occupations" ///
		11 "Healthcare Support Occupations" ///
		12 "Protective Service Occupations" ///
		13 "Food Preparation and Serving Related Occupations" ///
		14 "Building and Grounds Cleaning and Maintenance Occupations" ///
		15 "Personal Care and Service Occupations" ///
		16 "Sales and Related Occupations" ///
		17 "Office and Administrative Support Occupations" ///
		18 "Farming, Fishing, and Forestry Occupations" ///
		19 "Construction and Extraction Occupations" ///
		20 "Installation, Maintenance, and Repair Occupations" ///
		21 "Production Occupations" ///
		22 "Transportation Occupations" ///
		23 "Material Moving Occupations" ///
		24 "Military Specific Occupations"
	recode occp (0010/0440=1) (0500/0960=2) (1005/1240=3) (1305/1560=4) ///
		(1600/1980=5) (2001/2060=6) (2100/2180=7) (2205/2555=8) (2600/2970=9) ///
		(3000/3550=10) (3601/3655=11) (3700/3960=12) (4000/4160=13) (4200/4255=14) ///
		(4330/4655=15) (4700/4965=16) (5000/5940=17) (6005/6130=18) (6200/6950=19) ///
		(7000/7640=20) (7700/8990=21) (9005/9430=22) (9510/9760=23) (9800/9830=24), ///
		gen(occpcol)
	la val occpcol occupation
	la var occpcol Occupation
	/*tab occp if asianindian==1 [fw=pwgtp]
	tab occp is white==1 [fw=pwgtp]
	tab occp if africanamerican==1 [fw=pwgtp]*/
	svy: prop occpcol, over(racecomp)
	
***///Class of worker
** cow is the variable for class of worker
	la def cow 1 "Employee of a private for-profit company or business for pay" 2 "Employee of a private not-for-profit, tax-exempt, or charitable organization" ///
		3 "Local government employee" 4 "State government employee" 5 "Federal government employee" 6 "Self-employed in own not unincorporated business" ///
		7 "Self-employed in own incorporated business" 8 "Working without pay in family business or farm" ///
		9 "Unemployed and last worked 5 years ago or earlier or never worked"
	la var cow cow
	/*tab cow if asianindian==1 [fw=pwgtp]
	tab cow if white==1 [fw=pwgtp]
	tab cow if africanamerican==1 [fw=pwgtp]*/
	svy: prop cow, over(racecomp)
