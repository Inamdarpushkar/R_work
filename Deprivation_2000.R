#Percent of total with less than high school
#-1990
#P057003/(P057001-P057007)
#-2000
#(P0370003 + P0370004 + P0370005 +P0370006 + P0370007 +P0370008 + P0370009 +P0370010  + P0370020 +P0370021 
#+P0370022 + P0370023 + P0370024 +P0370025 +P0370026 +P0370027) / P0370001

#Percent of total unemployed
#-1990
#(P0700003+P0700007)/SUM(P0700002+P0700003+P0700006+P0700007)
#-2000
#(P0430007+P0430014)/(P043005+P043012)

#Percent of HH with income below poverty
#-1990
#sum( of P1210001-P1210008)/sum( of P1210001-P1210009)
#-2000
#(P088002+P088003+P088004+P088005+P088006+P088007+P088008+P088009)/P088001


#Percent of HH income < $22,500
#-1990
#P0800001+P0800002+P0800009+P0800008+P0800007/P0800001+P0800002+P0800009+P0800008+P0800007+P0800006+P0800005+P0800004+P0800003
#-2000
#P052002,P052003,P052004,P052005/P052001


#Percent of HH on public assistance
#-1990
#P0950002: No public assistance income
#P0950001: Public assistance income

#-2000
#P064001:Total
#P064003:Total: No public assistance income


#Percent of HH with no car
#-1990
#H0400001: VEHICLES AVAILABLE[2] None
#H0400002: VEHICLES AVAILABLE[2] 1 or more

#-2000
#H044010+H044003: Total Housing Units: No Vehicle available
#H044001: Total Housing Units: vehicles/No vehicle

#------------------------------------------------
#Percent of Unemployed Men
#1990
#P0700002=MALE/LABOR/CIVIL[8] Employed
#P0700003=MALE/LABOR/CIVIL[8] Unemployed

#2000
# P043007: Male Unemployed
# P043005=Total: Male: In labor force: Civilian:
  

#Percent of renter occupied housing units
#-1990
#H0380001:Total: Owner occupied
#H0380002: Total: Renter occupied

#-2000
#H007003: Total: Renter occupied
#H007001: Total: Occupied housing units



#Percent of housing units vacant
#-1990
#Vacant Housing units:H0210001,H0210002,H0210003,H0210003,H0210004,H0210005,H0210006,H0210007,H0210008,H0210009,H0210010
#Owner occupied: H0220001,H0220002,H0220003,H0220003,H0220004,H0220005,H0220006,H0220007,H0220008,H0220009,H0220010
#Renter occupied: "H0220011"

#-2000
#H008001: Total: Vacant housing units
#H020001: Total rental/owner occupied 

#Median value of all owner occupied housing units
#-1990
#H061A001=Median Value Owner-occupied housing units
#-2000
#H085001=Median value Owner-occupied housing units


#Percent of female headed HH with dependent children
#-1990
#P0190006: Female HHer no hsd: No own chld<18 yrs
#P0190005: Female HHer no hsd: With own chld<18 yrs

#-2000
#P017015: Total: Other family: Female householder, no husband present:
#P017016: Total: Other family: Female householder, no husband present: With related children under 18 years:


#Percent of non-Hispanic (NH)blacks.
#-1990
#P0120002/P0010001
#-2000
#P0070004/P0070001


#Percent of residents 65 years and over
#-1990
#P0130027,P0130028,P0130029,P0130030,P0130031/P0130001-P0130031
#-2000
#(P008074,P008075,P008076,P008077,P008078,P008079)+(P008035,P008036,P008037,P008038,P008040)/P008001


#Percent of persons in same residence since 1985

#-1990
#P0430001: RES '85[10] Same house in 1985
#P0430002,P0430003,P0430004,P0430005,P0430006,P0430007,P0430008,P0430009: RES different house in 1985

#-2000
#P024002: Total: Same house in 1995
#P024003: Total: different house in 1995

#------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------

install.packages("devtools")                      
devtools::install_github("hrecht/censusapi")

## Lines 5 & 6 only need to be run one time, comment them out after so they don't slow you down. 


## Any additional packages can be added to the lib_pack list below:

lib_pack <- c("plyr","dplyr","tidyr","sas7bdat","stargazer", "psych","formattable",
              "tidyverse", "foreign", "stringr","rgdal","censusapi","readr")

lapply(lib_pack, require, character.only=TRUE)

cat("\014")

#--------------------------------------------------------------------------------------------------------------------------------------


## 'censusapi' documentation: https://cran.r-project.org/web/packages/censusapi/censusapi.pdf

## Get your own census key here:  https://api.census.gov/data/key_signup.html

mycensuskey <- "aa1c6f90931bb2f61293b949a2ef8312b4ac679e"

## This is the year you are collecting census data for.
## In this instance I am using ACS 2007-2011, 5-year estimates. 

myvintage <- 2000


## List of Census APIs assigned to a variable. 

API <- listCensusApis()  

## List of variables avaialable for selected API, also assigned to a variable.

Variables <- listCensusMetadata(name = "sf3", vintage = myvintage)  


## List of available geographies assigned to a variable

Geography <- listCensusMetadata(name = "sf3", vintage = myvintage,type = "g") 

## Load a State/County Fips crosswalk, just for reference (attached to email). 

State_County_Fips <- read_csv("M:/Test R/State & County Fips.csv") 

cat("\014") 

#2000_deprivation Index vars
Vars_List<-c("P037003","P037004","P037005","P037006","P037007","P037008","P037009","P037010","P037020","P037021","P037022",
              "P037023","P037024","P037025","P037026","P037027","P037001","P043007","P043014","P043005","P043012","P088002","P088003","P088004",
              "P088005","P088006","P088007","P088008","P088009","P088001","P052002","P052003","P052004","P052005","P052001","P064001","P064003","H044001","H044010","H044003",
              "P043007","P043005","H007003","H007003","H007001","H008001","H020001","H085001","P017015","P017016","P007004","P007001","P008074","P008075","P008076","P008077",
              "P008078","P008079","P008035","P008036","P008037","P008038","P008040","P008001","P024002","P024003")




#1990_deprivation Index vars

Vars_List<-c("P0570001","P0570002","P0570003","P0570004","P0570005","P0570006","P0570007","P0700003","P0700004","P0700005","P0700006","P0700007",
             "P1210001","P1210002","P1210003","P1210004","P1210005","P1210006","P1210007","P1210008","P1210009",
             "P0800001","P0800002","P0800009","P0800008","P0800007","P0800001","P0800002","P0800009","P0800008","P0800007","P0800006","P0800005","P0800004","P0800003",
             "P0950001","P0950002","H0400001","H0400002","P0700002","P0700003","H0380001","H0380002","H0210001","H0210002","H0210003","H0210003","H0210004","H0210005","H0210006",
             "H0210007","H0210008","H0210009","H0210010","H0220001","H0220002","H0220003","H0220003","H0220004","H0220005","H0220006","H0220007","H0220008","H0220009","H0220010",
             "H0220011","H061A001","P0120002","P0010001","P0130001","P0130002","P0130003","P0130004","P0130005","P0130006","P0130007","P0130008","P0130009","P0130010",
             "P0130011","P0130012","P0130013","P0130014","P0130015","P0130016","P0130017","P0130018","P0130019","P0130020","P0130021","P0130022","P0130023","P0130024","P0130025",
             "P0130026","P0130027","P0130028","P0130029","P0130030","P0130031","P0430001","P0430002","P0430003","P0430004","P0430005","P0430006","P0430007","P0430008","P0430009","P0190005")



CA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:06 + county:*")


CA_DI_00vars<-CA_Tracts
#--------------------------------------------------------------------------------------------------------------------------------------------------




