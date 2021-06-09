Analysis of PUMS data

***to produce person level estimates use appropriate weighting [fw=pwgtp] 


***///generating variable for pumas in DFW metro area:
recode puma (1901/1907=1)(2001/2006=1)(2301/2322=1)///
	(2501/2516=1)(else=0), gen(metrodfw)
	

	
***///setting race variables
*asian indian alone
recode rac3p (004=1)(else=0), gen(asianindian)
*white alone
recode rac3p (001=1)(else=0), gen(white)
*african american
recode rac3p (002=1)(else=0), gen(africanamerican)


***///Wages or salary
**wagp is the variable indicating wages or salary income in the past 12 months
	mean(wagp) [fw=pwgtp]
	mean(wagp) if asianindian==1 [fw=pwgtp]
	mean(wagp) if white==1 [fw=pwgtp]
	mean(wagp) if africanamerican==1 [fw=pwgtp]


***///Field of study
**fod1p & fod2p are the variables identifying the field of study for bachelor's degree
	tab fod1p if asianindian==1 [fw=pwgtp]
	tab fod1p if white==1 [fw=pwgtp]
	tab fod1p if africanamerican==1 [fw=pwgtp]

***///Educational attainment
** SCHL is the educational attainment variables
	Master's degree or higher includes values of schl>=22
	gen ms_higher=0
	replace ms_higher=1 if schl>=22
	tab ms_higher if asianindian==1 [fw=pwgtp]
	tab ms_higher if white==1 [fw=pwgtp]
	tab ms_higher if africanamerican==1 [fw=pwgtp]
	
***///Occupation
** occp is the occupation variables
	tab occp if asianindian==1 [fw=pwgtp]
	tab occp is white==1 [fw=pwgtp]
	tab occp if africanamerican==1 [fw=pwgtp]
	
***///Class of worker
** cow is the variable for class of worker	
	tab cow if asianindian==1 [fw=pwgtp]
	tab cow if white==1 [fw=pwgtp]
	tab cow if africanamerican==1 [fw=pwgtp]
	
	
	
