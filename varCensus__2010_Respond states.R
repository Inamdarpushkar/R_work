install.packages("descr")
install.packages("DescTools")
library(DescTools)
library(descr)
install.packages("devtools")                      
devtools::install_github("hrecht/censusapi")

## Lines 5 & 6 only need to be run one time, comment them out after so they don't slow you down. 


## Any additional packages can be added to the lib_pack list below:

lib_pack <- c("DescTools","descr","plyr","dplyr","tidyr","sas7bdat","stargazer", "psych","formattable",
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
#BuiltEnvironments
# # Population Density
# Vars_List<-c("01003_001E")

# ##Housing Characteristics
# #Crowding
# Vars_List<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E","B25014_001E")

#Renting
# Vars_List<-c("B25008_003E","B25008_001E")

# #SingleFamilyUnits
# Vars_List<-c("B25024_001E","B25024_002E","B25024_003E")

# #Multiunitstructures
# Vars_List<-c("B25032_008E","B25032_009E","B25032_010E","B25032_001E")

# ## Racial/ethnic composition
# #NotHispanic
# Vars_List<-c("B03002_001E","B03002_002E","B03002_003E","B03002_004E","B03002_005E","B03002_006E","B03002_007E","B03002_008E","B03002_009E","B03002_010E","B03002_011E","B03002_012E",
#"B03002_013E","B03002_014E","B03002_015E","B03002_016E","B03002_017E","B03002_018E","B03002_019E","B03002_020E","B03002_021E")
# 
# Commute
#Aggragate travel time
#%length of time 30,30-44,45-59,60
# # "B08303_001E","B08303_002E","B08303_003E","B08303_004E","B08303_005E","B08303_006E","B08303_007E","B08303_008E","B08303_009E","B08303_010E",
#"B08303_011E","B08303_012E","B08303_013E"

#%worked from home/%walked/%car/%other/%workfromhome
# %Worked from home "B08006_017E"
# %Bicycle "B08006_014E"
# %Walked "B08006_015E"
# %car: "B08006_002E"
# %taximotorcycle%other: "B08006_016E"
# %Total: "B08006_001E"

# # Rural/urban measure
# Vars_List<-c("P005001","P005002","P005003","P005004","P005005","P005006","P005007")


Vars_List<-c("B01003_001E","B08006_017E","B08006_014E","B08006_015E","B08006_002E",
             "B08006_016E","B08006_001E","B08303_001E","B08303_002E","B08303_003E",
             "B08303_004E","B08303_005E","B08303_006E","B08303_007E","B08303_008E",
             "B08303_009E","B08303_010E","B08303_011E","B08303_012E","B08303_013E",
             "B25032_008E","B25032_009E","B25032_010E","B25032_001E","B25024_001E",
             "B25024_002E","B25024_003E","B25014_005E","B25014_006E",
             "B25014_007E","B25014_011E","B25014_012E","B25014_013E","B25014_001E","B25008_003E","B25008_001E")



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
df=CA_BlockGroups

#create new df
CA_BG<- as.data.frame(df$state)
colnames(CA_BG)[1] <- "State"
CA_BG$County <- df$county
CA_BG$Tract <- df$tract
CA_BG$BG<-df$block_group



##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
CA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#CA_BG$Qcrowding<- CutQ(CA_BG$crowding, 
 #                                breaks = quantile(CA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
CA_BG$renting<-df$B25008_003E/df$B25008_001E

# CA_BG$Qrenting<- CutQ(CA_BG$renting, 
#                       breaks = quantile(CA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
CA_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# CA_BG$Qpernonsinglefamilyunits<- CutQ(CA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(CA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
CA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# CA_BG$Qpermoreunits<- CutQ(CA_BG$CA_BG$permoreunits, 
#                                       breaks = quantile(CA_BG$CA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
CA_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# CA_BG$Qperworkedfromhome<- CutQ(CA_BG$perworkedfromhome, 
#                           breaks = quantile(CA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
CA_BG$perwalked<-df$B08006_015E/df$B08006_001E
# CA_BG$Qperwalked<- CutQ(CA_BG$perwalked, 
#                                 breaks = quantile(CA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
CA_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# CA_BG$Qpercar_varn_truck<- CutQ(CA_BG$percar_varn_truck, 
#                         breaks = quantile(CA_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
CA_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# CA_BG$Qpermotorcycle<- CutQ(CA_BG$permotorcycle, 
#                                 breaks = quantile(CA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
CA_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#CA_BG$Qperbicycle<- CutQ(CA_BG$perbicycle, 
#                            breaks = quantile(CA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# CA_BG$Qperbicycle<- CutQ(CA_BG$perbicycle, 
#                             breaks = quantile(CA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

CA_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# CA_BG$Qpertraveltimeless30<- CutQ(CA_BG$pertraveltimeless30, 
#                                    breaks = quantile(CA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# CA_BG$Qpertraveltime30_44<- CutQ(CA_BG$pertraveltime30_44, 
#                                   breaks = quantile(CA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# CA_BG$pertraveltime45_59<- CutQ(CA_BG$pertraveltime45_59, 
#                                  breaks = quantile(CA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# CA_BG$Qpertraveltimemore60<- CutQ(CA_BG$pertraveltimemore60, 
#                                 breaks = quantile(CA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(CA_BlockGroups,file = "M:\\RESPOND\\BG\\CABG_var2000.csv")
write.csv(CA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawCABG_neighborvarsACS2010.csv")
write.csv(CA_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\CABG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------


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
#FL_BlockGroups$Population_densityperSQMI<-FL_BlockGroups$P008001/(as.numeric(FL_BlockGroups$AREALAND)/2589988)
#write.csv(FL_BlockGroups,file = "M:\\RESPOND\\BG\\FLBG_var2000.csv")
#write.csv(FL_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawFLBG_neighborvars2000.csv")
df=FL_BlockGroups

#create new df
FL_BG<- as.data.frame(df$state)
colnames(FL_BG)[1] <- "State"
FL_BG$County <- df$county
FL_BG$Tract <- df$tract
FL_BG$BG<-df$block_group


##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
FL_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#FL_BG$Qcrowding<- CutQ(FL_BG$crowding, 
#                                breaks = quantile(FL_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
FL_BG$renting<-df$B25008_003E/df$B25008_001E

# FL_BG$Qrenting<- CutQ(FL_BG$renting, 
#                       breaks = quantile(FL_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
FL_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# FL_BG$Qpernonsinglefamilyunits<- CutQ(FL_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(FL_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
FL_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# FL_BG$Qpermoreunits<- CutQ(FL_BG$FL_BG$permoreunits, 
#                                       breaks = quantile(FL_BG$FL_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
FL_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# FL_BG$Qperworkedfromhome<- CutQ(FL_BG$perworkedfromhome, 
#                           breaks = quantile(FL_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
FL_BG$perwalked<-df$B08006_015E/df$B08006_001E
# FL_BG$Qperwalked<- CutQ(FL_BG$perwalked, 
#                                 breaks = quantile(FL_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
FL_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# FL_BG$Qpercar_varn_truck<- CutQ(FL_BG$percar_varn_truck, 
#                         breaks = quantile(FL_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
FL_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# FL_BG$Qpermotorcycle<- CutQ(FL_BG$permotorcycle, 
#                                 breaks = quantile(FL_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
FL_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#FL_BG$Qperbicycle<- CutQ(FL_BG$perbicycle, 
#                            breaks = quantile(FL_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# FL_BG$Qperbicycle<- CutQ(FL_BG$perbicycle, 
#                             breaks = quantile(FL_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

FL_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# FL_BG$Qpertraveltimeless30<- CutQ(FL_BG$pertraveltimeless30, 
#                                    breaks = quantile(FL_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# FL_BG$Qpertraveltime30_44<- CutQ(FL_BG$pertraveltime30_44, 
#                                   breaks = quantile(FL_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# FL_BG$pertraveltime45_59<- CutQ(FL_BG$pertraveltime45_59, 
#                                  breaks = quantile(FL_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# FL_BG$Qpertraveltimemore60<- CutQ(FL_BG$pertraveltimemore60, 
#                                 breaks = quantile(FL_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(FL_BlockGroups,file = "M:\\RESPOND\\BG\\FLBG_var2000.csv")
write.csv(FL_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawFLBG_neighborvarsACS2010.csv")
write.csv(FL_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\FLBG_neighborvarsACS2010.csv")


#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------



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
df=GA_BlockGroups

#create new df
GA_BG<- as.data.frame(df$state)
colnames(GA_BG)[1] <- "State"
GA_BG$County <- df$county
GA_BG$Tract <- df$tract
GA_BG$BG<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
GA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#GA_BG$Qcrowding<- CutQ(GA_BG$crowding, 
#                                breaks = quantile(GA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
GA_BG$renting<-df$B25008_003E/df$B25008_001E

# GA_BG$Qrenting<- CutQ(GA_BG$renting, 
#                       breaks = quantile(GA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
GA_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# GA_BG$Qpernonsinglefamilyunits<- CutQ(GA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(GA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
GA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# GA_BG$Qpermoreunits<- CutQ(GA_BG$GA_BG$permoreunits, 
#                                       breaks = quantile(GA_BG$GA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
GA_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# GA_BG$Qperworkedfromhome<- CutQ(GA_BG$perworkedfromhome, 
#                           breaks = quantile(GA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
GA_BG$perwalked<-df$B08006_015E/df$B08006_001E
# GA_BG$Qperwalked<- CutQ(GA_BG$perwalked, 
#                                 breaks = quantile(GA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
GA_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# GA_BG$Qpercar_varn_truck<- CutQ(GA_BG$percar_varn_truck, 
#                         breaks = quantile(GA_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
GA_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# GA_BG$Qpermotorcycle<- CutQ(GA_BG$permotorcycle, 
#                                 breaks = quantile(GA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
GA_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#GA_BG$Qperbicycle<- CutQ(GA_BG$perbicycle, 
#                            breaks = quantile(GA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# GA_BG$Qperbicycle<- CutQ(GA_BG$perbicycle, 
#                             breaks = quantile(GA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

GA_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# GA_BG$Qpertraveltimeless30<- CutQ(GA_BG$pertraveltimeless30, 
#                                    breaks = quantile(GA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# GA_BG$Qpertraveltime30_44<- CutQ(GA_BG$pertraveltime30_44, 
#                                   breaks = quantile(GA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# GA_BG$pertraveltime45_59<- CutQ(GA_BG$pertraveltime45_59, 
#                                  breaks = quantile(GA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# GA_BG$Qpertraveltimemore60<- CutQ(GA_BG$pertraveltimemore60, 
#                                 breaks = quantile(GA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(GA_BlockGroups,file = "M:\\RESPOND\\BG\\GABG_var2000.csv")
write.csv(GA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawGABG_neighborvarsACS2010.csv")
write.csv(GA_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\GABG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------


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
df=LA_BlockGroups

#create new df
LA_BG<- as.data.frame(df$state)
colnames(LA_BG)[1] <- "State"
LA_BG$County <- df$county
LA_BG$Tract <- df$tract
LA_BG$BG<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
LA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#LA_BG$Qcrowding<- CutQ(LA_BG$crowding, 
#                                breaks = quantile(LA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
LA_BG$renting<-df$B25008_003E/df$B25008_001E

# LA_BG$Qrenting<- CutQ(LA_BG$renting, 
#                       breaks = quantile(LA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
LA_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# LA_BG$Qpernonsinglefamilyunits<- CutQ(LA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(LA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
LA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# LA_BG$Qpermoreunits<- CutQ(LA_BG$LA_BG$permoreunits, 
#                                       breaks = quantile(LA_BG$LA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
LA_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# LA_BG$Qperworkedfromhome<- CutQ(LA_BG$perworkedfromhome, 
#                           breaks = quantile(LA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
LA_BG$perwalked<-df$B08006_015E/df$B08006_001E
# LA_BG$Qperwalked<- CutQ(LA_BG$perwalked, 
#                                 breaks = quantile(LA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
LA_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# LA_BG$Qpercar_varn_truck<- CutQ(LA_BG$percar_varn_truck, 
#                         breaks = quantile(LA_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
LA_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# LA_BG$Qpermotorcycle<- CutQ(LA_BG$permotorcycle, 
#                                 breaks = quantile(LA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
LA_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#LA_BG$Qperbicycle<- CutQ(LA_BG$perbicycle, 
#                            breaks = quantile(LA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# LA_BG$Qperbicycle<- CutQ(LA_BG$perbicycle, 
#                             breaks = quantile(LA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

LA_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# LA_BG$Qpertraveltimeless30<- CutQ(LA_BG$pertraveltimeless30, 
#                                    breaks = quantile(LA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# LA_BG$Qpertraveltime30_44<- CutQ(LA_BG$pertraveltime30_44, 
#                                   breaks = quantile(LA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# LA_BG$pertraveltime45_59<- CutQ(LA_BG$pertraveltime45_59, 
#                                  breaks = quantile(LA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# LA_BG$Qpertraveltimemore60<- CutQ(LA_BG$pertraveltimemore60, 
#                                 breaks = quantile(LA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(LA_BlockGroups,file = "M:\\RESPOND\\BG\\LABG_var2000.csv")
write.csv(LA_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawLABG_neighborvarsACS2010.csv")
write.csv(LA_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\LABG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

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
df=NJ_BlockGroups

#create new df
NJ_BG<- as.data.frame(df$state)
colnames(NJ_BG)[1] <- "State"
NJ_BG$County <- df$county
NJ_BG$Tract <- df$tract
NJ_BG$BG<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
NJ_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#NJ_BG$Qcrowding<- CutQ(NJ_BG$crowding, 
#                                breaks = quantile(NJ_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
NJ_BG$renting<-df$B25008_003E/df$B25008_001E

# NJ_BG$Qrenting<- CutQ(NJ_BG$renting, 
#                       breaks = quantile(NJ_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
NJ_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# NJ_BG$Qpernonsinglefamilyunits<- CutQ(NJ_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(NJ_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
NJ_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# NJ_BG$Qpermoreunits<- CutQ(NJ_BG$NJ_BG$permoreunits, 
#                                       breaks = quantile(NJ_BG$NJ_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
NJ_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# NJ_BG$Qperworkedfromhome<- CutQ(NJ_BG$perworkedfromhome, 
#                           breaks = quantile(NJ_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
NJ_BG$perwalked<-df$B08006_015E/df$B08006_001E
# NJ_BG$Qperwalked<- CutQ(NJ_BG$perwalked, 
#                                 breaks = quantile(NJ_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
NJ_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# NJ_BG$Qpercar_varn_truck<- CutQ(NJ_BG$percar_varn_truck, 
#                         breaks = quantile(NJ_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
NJ_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# NJ_BG$Qpermotorcycle<- CutQ(NJ_BG$permotorcycle, 
#                                 breaks = quantile(NJ_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
NJ_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#NJ_BG$Qperbicycle<- CutQ(NJ_BG$perbicycle, 
#                            breaks = quantile(NJ_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# NJ_BG$Qperbicycle<- CutQ(NJ_BG$perbicycle, 
#                             breaks = quantile(NJ_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

NJ_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# NJ_BG$Qpertraveltimeless30<- CutQ(NJ_BG$pertraveltimeless30, 
#                                    breaks = quantile(NJ_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# NJ_BG$Qpertraveltime30_44<- CutQ(NJ_BG$pertraveltime30_44, 
#                                   breaks = quantile(NJ_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# NJ_BG$pertraveltime45_59<- CutQ(NJ_BG$pertraveltime45_59, 
#                                  breaks = quantile(NJ_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# NJ_BG$Qpertraveltimemore60<- CutQ(NJ_BG$pertraveltimemore60, 
#                                 breaks = quantile(NJ_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\BG\\NJBG_var2000.csv")
write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawNJBG_neighborvarsACS2010.csv")
write.csv(NJ_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\NJBG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

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
df=TX_BlockGroups

#create new df
TX_BG<- as.data.frame(df$state)
colnames(TX_BG)[1] <- "State"
TX_BG$County <- df$county
TX_BG$Tract <- df$tract
TX_BG$BG<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
TX_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#TX_BG$Qcrowding<- CutQ(TX_BG$crowding, 
#                                breaks = quantile(TX_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
TX_BG$renting<-df$B25008_003E/df$B25008_001E

# TX_BG$Qrenting<- CutQ(TX_BG$renting, 
#                       breaks = quantile(TX_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
TX_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# TX_BG$Qpernonsinglefamilyunits<- CutQ(TX_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(TX_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
TX_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# TX_BG$Qpermoreunits<- CutQ(TX_BG$TX_BG$permoreunits, 
#                                       breaks = quantile(TX_BG$TX_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
TX_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# TX_BG$Qperworkedfromhome<- CutQ(TX_BG$perworkedfromhome, 
#                           breaks = quantile(TX_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
TX_BG$perwalked<-df$B08006_015E/df$B08006_001E
# TX_BG$Qperwalked<- CutQ(TX_BG$perwalked, 
#                                 breaks = quantile(TX_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
TX_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# TX_BG$Qpercar_varn_truck<- CutQ(TX_BG$percar_varn_truck, 
#                         breaks = quantile(TX_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
TX_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# TX_BG$Qpermotorcycle<- CutQ(TX_BG$permotorcycle, 
#                                 breaks = quantile(TX_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
TX_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#TX_BG$Qperbicycle<- CutQ(TX_BG$perbicycle, 
#                            breaks = quantile(TX_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# TX_BG$Qperbicycle<- CutQ(TX_BG$perbicycle, 
#                             breaks = quantile(TX_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

TX_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# TX_BG$Qpertraveltimeless30<- CutQ(TX_BG$pertraveltimeless30, 
#                                    breaks = quantile(TX_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# TX_BG$Qpertraveltime30_44<- CutQ(TX_BG$pertraveltime30_44, 
#                                   breaks = quantile(TX_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# TX_BG$pertraveltime45_59<- CutQ(TX_BG$pertraveltime45_59, 
#                                  breaks = quantile(TX_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# TX_BG$Qpertraveltimemore60<- CutQ(TX_BG$pertraveltimemore60, 
#                                 breaks = quantile(TX_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(TX_BlockGroups,file = "M:\\RESPOND\\BG\\TXBG_var2000.csv")
write.csv(TX_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawTXBG_neighborvarsACS2010.csv")
write.csv(TX_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\TXBG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
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
# MI_BlockGroups$Population_densityperSQMI<-MI_BlockGroups$P008001/(as.numeric(MI_BlockGroups$AREALAND)/2589988)
# #write.csv(MI_BlockGroups,file = "M:\\RESPOND\\BG\\MIBG_var2000.csv")
# write.csv(MI_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawMIBG_neighborvars2000.csv")

df=MI_BlockGroups

#create new df
MI_BG<- as.data.frame(df$state)
colnames(MI_BG)[1] <- "State"
MI_BG$County <- df$county
MI_BG$Tract <- df$tract
MI_BG$BG<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
MI_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#MI_BG$Qcrowding<- CutQ(MI_BG$crowding, 
#                                breaks = quantile(MI_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
MI_BG$renting<-df$B25008_003E/df$B25008_001E

# MI_BG$Qrenting<- CutQ(MI_BG$renting, 
#                       breaks = quantile(MI_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
MI_BG$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# MI_BG$Qpernonsinglefamilyunits<- CutQ(MI_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(MI_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
MI_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# MI_BG$Qpermoreunits<- CutQ(MI_BG$MI_BG$permoreunits, 
#                                       breaks = quantile(MI_BG$MI_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
MI_BG$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# MI_BG$Qperworkedfromhome<- CutQ(MI_BG$perworkedfromhome, 
#                           breaks = quantile(MI_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
MI_BG$perwalked<-df$B08006_015E/df$B08006_001E
# MI_BG$Qperwalked<- CutQ(MI_BG$perwalked, 
#                                 breaks = quantile(MI_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
MI_BG$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# MI_BG$Qpercar_varn_truck<- CutQ(MI_BG$percar_varn_truck, 
#                         breaks = quantile(MI_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
MI_BG$permotorcycle<-df$B08006_016E/df$B08006_001E
# MI_BG$Qpermotorcycle<- CutQ(MI_BG$permotorcycle, 
#                                 breaks = quantile(MI_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
MI_BG$perbicycle<-df$B08006_014E/df$B08006_001E
#MI_BG$Qperbicycle<- CutQ(MI_BG$perbicycle, 
#                            breaks = quantile(MI_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# MI_BG$Qperbicycle<- CutQ(MI_BG$perbicycle, 
#                             breaks = quantile(MI_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

MI_BG$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# MI_BG$Qpertraveltimeless30<- CutQ(MI_BG$pertraveltimeless30, 
#                                    breaks = quantile(MI_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_BG$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# MI_BG$Qpertraveltime30_44<- CutQ(MI_BG$pertraveltime30_44, 
#                                   breaks = quantile(MI_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# MI_BG$pertraveltime45_59<- CutQ(MI_BG$pertraveltime45_59, 
#                                  breaks = quantile(MI_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_BG$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# MI_BG$Qpertraveltimemore60<- CutQ(MI_BG$pertraveltimemore60, 
#                                 breaks = quantile(MI_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(MI_BlockGroups,file = "M:\\RESPOND\\BG\\MIBG_var2000.csv")
write.csv(MI_BlockGroups,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\rawMIBG_neighborvarsACS2010.csv")
write.csv(MI_BG,file = "M:\\RESPOND\\2010\\BG\\neighborhood_vars\\ACS2010\\MIBG_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

#CA
CA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:06 + county:*") ## Fips code: State & County 

#CA_Tracts$Population_densityperSQMI<-CA_Tracts$P008001/(as.numeric(CA_Tracts$AREALAND)/2589988)
#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
#write.csv(CA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawCACT_neighborvars2000.csv")

df=CA_Tracts

#create new df
CA_CT<- as.data.frame(df$state)
colnames(CA_CT)[1] <- "State"
CA_CT$County <- df$county
CA_CT$Tract <- df$tract
CA_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
CA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)



#CA_CT$Qcrowding<- CutQ(CA_CT$crowding, 
#                                breaks = quantile(CA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
CA_CT$renting<-df$B25008_003E/df$B25008_001E

# CA_CT$Qrenting<- CutQ(CA_CT$renting, 
#                       breaks = quantile(CA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
CA_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# CA_CT$Qpernonsinglefamilyunits<- CutQ(CA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(CA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
CA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# CA_CT$Qpermoreunits<- CutQ(CA_CT$CA_CT$permoreunits, 
#                                       breaks = quantile(CA_CT$CA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
CA_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# CA_CT$Qperworkedfromhome<- CutQ(CA_CT$perworkedfromhome, 
#                           breaks = quantile(CA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
CA_CT$perwalked<-df$B08006_015E/df$B08006_001E
# CA_CT$Qperwalked<- CutQ(CA_CT$perwalked, 
#                                 breaks = quantile(CA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
CA_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# CA_CT$Qpercar_varn_truck<- CutQ(CA_CT$percar_varn_truck, 
#                         breaks = quantile(CA_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
CA_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# CA_CT$Qpermotorcycle<- CutQ(CA_CT$permotorcycle, 
#                                 breaks = quantile(CA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
CA_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#CA_CT$Qperbicycle<- CutQ(CA_CT$perbicycle, 
#                            breaks = quantile(CA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# CA_CT$Qperbicycle<- CutQ(CA_CT$perbicycle, 
#                             breaks = quantile(CA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

CA_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# CA_CT$Qpertraveltimeless30<- CutQ(CA_CT$pertraveltimeless30, 
#                                    breaks = quantile(CA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# CA_CT$Qpertraveltime30_44<- CutQ(CA_CT$pertraveltime30_44, 
#                                   breaks = quantile(CA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# CA_CT$pertraveltime45_59<- CutQ(CA_CT$pertraveltime45_59, 
#                                  breaks = quantile(CA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# CA_CT$Qpertraveltimemore60<- CutQ(CA_CT$pertraveltimemore60, 
#                                 breaks = quantile(CA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
write.csv(CA_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawCACT_neighborvarsACS2010.csv")
write.csv(CA_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\CACT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

FL_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:12 + county:*") ## Fips code: State & County 

#FL_Tracts$Population_densityperSQMI<-FL_Tracts$P008001/(as.numeric(FL_Tracts$AREALAND)/2589988)
#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
#write.csv(FL_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawFLCT_neighborvars2000.csv")
#write.csv(FL_Tracts,file = "M:\\RESPOND\\CT\\FLCT_var2000.csv")

df=FL_Tracts

#create new df
FL_CT<- as.data.frame(df$state)
colnames(FL_CT)[1] <- "State"
FL_CT$County <- df$county
FL_CT$Tract <- df$tract
FL_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
FL_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#FL_CT$Qcrowding<- CutQ(FL_CT$crowding, 
#                                breaks = quantile(FL_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
FL_CT$renting<-df$B25008_003E/df$B25008_001E

# FL_CT$Qrenting<- CutQ(FL_CT$renting, 
#                       breaks = quantile(FL_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
FL_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# FL_CT$Qpernonsinglefamilyunits<- CutQ(FL_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(FL_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
FL_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# FL_CT$Qpermoreunits<- CutQ(FL_CT$FL_CT$permoreunits, 
#                                       breaks = quantile(FL_CT$FL_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
FL_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# FL_CT$Qperworkedfromhome<- CutQ(FL_CT$perworkedfromhome, 
#                           breaks = quantile(FL_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
FL_CT$perwalked<-df$B08006_015E/df$B08006_001E
# FL_CT$Qperwalked<- CutQ(FL_CT$perwalked, 
#                                 breaks = quantile(FL_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
FL_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# FL_CT$Qpercar_varn_truck<- CutQ(FL_CT$percar_varn_truck, 
#                         breaks = quantile(FL_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
FL_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# FL_CT$Qpermotorcycle<- CutQ(FL_CT$permotorcycle, 
#                                 breaks = quantile(FL_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
FL_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#FL_CT$Qperbicycle<- CutQ(FL_CT$perbicycle, 
#                            breaks = quantile(FL_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# FL_CT$Qperbicycle<- CutQ(FL_CT$perbicycle, 
#                             breaks = quantile(FL_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

FL_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# FL_CT$Qpertraveltimeless30<- CutQ(FL_CT$pertraveltimeless30, 
#                                    breaks = quantile(FL_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# FL_CT$Qpertraveltime30_44<- CutQ(FL_CT$pertraveltime30_44, 
#                                   breaks = quantile(FL_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# FL_CT$pertraveltime45_59<- CutQ(FL_CT$pertraveltime45_59, 
#                                  breaks = quantile(FL_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# FL_CT$Qpertraveltimemore60<- CutQ(FL_CT$pertraveltimemore60, 
#                                 breaks = quantile(FL_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(FL_Tracts,file = "M:\\RESPOND\\CT\\FLCT_var2000.csv")
write.csv(FL_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawFLCT_neighborvarsACS2010.csv")
write.csv(FL_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\FLCT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------


#GA
GA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:13 + county:*") ## Fips code: State & County 

#GA_Tracts$Population_densityperSQMI<-GA_Tracts$P008001/(as.numeric(GA_Tracts$AREALAND)/2589988)
#write.csv(GA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawGACT_neighborvars2000.csv")
#write.csv(GA_Tracts,file = "M:\\RESPOND\\CT\\GACT_var2000.csv")

df=GA_Tracts

#create new df
GA_CT<- as.data.frame(df$state)
colnames(GA_CT)[1] <- "State"
GA_CT$County <- df$county
GA_CT$Tract <- df$tract
GA_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
GA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#GA_CT$Qcrowding<- CutQ(GA_CT$crowding, 
#                                breaks = quantile(GA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
GA_CT$renting<-df$B25008_003E/df$B25008_001E

# GA_CT$Qrenting<- CutQ(GA_CT$renting, 
#                       breaks = quantile(GA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
GA_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# GA_CT$Qpernonsinglefamilyunits<- CutQ(GA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(GA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
GA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# GA_CT$Qpermoreunits<- CutQ(GA_CT$GA_CT$permoreunits, 
#                                       breaks = quantile(GA_CT$GA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
GA_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# GA_CT$Qperworkedfromhome<- CutQ(GA_CT$perworkedfromhome, 
#                           breaks = quantile(GA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
GA_CT$perwalked<-df$B08006_015E/df$B08006_001E
# GA_CT$Qperwalked<- CutQ(GA_CT$perwalked, 
#                                 breaks = quantile(GA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
GA_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# GA_CT$Qpercar_varn_truck<- CutQ(GA_CT$percar_varn_truck, 
#                         breaks = quantile(GA_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
GA_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# GA_CT$Qpermotorcycle<- CutQ(GA_CT$permotorcycle, 
#                                 breaks = quantile(GA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
GA_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#GA_CT$Qperbicycle<- CutQ(GA_CT$perbicycle, 
#                            breaks = quantile(GA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# GA_CT$Qperbicycle<- CutQ(GA_CT$perbicycle, 
#                             breaks = quantile(GA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

GA_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# GA_CT$Qpertraveltimeless30<- CutQ(GA_CT$pertraveltimeless30, 
#                                    breaks = quantile(GA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# GA_CT$Qpertraveltime30_44<- CutQ(GA_CT$pertraveltime30_44, 
#                                   breaks = quantile(GA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# GA_CT$pertraveltime45_59<- CutQ(GA_CT$pertraveltime45_59, 
#                                  breaks = quantile(GA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# GA_CT$Qpertraveltimemore60<- CutQ(GA_CT$pertraveltimemore60, 
#                                 breaks = quantile(GA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(GA_Tracts,file = "M:\\RESPOND\\CT\\GACT_var2000.csv")
write.csv(GA_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawGACT_neighborvarsACS2010.csv")
write.csv(GA_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\GACT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
LA_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:22 + county:*") ## Fips code: State & County 

#LA_Tracts$Population_densityperSQMI<-LA_Tracts$P008001/(as.numeric(LA_Tracts$AREALAND)/2589988)
#write.csv(LA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawLACT_neighborvars2000.csv")
#write.csv(LA_Tracts,file = "M:\\RESPOND\\CT\\LACT_var2000.csv")

df=LA_Tracts

#create new df
LA_CT<- as.data.frame(df$state)
colnames(LA_CT)[1] <- "State"
LA_CT$County <- df$county
LA_CT$Tract <- df$tract
LA_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
LA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#LA_CT$Qcrowding<- CutQ(LA_CT$crowding, 
#                                breaks = quantile(LA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
LA_CT$renting<-df$B25008_003E/df$B25008_001E

# LA_CT$Qrenting<- CutQ(LA_CT$renting, 
#                       breaks = quantile(LA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
LA_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# LA_CT$Qpernonsinglefamilyunits<- CutQ(LA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(LA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
LA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# LA_CT$Qpermoreunits<- CutQ(LA_CT$LA_CT$permoreunits, 
#                                       breaks = quantile(LA_CT$LA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
LA_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# LA_CT$Qperworkedfromhome<- CutQ(LA_CT$perworkedfromhome, 
#                           breaks = quantile(LA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
LA_CT$perwalked<-df$B08006_015E/df$B08006_001E
# LA_CT$Qperwalked<- CutQ(LA_CT$perwalked, 
#                                 breaks = quantile(LA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
LA_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# LA_CT$Qpercar_varn_truck<- CutQ(LA_CT$percar_varn_truck, 
#                         breaks = quantile(LA_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
LA_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# LA_CT$Qpermotorcycle<- CutQ(LA_CT$permotorcycle, 
#                                 breaks = quantile(LA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
LA_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#LA_CT$Qperbicycle<- CutQ(LA_CT$perbicycle, 
#                            breaks = quantile(LA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# LA_CT$Qperbicycle<- CutQ(LA_CT$perbicycle, 
#                             breaks = quantile(LA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

LA_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# LA_CT$Qpertraveltimeless30<- CutQ(LA_CT$pertraveltimeless30, 
#                                    breaks = quantile(LA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# LA_CT$Qpertraveltime30_44<- CutQ(LA_CT$pertraveltime30_44, 
#                                   breaks = quantile(LA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# LA_CT$pertraveltime45_59<- CutQ(LA_CT$pertraveltime45_59, 
#                                  breaks = quantile(LA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# LA_CT$Qpertraveltimemore60<- CutQ(LA_CT$pertraveltimemore60, 
#                                 breaks = quantile(LA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(LA_Tracts,file = "M:\\RESPOND\\CT\\LACT_var2000.csv")
write.csv(LA_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawLACT_neighborvarsACS2010.csv")
write.csv(LA_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\LACT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

NJ_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:34 + county:*") ## Fips code: State & County 
#NJ_Tracts$Population_densityperSQMI<-NJ_Tracts$P008001/(as.numeric(NJ_Tracts$AREALAND)/2589988)
#write.csv(NJ_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawNJCT_neighborvars2000.csv")

#write.csv(NJ_Tracts,file = "M:\\RESPOND\\CT\\NJCT_var2000.csv")
df=NJ_Tracts

#create new df
NJ_CT<- as.data.frame(df$state)
colnames(NJ_CT)[1] <- "State"
NJ_CT$County <- df$county
NJ_CT$Tract <- df$tract
NJ_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
NJ_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#NJ_CT$Qcrowding<- CutQ(NJ_CT$crowding, 
#                                breaks = quantile(NJ_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
NJ_CT$renting<-df$B25008_003E/df$B25008_001E

# NJ_CT$Qrenting<- CutQ(NJ_CT$renting, 
#                       breaks = quantile(NJ_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
NJ_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# NJ_CT$Qpernonsinglefamilyunits<- CutQ(NJ_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(NJ_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
NJ_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# NJ_CT$Qpermoreunits<- CutQ(NJ_CT$NJ_CT$permoreunits, 
#                                       breaks = quantile(NJ_CT$NJ_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
NJ_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# NJ_CT$Qperworkedfromhome<- CutQ(NJ_CT$perworkedfromhome, 
#                           breaks = quantile(NJ_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
NJ_CT$perwalked<-df$B08006_015E/df$B08006_001E
# NJ_CT$Qperwalked<- CutQ(NJ_CT$perwalked, 
#                                 breaks = quantile(NJ_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
NJ_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# NJ_CT$Qpercar_varn_truck<- CutQ(NJ_CT$percar_varn_truck, 
#                         breaks = quantile(NJ_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
NJ_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# NJ_CT$Qpermotorcycle<- CutQ(NJ_CT$permotorcycle, 
#                                 breaks = quantile(NJ_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
NJ_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#NJ_CT$Qperbicycle<- CutQ(NJ_CT$perbicycle, 
#                            breaks = quantile(NJ_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# NJ_CT$Qperbicycle<- CutQ(NJ_CT$perbicycle, 
#                             breaks = quantile(NJ_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

NJ_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# NJ_CT$Qpertraveltimeless30<- CutQ(NJ_CT$pertraveltimeless30, 
#                                    breaks = quantile(NJ_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# NJ_CT$Qpertraveltime30_44<- CutQ(NJ_CT$pertraveltime30_44, 
#                                   breaks = quantile(NJ_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# NJ_CT$pertraveltime45_59<- CutQ(NJ_CT$pertraveltime45_59, 
#                                  breaks = quantile(NJ_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# NJ_CT$Qpertraveltimemore60<- CutQ(NJ_CT$pertraveltimemore60, 
#                                 breaks = quantile(NJ_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(NJ_Tracts,file = "M:\\RESPOND\\CT\\NJCT_var2000.csv")
write.csv(NJ_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawNJCT_neighborvarsACS2010.csv")
write.csv(NJ_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\NJCT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

TX_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:48 + county:*") ## Fips code: State & County 
#TX_Tracts$Population_densityperSQMI<-TX_Tracts$P008001/(as.numeric(TX_Tracts$AREALAND)/2589988)
#write.csv(TX_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawTXCT_neighborvars2000.csv")

#write.csv(TX_Tracts,file = "M:\\RESPOND\\CT\\TXCT_var2000.csv")
df=TX_Tracts

#create new df
TX_CT<- as.data.frame(df$state)
colnames(TX_CT)[1] <- "State"
TX_CT$County <- df$county
TX_CT$Tract <- df$tract
TX_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
TX_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#TX_CT$Qcrowding<- CutQ(TX_CT$crowding, 
#                                breaks = quantile(TX_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
TX_CT$renting<-df$B25008_003E/df$B25008_001E

# TX_CT$Qrenting<- CutQ(TX_CT$renting, 
#                       breaks = quantile(TX_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
TX_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# TX_CT$Qpernonsinglefamilyunits<- CutQ(TX_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(TX_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
TX_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# TX_CT$Qpermoreunits<- CutQ(TX_CT$TX_CT$permoreunits, 
#                                       breaks = quantile(TX_CT$TX_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
TX_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# TX_CT$Qperworkedfromhome<- CutQ(TX_CT$perworkedfromhome, 
#                           breaks = quantile(TX_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
TX_CT$perwalked<-df$B08006_015E/df$B08006_001E
# TX_CT$Qperwalked<- CutQ(TX_CT$perwalked, 
#                                 breaks = quantile(TX_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
TX_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# TX_CT$Qpercar_varn_truck<- CutQ(TX_CT$percar_varn_truck, 
#                         breaks = quantile(TX_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
TX_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# TX_CT$Qpermotorcycle<- CutQ(TX_CT$permotorcycle, 
#                                 breaks = quantile(TX_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
TX_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#TX_CT$Qperbicycle<- CutQ(TX_CT$perbicycle, 
#                            breaks = quantile(TX_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# TX_CT$Qperbicycle<- CutQ(TX_CT$perbicycle, 
#                             breaks = quantile(TX_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

TX_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# TX_CT$Qpertraveltimeless30<- CutQ(TX_CT$pertraveltimeless30, 
#                                    breaks = quantile(TX_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# TX_CT$Qpertraveltime30_44<- CutQ(TX_CT$pertraveltime30_44, 
#                                   breaks = quantile(TX_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# TX_CT$pertraveltime45_59<- CutQ(TX_CT$pertraveltime45_59, 
#                                  breaks = quantile(TX_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# TX_CT$Qpertraveltimemore60<- CutQ(TX_CT$pertraveltimemore60, 
#                                 breaks = quantile(TX_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(TX_Tracts,file = "M:\\RESPOND\\CT\\TXCT_var2000.csv")
write.csv(TX_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawTXCT_neighborvarsACS2010.csv")
write.csv(TX_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\TXCT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------


#MI
MI_Tracts<- getCensus(name = 'acs5', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:26 + county:*") ## Fips code: State & County 
#MI_Tracts$Population_densityperSQMI<-MI_Tracts$P008001/(as.numeric(MI_Tracts$AREALAND)/2589988)
#write.csv(MI_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawMICT_neighborvars20000.csv")

#write.csv(MI_Tracts,file = "M:\\RESPOND\\CT\\MICT_var2000.csv")
df=MI_Tracts

#create new df
MI_CT<- as.data.frame(df$state)
colnames(MI_CT)[1] <- "State"
MI_CT$County <- df$county
MI_CT$Tract <- df$tract
MI_CT$CT<-df$block_group

##Housing Characteristics
#Crowding
sum_list<-c("B25014_005E","B25014_006E","B25014_007E","B25014_011E","B25014_012E","B25014_013E")
MI_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$B25014_001E)

#MI_CT$Qcrowding<- CutQ(MI_CT$crowding, 
#                                breaks = quantile(MI_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
MI_CT$renting<-df$B25008_003E/df$B25008_001E

# MI_CT$Qrenting<- CutQ(MI_CT$renting, 
#                       breaks = quantile(MI_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
MI_CT$pernonsinglefamilyunits<-(df$B25024_001E-(df$B25024_002E+df$B25024_003E))/df$B25024_001E

# MI_CT$Qpernonsinglefamilyunits<- CutQ(MI_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(MI_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("B25032_008E","B25032_009E","B25032_010E")
MI_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$B25032_001E

# MI_CT$Qpermoreunits<- CutQ(MI_CT$MI_CT$permoreunits, 
#                                       breaks = quantile(MI_CT$MI_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Commute
#worked from home
MI_CT$perworkedfromhome<-df$B08006_017E/df$B08006_001E
# MI_CT$Qperworkedfromhome<- CutQ(MI_CT$perworkedfromhome, 
#                           breaks = quantile(MI_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
MI_CT$perwalked<-df$B08006_015E/df$B08006_001E
# MI_CT$Qperwalked<- CutQ(MI_CT$perwalked, 
#                                 breaks = quantile(MI_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
MI_CT$percar_varn_truck<-df$B08006_002E/df$B08006_001E
# MI_CT$Qpercar_varn_truck<- CutQ(MI_CT$percar_varn_truck, 
#                         breaks = quantile(MI_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
MI_CT$permotorcycle<-df$B08006_016E/df$B08006_001E
# MI_CT$Qpermotorcycle<- CutQ(MI_CT$permotorcycle, 
#                                 breaks = quantile(MI_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
MI_CT$perbicycle<-df$B08006_014E/df$B08006_001E
#MI_CT$Qperbicycle<- CutQ(MI_CT$perbicycle, 
#                            breaks = quantile(MI_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# MI_CT$Qperbicycle<- CutQ(MI_CT$perbicycle, 
#                             breaks = quantile(MI_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other No available in 2010 ACS

#%length of time
sum_list<-c("B08303_003E",
            "B08303_004E","B08303_005E","B08303_006E","B08303_007E")

MI_CT$pertraveltimeless30<-(rowSums(df[,sum_list],na.rm = T))/df$B08303_001E
# MI_CT$Qpertraveltimeless30<- CutQ(MI_CT$pertraveltimeless30, 
#                                    breaks = quantile(MI_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_CT$pertraveltime30_44<-df$B08303_008E/df$B08303_001E
# MI_CT$Qpertraveltime30_44<- CutQ(MI_CT$pertraveltime30_44, 
#                                   breaks = quantile(MI_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$pertraveltime45_59<-df$B08303_011E/df$B08303_001E
# MI_CT$pertraveltime45_59<- CutQ(MI_CT$pertraveltime45_59, 
#                                  breaks = quantile(MI_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_CT$pertraveltimemore60<-(df$B08303_012E+df$B08303_013E)/df$B08303_001E
# MI_CT$Qpertraveltimemore60<- CutQ(MI_CT$pertraveltimemore60, 
#                                 breaks = quantile(MI_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(MI_Tracts,file = "M:\\RESPOND\\CT\\MICT_var2000.csv")
write.csv(MI_Tracts,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\rawMICT_neighborvarsACS2010.csv")
write.csv(MI_CT,file = "M:\\RESPOND\\2010\\CT\\neighborhood_vars\\ACS2010\\MICT_neighborvarsACS2010.csv")

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------










