
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

mycensuskey <- ""

## This is the year you are collecting census data for.
## In this instance I am using ACS 2007-2011, 5-year estimates. 

myvintage <- 2012


## List of Census APIs assigned to a variable. 

API <- listCensusApis()  

## List of variables avaialable for selected API, also assigned to a variable.


Variables <- listCensusMetadata(name = "acs5", vintage = myvintage)  


## List of available geographies assigned to a variable

Geography <- listCensusMetadata(name = "acs5", vintage = myvintage,type = "g") 

## Load a State/County Fips crosswalk, just for reference (attached to email). 

State_County_Fips <- read_csv("M:/Test R/State & County Fips.csv") 

cat("\014") 

#---------------------------------------------------------------------------------------------------------------------

# 
# Vars_List <- c("B15002_001E","B15002_002E","B15002_003E","B15002_004E","B15002_005E","B15002_006E","B15002_007E",
#                "B15002_008E","B15002_009E","B15002_010E","B15002_011E","B15002_012E","B15002_013E","B15002_014E",
#                "B15002_015E","B15002_016E","B15002_017E","B15002_018E","B15002_019E","B15002_020E","B15002_021E","B15002_022E",
#                "B15002_023E","B15002_024E","B15002_025E","B15002_026E","B15002_027E","B15002_028E","B15002_029E","B15002_030E",
#                "B15002_031E","B15002_032E","B15002_033E","B15002_034E","B15002_035E")
# 
# Vars_List <-c("B17001_001E","B17001_002E")
# 
# Vars_List <-c("C24010_020E","C24010_022E","C24010_024E","C24010_025E","C24010_026E","C24010_027E","C24010_031E","C24010_032E",
#               "C24010_033E","C24010_034E","C24010_056E","C24010_058E","C24010_060E","C24010_061E","C24010_062E","C24010_063E",
#               "C24010_067E","C24010_068E","C24010_069E","C24010_071E","C24010_001E")
# 
# Vars_List <-c("B25071_001E")
# 
# Vars_List <-c("B19013_001E")
# 
# Vars_List<-c("B25014_001E","B25014_002E","B25014_008E")
# 
# Vars_List <-c("B25107_001E")
# 
# Vars_List<-c("B23001_007E","B23001_014E","B23001_021E","B23001_028E","B23001_035E","B23001_042E","B23001_049E",
#              "B23001_056E","B23001_063E","B23001_070E","B23001_075E","B23001_080E","B23001_085E",
#              
#              "B23001_093E","B23001_100E","B23001_107E","B23001_114E","B23001_121E","B23001_128E", "B23001_135E","B23001_142E",
#              "B23001_149E","B23001_156E","B23001_161E","B23001_166E","B23001_171E",
#              
#              "B23001_008E","B23001_015E","B23001_022E","B23001_029E","B23001_036E","B23001_043E","B23001_050E","B23001_057E",
#              "B23001_064E","B23001_071E", "B23001_076E","B23001_081E","B23001_086E",
#              
#              "B23001_094E","B23001_101E","B23001_108E","B23001_115E","B23001_122E","B23001_129E","B23001_136E","B23001_143E",
#              "B23001_150E","B23001_157E","B23001_162E","B23001_167E","B23001_172E"
# )
# 
# Vars_List<-c("C17002_007E","C17002_008E","C17002_003E","C17002_004E","C17002_005E","C17002_006E","C17002_001E","C17002_002E")
# Vars_List<-c("B23025_001E","B23025_002E","B23025_003E","B23025_004E","B23025_005E","B23025_006E","B23025_007E")
# 
# Vars_List<-c("B25077_001E")
# 
# Vars_List<-c("B01003_001E")



Vars_List<-c("B25064_001E","B01003_001E","B15002_001E","B15002_002E","B15002_003E","B15002_004E","B15002_005E","B15002_006E","B15002_007E",
             "B15002_008E","B15002_009E","B15002_010E","B15002_011E","B15002_012E","B15002_013E","B15002_014E",
             "B15002_015E","B15002_016E","B15002_017E","B15002_018E","B15002_019E","B15002_020E","B15002_021E","B15002_022E",
             "B15002_023E","B15002_024E","B15002_025E","B15002_026E","B15002_027E","B15002_028E","B15002_029E","B15002_030E",
             "B15002_031E","B15002_032E","B15002_033E","B15002_034E","B15002_035E","B17001_001E","B17001_002E","C24010_020E",
             "C24010_022E","C24010_024E","C24010_025E","C24010_026E","C24010_027E","C24010_031E","C24010_032E",
             "C24010_033E","C24010_034E","C24010_056E","C24010_058E","C24010_060E","C24010_061E","C24010_062E","C24010_063E",
             "C24010_067E","C24010_068E","C24010_069E","C24010_071E","C24010_001E","B25071_001E","B19013_001E","B25014_001E","B25014_002E","B25014_008E","B25107_001E",
             "B23001_007E","B23001_014E","B23001_021E","B23001_028E","B23001_035E","B23001_042E","B23001_049E",
             "B23001_056E","B23001_063E","B23001_070E","B23001_075E","B23001_080E","B23001_085E",
             
             "B23001_093E","B23001_100E","B23001_107E","B23001_114E","B23001_121E","B23001_128E", "B23001_135E","B23001_142E",
             "B23001_149E","B23001_156E","B23001_161E","B23001_166E","B23001_171E",
             
             "B23001_008E","B23001_015E","B23001_022E","B23001_029E","B23001_036E","B23001_043E","B23001_050E","B23001_057E",
             "B23001_064E","B23001_071E", "B23001_076E","B23001_081E","B23001_086E",
             
             "B23001_094E","B23001_101E","B23001_108E","B23001_115E","B23001_122E","B23001_129E","B23001_136E","B23001_143E",
             "B23001_150E","B23001_157E","B23001_162E","B23001_167E","B23001_172E",
             
             "B23025_001E","B23025_002E","B23025_003E","B23025_004E","B23025_005E","B23025_006E","B23025_007E", "B25077_001E",
             
             "C17002_007E","C17002_008E","C17002_003E","C17002_004E","C17002_005E","C17002_006E","C17002_001E","C17002_002E"
             )




#----------------------------------------------------------------------------------------------------------------------
#Block Groups

#CA blockgroups
CA <- subset(State_County_Fips, State_County_Fips$State_Fips==06)

CA_BlockGroups <- NULL

for (state_fips in CA$State_Fips){
  for (county_fips in CA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    CA_BlockGroups  <- rbind(CA_BlockGroups , df)
    
    if (state_fips == 06& county_fips==115 ) { stop("Let's break out!") }
    
  }
}
write.csv(CA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\CABG_var2010.csv")
#----------------------------------------------------------------------------------------------------------------------

#FL blcokgroups

FL <- subset(State_County_Fips, State_County_Fips$State_Fips==12)

FL_BlockGroups <- NULL

for (state_fips in FL$State_Fips){
  for (county_fips in FL$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    FL_BlockGroups  <- rbind(FL_BlockGroups , df)
    
    if (state_fips == 12& county_fips==133 ) { stop("Let's break out!") }
    
  }
}
write.csv(FL_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\FLBG_var2010.csv")


#----------------------------------------------------------------------------------------------------------------------

#GA blcokgroups

GA <- subset(State_County_Fips, State_County_Fips$State_Fips==13)

GA_BlockGroups <- NULL

for (state_fips in GA$State_Fips){
  for (county_fips in GA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    GA_BlockGroups  <- rbind(GA_BlockGroups , df)
    
    if (state_fips == 13& county_fips==321 ) { stop("Let's break out!") }
    
  }
}
write.csv(GA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\GABG_var2010.csv")

#----------------------------------------------------------------------------------------------------------------------

#LA blcokgroups

LA <- subset(State_County_Fips, State_County_Fips$State_Fips==22)

LA_BlockGroups <- NULL

for (state_fips in LA$State_Fips){
  for (county_fips in LA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    LA_BlockGroups  <- rbind(LA_BlockGroups , df)
    
    if (state_fips == 22& county_fips==127 ) { stop("Let's break out!") }
    
  }
}
write.csv(LA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\LABG_var2010.csv")


#----------------------------------------------------------------------------------------------------------------------

#NJ blcokgroups

NJ <- subset(State_County_Fips, State_County_Fips$State_Fips==34)

NJ_BlockGroups <- NULL

for (state_fips in NJ$State_Fips){
  for (county_fips in NJ$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    NJ_BlockGroups  <- rbind(NJ_BlockGroups , df)
    
    if (state_fips == 34& county_fips==041 ) { stop("Let's break out!") }
    
  }
}
write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\NJBG_var2010.csv")
#----------------------------------------------------------------------------------------------------------------------

#TX blcokgroups

TX <- subset(State_County_Fips, State_County_Fips$State_Fips==48)

TX_BlockGroups <- NULL

for (state_fips in TX$State_Fips){
  for (county_fips in TX$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    TX_BlockGroups  <- rbind(TX_BlockGroups , df)
    
    if (state_fips == 48& county_fips==507 ) { stop("Let's break out!") }
    
  }
}
write.csv(TX_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\TXBG_var2010.csv")
#----------------------------------------------------------------------------------------------------------------------

#MI blcokgroups

 MI<- subset(State_County_Fips, State_County_Fips$State_Fips==26)

MI_BlockGroups <- NULL

for (state_fips in MI$State_Fips){
  for (county_fips in MI$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "acs5", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    MI_BlockGroups  <- rbind(MI_BlockGroups , df)
    
    if (state_fips == 26& county_fips==165 ) { stop("Let's break out!") }
    
  }
}
write.csv(MI_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\MIBG_var2010.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------

## Census Tract 
#CA
CA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:06 + county:*") ## Fips code: State & County 


write.csv(CA_Tracts,file = "M:\\RESPOND\\2010\\CT\\CACT_var2010.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------

#FL
FL_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:12 + county:*") ## Fips code: State & County 


write.csv(FL_Tracts,file = "M:\\RESPOND\\2010\\CT\\FLCT_var2010.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#GA
GA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:13 + county:*") ## Fips code: State & County 


write.csv(GA_Tracts,file = "M:\\RESPOND\\2010\\CT\\GACT_var2010.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#LA
LA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:22 + county:*") ## Fips code: State & County 


write.csv(LA_Tracts,file = "M:\\RESPOND\\2010\\CT\\LACT_var2010.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------


#NJ
NJ_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:34 + county:*") ## Fips code: State & County 


write.csv(NJ_Tracts,file = "M:\\RESPOND\\2010\\CT\\NJCT_var2010.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------


#TX
TX_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:48 + county:*") ## Fips code: State & County 


write.csv(TX_Tracts,file = "M:\\RESPOND\\2010\\CT\\TXCT_var2010.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------


#MI
MI_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:26 + county:*") ## Fips code: State & County 


write.csv(MI_Tracts,file = "M:\\RESPOND\\2010\\CT\\MICT_var2010.csv")


