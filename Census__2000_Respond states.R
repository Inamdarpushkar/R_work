install.packages("descr")
install.packages("DescTools")
library(DescTools)
library(descr)
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

#---------------------------------------------------------------------------------------------------------------------

# Vars_List <- c("H070001")
# Vars_List<-c("H085001")
# Vars_List<-c("H020001",	"H020002","H020003","H020004","H020005","H020006","H020007","H020008","H020009",	"H020010","H020011","H020012","H020013")
# 
# Vars_List<-c("P037001",	"P037002",	"P037003",	"P037004",	"P037005"	,"P037006",	"P037007",	"P037008",	"P037009",	"P037010",
#              "P037011",	"P037012"	,"P037013",	"P037014",	"P037015",	"P037016",	"P037017",	"P037018",	"P037019",	"P037020",	
#              "P037021",	"P037022"	,"P037023",	"P037024",	"P037025"	,"P037026",	"P037027",	"P037028",	"P037029",	"P037030",	"P037031"	
#              ,"P037032",	"P037033"	,"P037034",	"P037035")
# 
# Vars_List<-c("P050024","P050027","P050028","P050029","P050030","P050031","P050034","P050035","P050041",
# "P050071","P050074","P050075","P050076","P050077","P050078","P050081","P050082","P050088","P050001")
# 
# Vars_List<-c("P052016",	"P052017",	"P052001")
# 
# Vars_List<-c("P052002",	"P052003",	"P052004",	"P052001")
# 
# Vars_List<-c("P053001")
# 
# Vars_List<-c("H070001")
# 
# Vars_List<-c("P087001",	"P087002",	"P087003",	"P087004",	"P087005",	"P087006",	"P087007",	"P087008",	"P087009",
#              "P087010"	,"P087011",	"P087012"	,"P087013"	,"P087014"	,"P087015",	"P087016",	"P087017")
# Vars_List<-c("P087001",	"P087002")
# 
# Vars_List<-("H063001")
# 
# Vars_List<-c("P043001","P043002","P043003","P043004",	"P043005",	"P043006",	"P043007", "P043008","P043009","P043010","P043011",
#              "P043012","P043013","P043014","P043015")
# 
# Vars_List<-c("P088001","P088002","P088003","P088004","P088005","P088006","P088007","P088008","P088009","P088010")

#SES variables
# Vars_List<-c("H070001","H085001","H020001",	"H020002","H020003","H020004","H020005","H020006","H020007","H020008","H020009",	"H020010","H020011","H020012","H020013",
#              "P037001",	"P037002",	"P037003",	"P037004",	"P037005"	,"P037006",	"P037007",	"P037008",	"P037009",	"P037010",
#              "P037011",	"P037012"	,"P037013",	"P037014",	"P037015",	"P037016",	"P037017",	"P037018",	"P037019",	"P037020",	
#              "P037021",	"P037022"	,"P037023",	"P037024",	"P037025"	,"P037026",	"P037027",	"P037028",	"P037029",	"P037030",	"P037031"	
#              ,"P037032",	"P037033"	,"P037034",	"P037035","P050024","P050027","P050028","P050029","P050030","P050031","P050034","P050035","P050041",
#              "P050071","P050074","P050075","P050076","P050077","P050078","P050081","P050082","P050088","P050001","P052016",	"P052017",	"P052001",
#              "P052002",	"P052003",	"P052004",	"P052001","P053001","H070001","P087001",	"P087002",	"P087003",	"P087004",	"P087005",	"P087006",	"P087007",	"P087008",	"P087009",
#              "P087010"	,"P087011",	"P087012"	,"P087013"	,"P087014"	,"P087015",	"P087016",	"P087017","H063001","P043001","P043002","P043003","P043004",	"P043005",	"P043006",	"P043007", "P043008","P043009","P043010","P043011",
#              "P043012","P043013","P043014","P043015","P088001","P088002","P088003","P088004","P088005","P088006","P088007","P088008","P088009","P088010")

#BuiltEnvironments
# # Population Density
# Vars_List<-c("AREALAND","P008001")
# ##Housing Characteristics
# #Crowding
# Vars_List<-c("H020005","H020006","H020007","H020011","H020012","H020013","H020001")
# #Renting
# Vars_List<-c("H007003","H007001")
# #SingleFamilyUnits
# Vars_List<-c("H030001","H030002","H030003")
# #Multiunitstructures
# Vars_List<-c("H030007","H030008","H030009")
# 
# ## Racial/ethnic composition
# #PerWhite,PerBlack,PerAIAN,PerAmericanIndianAlaskaNativeAlone, Asian, 
# Vars_List<-c("P006002","P006001","P006003","P006004","P006005","P006006","P006007","P006008")
# #NotHispanic
# Vars_List<-c("P007001","P007002","P007003","P007004","P007005","P007006","P007007","P007008","P007009",
#              "P007010","P007011","P007012","P007013","P007014","P007015","P007016","P007017")
# 
# Commute
# #Total: Workers 16 years and over,Total: Car, truck, or van:,Total: Motorcycle,Total: Bicycle
# Vars_List<-c("P030001","P030002","P030012","P030013")
#Aggragate travel time
# # P033001,P033002,P033003,P033004,P033005,P033006,P033007,P033008,P033009,P033010,P033011,P033012,P033013
#%worked from home/%walked/%car/%other/%workfromhome
#%length of time 30,30-44,45-59,60
# # P030001, P030002, P030003,P030004,P030005,P030006,P030007,P030008,P030009,P030010,P030011,P030012,P030013,P030014,P030015,P030016,P030017 

# # Rural/urban measure
# Vars_List<-c("P005001","P005002","P005003","P005004","P005005","P005006","P005007")

Vars_List<-c("AREALAND","POP100","P008001","H020005","H020006","H020007","H020011","H020012","H020013","H020001","H007003","H007001",
             "H030001","H030002","H030003","H030007","H030008","H030009","P006002","P006001","P006003","P006004","P006005","P006006","P006007","P006008",
             "P007001","P007002","P007003","P007004","P007005","P007006","P007007","P007008","P007009",
             "P007010","P007011","P007012","P007013","P007014","P007015","P007016","P007017","P030001","P030002","P030003","P030004","P030005",
             "P030006","P030007","P030008","P030009","P030010","P030011","P030012","P030013","P030014","P030015","P030016",
             "P005001","P005002","P005003","P005004","P005005","P005006","P005007","P033001","P033002","P033003","P033004","P033005","P033006","P033007","P033008","P033009","P033010","P033011","P033012","P033013")

#----------------------------------------------------------------------------------------------------------------------
#Block Groups

#CA blockgroups
CA <- subset(State_County_Fips, State_County_Fips$State_Fips==06)

CA_BlockGroups <- NULL

for (state_fips in CA$State_Fips){
  for (county_fips in CA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
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

#Population density
CA_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
CA_BG$Qpopulation_density<- CutQ(CA_BG$population_density, 
                                    breaks = quantile(CA_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
CA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

CA_BG$Qcrowding<- CutQ(CA_BG$crowding, 
                                 breaks = quantile(CA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
CA_BG$renting<-df$H007003/df$H007001

CA_BG$Qrenting<- CutQ(CA_BG$renting, 
                      breaks = quantile(CA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
CA_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

CA_BG$Qpernonsinglefamilyunits<- CutQ(CA_BG$pernonsinglefamilyunits, 
                     breaks = quantile(CA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
CA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

CA_BG$Qpermoreunits<- CutQ(CA_BG$CA_BG$permoreunits, 
                                      breaks = quantile(CA_BG$CA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

CA_BG$perNonhispanic<-df$P007002/df$P007001
CA_BG$QperNonhispanic<- CutQ(CA_BG$perNonhispanic, 
                           breaks = quantile(CA_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_white<-df$P007003/df$P007001
CA_BG$QperNH_white<- CutQ(CA_BG$perNH_white, 
                             breaks = quantile(CA_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_black<-df$P007004/df$P007001
CA_BG$QperNH_black<- CutQ(CA_BG$perNH_black, 
                          breaks = quantile(CA_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_asian<-df$P007006/df$P007001
CA_BG$QperNH_asian<- CutQ(CA_BG$perNH_asian, 
                          breaks = quantile(CA_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_AIAN<-df$P007005/df$P007001
CA_BG$QperNH_AIAN<- CutQ(CA_BG$perNH_AIAN, 
                          breaks = quantile(CA_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_NHPI<-df$P007007/df$P007001
CA_BG$QperNH_NHPI<- CutQ(CA_BG$perNH_NHPI, 
                         breaks = quantile(CA_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_other<-df$P007008/df$P007001
CA_BG$QperNH_other<- CutQ(CA_BG$perNH_other, 
                         breaks = quantile(CA_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perHispanic<-df$P007010/df$P007001
CA_BG$QperHispanic<- CutQ(CA_BG$perHispanic, 
                          breaks = quantile(CA_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
CA_BG$perworkedfromhome<-df$P030016/df$P030001
CA_BG$Qperworkedfromhome<- CutQ(CA_BG$perworkedfromhome, 
                          breaks = quantile(CA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
CA_BG$perwalked<-df$P030014/df$P030001
CA_BG$Qperwalked<- CutQ(CA_BG$perwalked, 
                                breaks = quantile(CA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
CA_BG$percar_varn_truck<-df$P030002/df$P030001
CA_BG$Qpercar_varn_truck<- CutQ(CA_BG$percar_varn_truck, 
                        breaks = quantile(CA_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
CA_BG$permotorcycle<-df$P030012/df$P030001
CA_BG$Qpermotorcycle<- CutQ(CA_BG$permotorcycle, 
                                breaks = quantile(CA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
CA_BG$perbicycle<-df$P030013/df$P030001
CA_BG$Qperbicycle<- CutQ(CA_BG$perbicycle, 
                            breaks = quantile(CA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = TRUE))

#other
CA_BG$perothercommutemeans<-df$P030015<-df$P030001
CA_BG$Qperothercommutemeans<- CutQ(CA_BG$perothercommutemeans, 
                         breaks = quantile(CA_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
CA_BG$pertraveltimeless30<-df$P033002/df$P033001
CA_BG$Qpertraveltimeless30<- CutQ(CA_BG$pertraveltimeless30, 
                                   breaks = quantile(CA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltime30_44<-df$P033005/df$P033001
CA_BG$Qpertraveltime30_44<- CutQ(CA_BG$pertraveltime30_44, 
                                  breaks = quantile(CA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



CA_BG$pertraveltime45_59<-df$P033008/df$P033001
CA_BG$pertraveltime45_59<- CutQ(CA_BG$pertraveltime45_59, 
                                 breaks = quantile(CA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltimemore60<-df$P033011/df$P033001
CA_BG$Qpertraveltimemore60<- CutQ(CA_BG$pertraveltimemore60, 
                                breaks = quantile(CA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
CA_BG$perurbanized<-df$P005002/df$P005001
CA_BG$Qperurbanized<- CutQ(CA_BG$perurbanized, 
                                  breaks = quantile(CA_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perrural<-df$P005005/df$P005001
CA_BG$Qperrural<- CutQ(CA_BG$perrural, 
                          breaks = quantile(CA_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perinsideurbanizedareas<-df$P005003/df$P005001
CA_BG$Qperinsideurbanizedareas<- CutQ(CA_BG$perinsideurbanizedareas, 
                       breaks = quantile(CA_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perinsideurbancluster<-df$P005004/df$P005001
CA_BG$Qperinsideurbancluster<- CutQ(CA_BG$perinsideurbancluster, 
                                      breaks = quantile(CA_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(CA_BlockGroups,file = "M:\\RESPOND\\BG\\CABG_var2000.csv")
write.csv(CA_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawCABG_neighborvars2000.csv")
write.csv(CA_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\CABG_neighborvars2000.csv")
#----------------------------------------------------------------------------------------------------------------------

#FL blcokgroups

FL <- subset(State_County_Fips, State_County_Fips$State_Fips==12)

FL_BlockGroups <- NULL

for (state_fips in FL$State_Fips){
  for (county_fips in FL$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    FL_BlockGroups  <- rbind(FL_BlockGroups , df)
    
    if (state_fips == 12& county_fips==133 ) { stop("Let's break out!") }
    
  }
}
FL_BlockGroups$Population_densityperSQMI<-FL_BlockGroups$P008001/(as.numeric(FL_BlockGroups$AREALAND)/2589988)
#write.csv(FL_BlockGroups,file = "M:\\RESPOND\\BG\\FLBG_var2000.csv")
write.csv(FL_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawFLBG_neighborvars2000.csv")

#----------------------------------------------------------------------------------------------------------------------

#GA blcokgroups

GA <- subset(State_County_Fips, State_County_Fips$State_Fips==13)

GA_BlockGroups <- NULL

for (state_fips in GA$State_Fips){
  for (county_fips in GA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    GA_BlockGroups  <- rbind(GA_BlockGroups , df)
    
    if (state_fips == 13& county_fips==321 ) { stop("Let's break out!") }
    
  }
}
GA_BlockGroups$Population_densityperSQMI<-GA_BlockGroups$P008001/(as.numeric(GA_BlockGroups$AREALAND)/2589988)
#write.csv(GA_BlockGroups,file = "M:\\RESPOND\\BG\\GABG_var2000.csv")
write.csv(GA_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawGABG_neighborvars2000.csv")
#----------------------------------------------------------------------------------------------------------------------

#LA blcokgroups

LA <- subset(State_County_Fips, State_County_Fips$State_Fips==22)

LA_BlockGroups <- NULL

for (state_fips in LA$State_Fips){
  for (county_fips in LA$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    LA_BlockGroups  <- rbind(LA_BlockGroups , df)
    
    if (state_fips == 22& county_fips==127 ) { stop("Let's break out!") }
    
  }
}
LA_BlockGroups$Population_densityperSQMI<-LA_BlockGroups$P008001/(as.numeric(LA_BlockGroups$AREALAND)/2589988)
#write.csv(LA_BlockGroups,file = "M:\\RESPOND\\BG\\LABG_var2000.csv")
write.csv(LA_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawLABG_neighborvars2000.csv")

#----------------------------------------------------------------------------------------------------------------------

#NJ blcokgroups

NJ <- subset(State_County_Fips, State_County_Fips$State_Fips==34)

NJ_BlockGroups <- NULL

for (state_fips in NJ$State_Fips){
  for (county_fips in NJ$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    NJ_BlockGroups  <- rbind(NJ_BlockGroups , df)
    
    if (state_fips == 34& county_fips==041 ) { stop("Let's break out!") }
    
  }
}
NJ_BlockGroups$Population_densityperSQMI<-NJ_BlockGroups$P008001/(as.numeric(NJ_BlockGroups$AREALAND)/2589988)
#write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\BG\\NJBG_var2000.csv")
write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawNJBG_neighborvars2000.csv")
#----------------------------------------------------------------------------------------------------------------------

#TX blcokgroups

TX <- subset(State_County_Fips, State_County_Fips$State_Fips==48)

TX_BlockGroups <- NULL

for (state_fips in TX$State_Fips){
  for (county_fips in TX$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    TX_BlockGroups  <- rbind(TX_BlockGroups , df)
    
    if (state_fips == 48& county_fips==507 ) { stop("Let's break out!") }
    
  }
}
TX_BlockGroups$Population_densityperSQMI<-TX_BlockGroups$P008001/(as.numeric(TX_BlockGroups$AREALAND)/2589988)
#write.csv(TX_BlockGroups,file = "M:\\RESPOND\\BG\\TXBG_var2000.csv")
write.csv(TX_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawTXBG_neighborvars2000.csv")
#----------------------------------------------------------------------------------------------------------------------

#MI blcokgroups

 MI<- subset(State_County_Fips, State_County_Fips$State_Fips==26)

MI_BlockGroups <- NULL

for (state_fips in MI$State_Fips){
  for (county_fips in MI$County_Fips){
    
    
    RIN <- paste0("state:",state_fips," + county:",county_fips)
    
    print(RIN)
    
    df <- getCensus(name = "sf3", vintage = myvintage, key = mycensuskey,
                    vars = Vars_List, region = "block group", regionin = RIN)
    
    MI_BlockGroups  <- rbind(MI_BlockGroups , df)
    
    if (state_fips == 26& county_fips==165 ) { stop("Let's break out!") }
    
  }
}
MI_BlockGroups$Population_densityperSQMI<-MI_BlockGroups$P008001/(as.numeric(MI_BlockGroups$AREALAND)/2589988)
#write.csv(MI_BlockGroups,file = "M:\\RESPOND\\BG\\MIBG_var2000.csv")
write.csv(MI_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawMIBG_neighborvars2000.csv")









#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------

## Census Tract 
#CA
CA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:06 + county:*") ## Fips code: State & County 

CA_Tracts$Population_densityperSQMI<-CA_Tracts$P008001/(as.numeric(CA_Tracts$AREALAND)/2589988)
#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
write.csv(CA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawCACT_neighborvars2000.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------

#FL
FL_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:12 + county:*") ## Fips code: State & County 

FL_Tracts$Population_densityperSQMI<-FL_Tracts$P008001/(as.numeric(FL_Tracts$AREALAND)/2589988)
#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
write.csv(FL_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawFLCT_neighborvars2000.csv")
#write.csv(FL_Tracts,file = "M:\\RESPOND\\CT\\FLCT_var2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#GA
GA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:13 + county:*") ## Fips code: State & County 

GA_Tracts$Population_densityperSQMI<-GA_Tracts$P008001/(as.numeric(GA_Tracts$AREALAND)/2589988)
write.csv(GA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawGACT_neighborvars2000.csv")
#write.csv(GA_Tracts,file = "M:\\RESPOND\\CT\\GACT_var2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#LA
LA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:22 + county:*") ## Fips code: State & County 

LA_Tracts$Population_densityperSQMI<-LA_Tracts$P008001/(as.numeric(LA_Tracts$AREALAND)/2589988)
write.csv(LA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawLACT_neighborvars2000.csv")
#write.csv(LA_Tracts,file = "M:\\RESPOND\\CT\\LACT_var2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------


#NJ
NJ_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:34 + county:*") ## Fips code: State & County 
NJ_Tracts$Population_densityperSQMI<-NJ_Tracts$P008001/(as.numeric(NJ_Tracts$AREALAND)/2589988)
write.csv(NJ_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawNJCT_neighborvars2000.csv")

#write.csv(NJ_Tracts,file = "M:\\RESPOND\\CT\\NJCT_var2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------


#TX
TX_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:48 + county:*") ## Fips code: State & County 
TX_Tracts$Population_densityperSQMI<-TX_Tracts$P008001/(as.numeric(TX_Tracts$AREALAND)/2589988)
write.csv(TX_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawTXCT_neighborvars2000.csv")

#write.csv(TX_Tracts,file = "M:\\RESPOND\\CT\\TXCT_var2000.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------


#MI
MI_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
                      key = mycensuskey, region = "tract", regionin = "state:26 + county:*") ## Fips code: State & County 
MI_Tracts$Population_densityperSQMI<-MI_Tracts$P008001/(as.numeric(MI_Tracts$AREALAND)/2589988)
write.csv(MI_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawMICT_neighborvars20000.csv")

#write.csv(MI_Tracts,file = "M:\\RESPOND\\CT\\MICT_var2000.csv")


