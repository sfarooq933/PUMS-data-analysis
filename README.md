# PUMS-data-analysis
This file contains the Stata code to produce person-level estimates of various indicators in the DFW metro area.

Data is produced for 3 racial categories: Indian-American, white and African American. 

The indicators looked at include mean wages, fields of study, educational attainment, occupation & class of worker. 


___________________________________________________________________________________________________________________________________________________
A brief note on weights used in the analysis:

To produce correct person-level estimates when you are not concerned about standard errors, use [fw=pwgtp]

To produce correct household-level estimates when you are not concerned about standard errors, use [fw=wgtp] & include the if statement if sporder==1
