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
# CA_BG$Qpopulation_density<- CutQ(CA_BG$population_density, 
#                                     breaks = quantile(CA_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
CA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# CA_BG$Qcrowding<- CutQ(CA_BG$crowding, 
#                                  breaks = quantile(CA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
CA_BG$renting<-df$H007003/df$H007001

# CA_BG$Qrenting<- CutQ(CA_BG$renting, 
#                       breaks = quantile(CA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
CA_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# CA_BG$Qpernonsinglefamilyunits<- CutQ(CA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(CA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
CA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# CA_BG$Qpermoreunits<- CutQ(CA_BG$CA_BG$permoreunits, 
#                                       breaks = quantile(CA_BG$CA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

CA_BG$perNonhispanic<-df$P007002/df$P007001
# CA_BG$QperNonhispanic<- CutQ(CA_BG$perNonhispanic, 
#                            breaks = quantile(CA_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_white<-df$P007003/df$P007001
# CA_BG$QperNH_white<- CutQ(CA_BG$perNH_white, 
#                              breaks = quantile(CA_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_black<-df$P007004/df$P007001
# CA_BG$QperNH_black<- CutQ(CA_BG$perNH_black, 
#                           breaks = quantile(CA_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_asian<-df$P007006/df$P007001
# CA_BG$QperNH_asian<- CutQ(CA_BG$perNH_asian, 
#                           breaks = quantile(CA_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_AIAN<-df$P007005/df$P007001
# CA_BG$QperNH_AIAN<- CutQ(CA_BG$perNH_AIAN, 
#                           breaks = quantile(CA_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_NHPI<-df$P007007/df$P007001
# CA_BG$QperNH_NHPI<- CutQ(CA_BG$perNH_NHPI, 
#                          breaks = quantile(CA_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perNH_other<-df$P007008/df$P007001
# CA_BG$QperNH_other<- CutQ(CA_BG$perNH_other, 
#                          breaks = quantile(CA_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perHispanic<-df$P007010/df$P007001
# CA_BG$QperHispanic<- CutQ(CA_BG$perHispanic, 
#                           breaks = quantile(CA_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
CA_BG$perworkedfromhome<-df$P030016/df$P030001
# CA_BG$Qperworkedfromhome<- CutQ(CA_BG$perworkedfromhome, 
#                           breaks = quantile(CA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
CA_BG$perwalked<-df$P030014/df$P030001
# CA_BG$Qperwalked<- CutQ(CA_BG$perwalked, 
#                                 breaks = quantile(CA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
CA_BG$percar_varn_truck<-df$P030002/df$P030001
# CA_BG$Qpercar_varn_truck<- CutQ(CA_BG$percar_varn_truck, 
#                         breaks = quantile(CA_BG$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
CA_BG$permotorcycle<-df$P030012/df$P030001
# CA_BG$Qpermotorcycle<- CutQ(CA_BG$permotorcycle, 
#                                 breaks = quantile(CA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
CA_BG$perbicycle<-df$P030013/df$P030001
#CA_BG$Qperbicycle<- CutQ(CA_BG$perbicycle, 
#                            breaks = quantile(CA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# CA_BG$Qperbicycle<- CutQ(CA_BG$perbicycle, 
#                             breaks = quantile(CA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
CA_BG$perothercommutemeans<-df$P030015<-df$P030001
# CA_BG$Qperothercommutemeans<- CutQ(CA_BG$perothercommutemeans, 
#                          breaks = quantile(CA_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
CA_BG$pertraveltimeless30<-df$P033002/df$P033001
# CA_BG$Qpertraveltimeless30<- CutQ(CA_BG$pertraveltimeless30, 
#                                    breaks = quantile(CA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltime30_44<-df$P033005/df$P033001
# CA_BG$Qpertraveltime30_44<- CutQ(CA_BG$pertraveltime30_44, 
#                                   breaks = quantile(CA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



CA_BG$pertraveltime45_59<-df$P033008/df$P033001
# CA_BG$pertraveltime45_59<- CutQ(CA_BG$pertraveltime45_59, 
#                                  breaks = quantile(CA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_BG$pertraveltimemore60<-df$P033011/df$P033001
# CA_BG$Qpertraveltimemore60<- CutQ(CA_BG$pertraveltimemore60, 
#                                 breaks = quantile(CA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
CA_BG$perurbanized<-df$P005002/df$P005001
# CA_BG$Qperurbanized<- CutQ(CA_BG$perurbanized, 
#                                   breaks = quantile(CA_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perrural<-df$P005005/df$P005001
# CA_BG$Qperrural<- CutQ(CA_BG$perrural, 
#                           breaks = quantile(CA_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# CA_BG$Qperinsideurbanizedareas<- CutQ(CA_BG$perinsideurbanizedareas, 
#                        breaks = quantile(CA_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_BG$perinsideurbancluster<-df$P005004/df$P005001
# CA_BG$Qperinsideurbancluster<- CutQ(CA_BG$perinsideurbancluster, 
#                                       breaks = quantile(CA_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


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

#Population density
FL_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# FL_BG$Qpopulation_density<- CutQ(FL_BG$population_density, 
#                                     breaks = quantile(FL_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
FL_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# FL_BG$Qcrowding<- CutQ(FL_BG$crowding, 
#                                  breaks = quantile(FL_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
FL_BG$renting<-df$H007003/df$H007001

# FL_BG$Qrenting<- CutQ(FL_BG$renting, 
#                       breaks = quantile(FL_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
FL_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# FL_BG$Qpernonsinglefamilyunits<- CutQ(FL_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(FL_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
FL_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# FL_BG$Qpermoreunits<- CutQ(FL_BG$FL_BG$permoreunits, 
#                                       breaks = quantile(FL_BG$FL_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

FL_BG$perNonhispanic<-df$P007002/df$P007001
# FL_BG$QperNonhispanic<- CutQ(FL_BG$perNonhispanic, 
#                            breaks = quantile(FL_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_white<-df$P007003/df$P007001
# FL_BG$QperNH_white<- CutQ(FL_BG$perNH_white, 
#                              breaks = quantile(FL_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_black<-df$P007004/df$P007001
# FL_BG$QperNH_black<- CutQ(FL_BG$perNH_black, 
#                           breaks = quantile(FL_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_asian<-df$P007006/df$P007001
# FL_BG$QperNH_asian<- CutQ(FL_BG$perNH_asian, 
#                           breaks = quantile(FL_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_AIAN<-df$P007005/df$P007001
# FL_BG$QperNH_AIAN<- CutQ(FL_BG$perNH_AIAN, 
#                           breaks = quantile(FL_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_NHPI<-df$P007007/df$P007001
# FL_BG$QperNH_NHPI<- CutQ(FL_BG$perNH_NHPI, 
#                          breaks = quantile(FL_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perNH_other<-df$P007008/df$P007001
# FL_BG$QperNH_other<- CutQ(FL_BG$perNH_other, 
#                          breaks = quantile(FL_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perHispanic<-df$P007010/df$P007001
# FL_BG$QperHispanic<- CutQ(FL_BG$perHispanic, 
#                           breaks = quantile(FL_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
FL_BG$perworkedfromhome<-df$P030016/df$P030001
# FL_BG$Qperworkedfromhome<- CutQ(FL_BG$perworkedfromhome, 
#                           breaks = quantile(FL_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
FL_BG$perwalked<-df$P030014/df$P030001
# FL_BG$Qperwalked<- CutQ(FL_BG$perwalked, 
#                                 breaks = quantile(FL_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#FLr,truck,van
FL_BG$perFLr_varn_truck<-df$P030002/df$P030001
# FL_BG$QperFLr_varn_truck<- CutQ(FL_BG$perFLr_varn_truck, 
#                         breaks = quantile(FL_BG$perFLr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
FL_BG$permotorcycle<-df$P030012/df$P030001
# FL_BG$Qpermotorcycle<- CutQ(FL_BG$permotorcycle, 
#                                 breaks = quantile(FL_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
FL_BG$perbicycle<-df$P030013/df$P030001
#FL_BG$Qperbicycle<- CutQ(FL_BG$perbicycle, 
#                            breaks = quantile(FL_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# FL_BG$Qperbicycle<- CutQ(FL_BG$perbicycle, 
#                             breaks = quantile(FL_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
FL_BG$perothercommutemeans<-df$P030015<-df$P030001
# FL_BG$Qperothercommutemeans<- CutQ(FL_BG$perothercommutemeans, 
#                          breaks = quantile(FL_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
FL_BG$pertraveltimeless30<-df$P033002/df$P033001
# FL_BG$Qpertraveltimeless30<- CutQ(FL_BG$pertraveltimeless30, 
#                                    breaks = quantile(FL_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_BG$pertraveltime30_44<-df$P033005/df$P033001
# FL_BG$Qpertraveltime30_44<- CutQ(FL_BG$pertraveltime30_44, 
#                                   breaks = quantile(FL_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



FL_BG$pertraveltime45_59<-df$P033008/df$P033001
# FL_BG$pertraveltime45_59<- CutQ(FL_BG$pertraveltime45_59, 
#                                  breaks = quantile(FL_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_BG$pertraveltimemore60<-df$P033011/df$P033001
# FL_BG$Qpertraveltimemore60<- CutQ(FL_BG$pertraveltimemore60, 
#                                 breaks = quantile(FL_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
FL_BG$perurbanized<-df$P005002/df$P005001
# FL_BG$Qperurbanized<- CutQ(FL_BG$perurbanized, 
#                                   breaks = quantile(FL_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perrural<-df$P005005/df$P005001
# FL_BG$Qperrural<- CutQ(FL_BG$perrural, 
#                           breaks = quantile(FL_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# FL_BG$Qperinsideurbanizedareas<- CutQ(FL_BG$perinsideurbanizedareas, 
#                        breaks = quantile(FL_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_BG$perinsideurbancluster<-df$P005004/df$P005001
# FL_BG$Qperinsideurbancluster<- CutQ(FL_BG$perinsideurbancluster, 
#                                       breaks = quantile(FL_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(FL_BlockGroups,file = "M:\\RESPOND\\BG\\FLBG_var2000.csv")
write.csv(FL_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawFLBG_neighborvars2000.csv")
write.csv(FL_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\FLBG_neighborvars2000.csv")



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
df=GA_BlockGroups

#create new df
GA_BG<- as.data.frame(df$state)
colnames(GA_BG)[1] <- "State"
GA_BG$County <- df$county
GA_BG$Tract <- df$tract
GA_BG$BG<-df$block_group

#Population density
GA_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# GA_BG$Qpopulation_density<- CutQ(GA_BG$population_density, 
#                                     breaks = quantile(GA_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
GA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# GA_BG$Qcrowding<- CutQ(GA_BG$crowding, 
#                                  breaks = quantile(GA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
GA_BG$renting<-df$H007003/df$H007001

# GA_BG$Qrenting<- CutQ(GA_BG$renting, 
#                       breaks = quantile(GA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
GA_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# GA_BG$Qpernonsinglefamilyunits<- CutQ(GA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(GA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
GA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# GA_BG$Qpermoreunits<- CutQ(GA_BG$GA_BG$permoreunits, 
#                                       breaks = quantile(GA_BG$GA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

GA_BG$perNonhispanic<-df$P007002/df$P007001
# GA_BG$QperNonhispanic<- CutQ(GA_BG$perNonhispanic, 
#                            breaks = quantile(GA_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_white<-df$P007003/df$P007001
# GA_BG$QperNH_white<- CutQ(GA_BG$perNH_white, 
#                              breaks = quantile(GA_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_black<-df$P007004/df$P007001
# GA_BG$QperNH_black<- CutQ(GA_BG$perNH_black, 
#                           breaks = quantile(GA_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_asian<-df$P007006/df$P007001
# GA_BG$QperNH_asian<- CutQ(GA_BG$perNH_asian, 
#                           breaks = quantile(GA_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_AIAN<-df$P007005/df$P007001
# GA_BG$QperNH_AIAN<- CutQ(GA_BG$perNH_AIAN, 
#                           breaks = quantile(GA_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_NHPI<-df$P007007/df$P007001
# GA_BG$QperNH_NHPI<- CutQ(GA_BG$perNH_NHPI, 
#                          breaks = quantile(GA_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perNH_other<-df$P007008/df$P007001
# GA_BG$QperNH_other<- CutQ(GA_BG$perNH_other, 
#                          breaks = quantile(GA_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perHispanic<-df$P007010/df$P007001
# GA_BG$QperHispanic<- CutQ(GA_BG$perHispanic, 
#                           breaks = quantile(GA_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
GA_BG$perworkedfromhome<-df$P030016/df$P030001
# GA_BG$Qperworkedfromhome<- CutQ(GA_BG$perworkedfromhome, 
#                           breaks = quantile(GA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
GA_BG$perwalked<-df$P030014/df$P030001
# GA_BG$Qperwalked<- CutQ(GA_BG$perwalked, 
#                                 breaks = quantile(GA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#GAr,truck,van
GA_BG$perGAr_varn_truck<-df$P030002/df$P030001
# GA_BG$QperGAr_varn_truck<- CutQ(GA_BG$perGAr_varn_truck, 
#                         breaks = quantile(GA_BG$perGAr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
GA_BG$permotorcycle<-df$P030012/df$P030001
# GA_BG$Qpermotorcycle<- CutQ(GA_BG$permotorcycle, 
#                                 breaks = quantile(GA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
GA_BG$perbicycle<-df$P030013/df$P030001
#GA_BG$Qperbicycle<- CutQ(GA_BG$perbicycle, 
#                            breaks = quantile(GA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# GA_BG$Qperbicycle<- CutQ(GA_BG$perbicycle, 
#                             breaks = quantile(GA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
GA_BG$perothercommutemeans<-df$P030015<-df$P030001
# GA_BG$Qperothercommutemeans<- CutQ(GA_BG$perothercommutemeans, 
#                          breaks = quantile(GA_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
GA_BG$pertraveltimeless30<-df$P033002/df$P033001
# GA_BG$Qpertraveltimeless30<- CutQ(GA_BG$pertraveltimeless30, 
#                                    breaks = quantile(GA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_BG$pertraveltime30_44<-df$P033005/df$P033001
# GA_BG$Qpertraveltime30_44<- CutQ(GA_BG$pertraveltime30_44, 
#                                   breaks = quantile(GA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



GA_BG$pertraveltime45_59<-df$P033008/df$P033001
# GA_BG$pertraveltime45_59<- CutQ(GA_BG$pertraveltime45_59, 
#                                  breaks = quantile(GA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_BG$pertraveltimemore60<-df$P033011/df$P033001
# GA_BG$Qpertraveltimemore60<- CutQ(GA_BG$pertraveltimemore60, 
#                                 breaks = quantile(GA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
GA_BG$perurbanized<-df$P005002/df$P005001
# GA_BG$Qperurbanized<- CutQ(GA_BG$perurbanized, 
#                                   breaks = quantile(GA_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perrural<-df$P005005/df$P005001
# GA_BG$Qperrural<- CutQ(GA_BG$perrural, 
#                           breaks = quantile(GA_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# GA_BG$Qperinsideurbanizedareas<- CutQ(GA_BG$perinsideurbanizedareas, 
#                        breaks = quantile(GA_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_BG$perinsideurbancluster<-df$P005004/df$P005001
# GA_BG$Qperinsideurbancluster<- CutQ(GA_BG$perinsideurbancluster, 
#                                       breaks = quantile(GA_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(GA_BlockGroups,file = "M:\\RESPOND\\BG\\GABG_var2000.csv")
write.csv(GA_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawGABG_neighborvars2000.csv")
write.csv(GA_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\GABG_neighborvars2000.csv")
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
df=LA_BlockGroups

#create new df
LA_BG<- as.data.frame(df$state)
colnames(LA_BG)[1] <- "State"
LA_BG$County <- df$county
LA_BG$Tract <- df$tract
LA_BG$BG<-df$block_group

#Population density
LA_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# LA_BG$Qpopulation_density<- CutQ(LA_BG$population_density, 
#                                     breaks = quantile(LA_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
LA_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# LA_BG$Qcrowding<- CutQ(LA_BG$crowding, 
#                                  breaks = quantile(LA_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
LA_BG$renting<-df$H007003/df$H007001

# LA_BG$Qrenting<- CutQ(LA_BG$renting, 
#                       breaks = quantile(LA_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
LA_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# LA_BG$Qpernonsinglefamilyunits<- CutQ(LA_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(LA_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
LA_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# LA_BG$Qpermoreunits<- CutQ(LA_BG$LA_BG$permoreunits, 
#                                       breaks = quantile(LA_BG$LA_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

LA_BG$perNonhispanic<-df$P007002/df$P007001
# LA_BG$QperNonhispanic<- CutQ(LA_BG$perNonhispanic, 
#                            breaks = quantile(LA_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_white<-df$P007003/df$P007001
# LA_BG$QperNH_white<- CutQ(LA_BG$perNH_white, 
#                              breaks = quantile(LA_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_black<-df$P007004/df$P007001
# LA_BG$QperNH_black<- CutQ(LA_BG$perNH_black, 
#                           breaks = quantile(LA_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_asian<-df$P007006/df$P007001
# LA_BG$QperNH_asian<- CutQ(LA_BG$perNH_asian, 
#                           breaks = quantile(LA_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_AIAN<-df$P007005/df$P007001
# LA_BG$QperNH_AIAN<- CutQ(LA_BG$perNH_AIAN, 
#                           breaks = quantile(LA_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_NHPI<-df$P007007/df$P007001
# LA_BG$QperNH_NHPI<- CutQ(LA_BG$perNH_NHPI, 
#                          breaks = quantile(LA_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perNH_other<-df$P007008/df$P007001
# LA_BG$QperNH_other<- CutQ(LA_BG$perNH_other, 
#                          breaks = quantile(LA_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perHispanic<-df$P007010/df$P007001
# LA_BG$QperHispanic<- CutQ(LA_BG$perHispanic, 
#                           breaks = quantile(LA_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
LA_BG$perworkedfromhome<-df$P030016/df$P030001
# LA_BG$Qperworkedfromhome<- CutQ(LA_BG$perworkedfromhome, 
#                           breaks = quantile(LA_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
LA_BG$perwalked<-df$P030014/df$P030001
# LA_BG$Qperwalked<- CutQ(LA_BG$perwalked, 
#                                 breaks = quantile(LA_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#LAr,truck,van
LA_BG$perLAr_varn_truck<-df$P030002/df$P030001
# LA_BG$QperLAr_varn_truck<- CutQ(LA_BG$perLAr_varn_truck, 
#                         breaks = quantile(LA_BG$perLAr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
LA_BG$permotorcycle<-df$P030012/df$P030001
# LA_BG$Qpermotorcycle<- CutQ(LA_BG$permotorcycle, 
#                                 breaks = quantile(LA_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
LA_BG$perbicycle<-df$P030013/df$P030001
#LA_BG$Qperbicycle<- CutQ(LA_BG$perbicycle, 
#                            breaks = quantile(LA_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# LA_BG$Qperbicycle<- CutQ(LA_BG$perbicycle, 
#                             breaks = quantile(LA_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
LA_BG$perothercommutemeans<-df$P030015<-df$P030001
# LA_BG$Qperothercommutemeans<- CutQ(LA_BG$perothercommutemeans, 
#                          breaks = quantile(LA_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
LA_BG$pertraveltimeless30<-df$P033002/df$P033001
# LA_BG$Qpertraveltimeless30<- CutQ(LA_BG$pertraveltimeless30, 
#                                    breaks = quantile(LA_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_BG$pertraveltime30_44<-df$P033005/df$P033001
# LA_BG$Qpertraveltime30_44<- CutQ(LA_BG$pertraveltime30_44, 
#                                   breaks = quantile(LA_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



LA_BG$pertraveltime45_59<-df$P033008/df$P033001
# LA_BG$pertraveltime45_59<- CutQ(LA_BG$pertraveltime45_59, 
#                                  breaks = quantile(LA_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_BG$pertraveltimemore60<-df$P033011/df$P033001
# LA_BG$Qpertraveltimemore60<- CutQ(LA_BG$pertraveltimemore60, 
#                                 breaks = quantile(LA_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
LA_BG$perurbanized<-df$P005002/df$P005001
# LA_BG$Qperurbanized<- CutQ(LA_BG$perurbanized, 
#                                   breaks = quantile(LA_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perrural<-df$P005005/df$P005001
# LA_BG$Qperrural<- CutQ(LA_BG$perrural, 
#                           breaks = quantile(LA_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# LA_BG$Qperinsideurbanizedareas<- CutQ(LA_BG$perinsideurbanizedareas, 
#                        breaks = quantile(LA_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_BG$perinsideurbancluster<-df$P005004/df$P005001
# LA_BG$Qperinsideurbancluster<- CutQ(LA_BG$perinsideurbancluster, 
#                                       breaks = quantile(LA_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(LA_BlockGroups,file = "M:\\RESPOND\\BG\\LABG_var2000.csv")
write.csv(LA_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawLABG_neighborvars2000.csv")
write.csv(LA_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\LABG_neighborvars2000.csv")

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
df=NJ_BlockGroups

#create new df
NJ_BG<- as.data.frame(df$state)
colnames(NJ_BG)[1] <- "State"
NJ_BG$County <- df$county
NJ_BG$Tract <- df$tract
NJ_BG$BG<-df$block_group

#Population density
NJ_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# NJ_BG$Qpopulation_density<- CutQ(NJ_BG$population_density, 
#                                     breaks = quantile(NJ_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
NJ_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# NJ_BG$Qcrowding<- CutQ(NJ_BG$crowding, 
#                                  breaks = quantile(NJ_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
NJ_BG$renting<-df$H007003/df$H007001

# NJ_BG$Qrenting<- CutQ(NJ_BG$renting, 
#                       breaks = quantile(NJ_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
NJ_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# NJ_BG$Qpernonsinglefamilyunits<- CutQ(NJ_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(NJ_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
NJ_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# NJ_BG$Qpermoreunits<- CutQ(NJ_BG$NJ_BG$permoreunits, 
#                                       breaks = quantile(NJ_BG$NJ_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

NJ_BG$perNonhispanic<-df$P007002/df$P007001
# NJ_BG$QperNonhispanic<- CutQ(NJ_BG$perNonhispanic, 
#                            breaks = quantile(NJ_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_white<-df$P007003/df$P007001
# NJ_BG$QperNH_white<- CutQ(NJ_BG$perNH_white, 
#                              breaks = quantile(NJ_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_black<-df$P007004/df$P007001
# NJ_BG$QperNH_black<- CutQ(NJ_BG$perNH_black, 
#                           breaks = quantile(NJ_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_asian<-df$P007006/df$P007001
# NJ_BG$QperNH_asian<- CutQ(NJ_BG$perNH_asian, 
#                           breaks = quantile(NJ_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_AIAN<-df$P007005/df$P007001
# NJ_BG$QperNH_AIAN<- CutQ(NJ_BG$perNH_AIAN, 
#                           breaks = quantile(NJ_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_NHPI<-df$P007007/df$P007001
# NJ_BG$QperNH_NHPI<- CutQ(NJ_BG$perNH_NHPI, 
#                          breaks = quantile(NJ_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perNH_other<-df$P007008/df$P007001
# NJ_BG$QperNH_other<- CutQ(NJ_BG$perNH_other, 
#                          breaks = quantile(NJ_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perHispanic<-df$P007010/df$P007001
# NJ_BG$QperHispanic<- CutQ(NJ_BG$perHispanic, 
#                           breaks = quantile(NJ_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
NJ_BG$perworkedfromhome<-df$P030016/df$P030001
# NJ_BG$Qperworkedfromhome<- CutQ(NJ_BG$perworkedfromhome, 
#                           breaks = quantile(NJ_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
NJ_BG$perwalked<-df$P030014/df$P030001
# NJ_BG$Qperwalked<- CutQ(NJ_BG$perwalked, 
#                                 breaks = quantile(NJ_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#NJr,truck,van
NJ_BG$perNJr_varn_truck<-df$P030002/df$P030001
# NJ_BG$QperNJr_varn_truck<- CutQ(NJ_BG$perNJr_varn_truck, 
#                         breaks = quantile(NJ_BG$perNJr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
NJ_BG$permotorcycle<-df$P030012/df$P030001
# NJ_BG$Qpermotorcycle<- CutQ(NJ_BG$permotorcycle, 
#                                 breaks = quantile(NJ_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
NJ_BG$perbicycle<-df$P030013/df$P030001
#NJ_BG$Qperbicycle<- CutQ(NJ_BG$perbicycle, 
#                            breaks = quantile(NJ_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# NJ_BG$Qperbicycle<- CutQ(NJ_BG$perbicycle, 
#                             breaks = quantile(NJ_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
NJ_BG$perothercommutemeans<-df$P030015<-df$P030001
# NJ_BG$Qperothercommutemeans<- CutQ(NJ_BG$perothercommutemeans, 
#                          breaks = quantile(NJ_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
NJ_BG$pertraveltimeless30<-df$P033002/df$P033001
# NJ_BG$Qpertraveltimeless30<- CutQ(NJ_BG$pertraveltimeless30, 
#                                    breaks = quantile(NJ_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_BG$pertraveltime30_44<-df$P033005/df$P033001
# NJ_BG$Qpertraveltime30_44<- CutQ(NJ_BG$pertraveltime30_44, 
#                                   breaks = quantile(NJ_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



NJ_BG$pertraveltime45_59<-df$P033008/df$P033001
# NJ_BG$pertraveltime45_59<- CutQ(NJ_BG$pertraveltime45_59, 
#                                  breaks = quantile(NJ_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_BG$pertraveltimemore60<-df$P033011/df$P033001
# NJ_BG$Qpertraveltimemore60<- CutQ(NJ_BG$pertraveltimemore60, 
#                                 breaks = quantile(NJ_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
NJ_BG$perurbanized<-df$P005002/df$P005001
# NJ_BG$Qperurbanized<- CutQ(NJ_BG$perurbanized, 
#                                   breaks = quantile(NJ_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perrural<-df$P005005/df$P005001
# NJ_BG$Qperrural<- CutQ(NJ_BG$perrural, 
#                           breaks = quantile(NJ_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# NJ_BG$Qperinsideurbanizedareas<- CutQ(NJ_BG$perinsideurbanizedareas, 
#                        breaks = quantile(NJ_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_BG$perinsideurbancluster<-df$P005004/df$P005001
# NJ_BG$Qperinsideurbancluster<- CutQ(NJ_BG$perinsideurbancluster, 
#                                       breaks = quantile(NJ_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\BG\\NJBG_var2000.csv")
write.csv(NJ_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawNJBG_neighborvars2000.csv")
write.csv(NJ_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\NJBG_neighborvars2000.csv")
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
df=TX_BlockGroups

#create new df
TX_BG<- as.data.frame(df$state)
colnames(TX_BG)[1] <- "State"
TX_BG$County <- df$county
TX_BG$Tract <- df$tract
TX_BG$BG<-df$block_group

#Population density
TX_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# TX_BG$Qpopulation_density<- CutQ(TX_BG$population_density, 
#                                     breaks = quantile(TX_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
TX_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# TX_BG$Qcrowding<- CutQ(TX_BG$crowding, 
#                                  breaks = quantile(TX_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
TX_BG$renting<-df$H007003/df$H007001

# TX_BG$Qrenting<- CutQ(TX_BG$renting, 
#                       breaks = quantile(TX_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
TX_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# TX_BG$Qpernonsinglefamilyunits<- CutQ(TX_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(TX_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
TX_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# TX_BG$Qpermoreunits<- CutQ(TX_BG$TX_BG$permoreunits, 
#                                       breaks = quantile(TX_BG$TX_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

TX_BG$perNonhispanic<-df$P007002/df$P007001
# TX_BG$QperNonhispanic<- CutQ(TX_BG$perNonhispanic, 
#                            breaks = quantile(TX_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_white<-df$P007003/df$P007001
# TX_BG$QperNH_white<- CutQ(TX_BG$perNH_white, 
#                              breaks = quantile(TX_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_black<-df$P007004/df$P007001
# TX_BG$QperNH_black<- CutQ(TX_BG$perNH_black, 
#                           breaks = quantile(TX_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_asian<-df$P007006/df$P007001
# TX_BG$QperNH_asian<- CutQ(TX_BG$perNH_asian, 
#                           breaks = quantile(TX_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_AIAN<-df$P007005/df$P007001
# TX_BG$QperNH_AIAN<- CutQ(TX_BG$perNH_AIAN, 
#                           breaks = quantile(TX_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_NHPI<-df$P007007/df$P007001
# TX_BG$QperNH_NHPI<- CutQ(TX_BG$perNH_NHPI, 
#                          breaks = quantile(TX_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perNH_other<-df$P007008/df$P007001
# TX_BG$QperNH_other<- CutQ(TX_BG$perNH_other, 
#                          breaks = quantile(TX_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perHispanic<-df$P007010/df$P007001
# TX_BG$QperHispanic<- CutQ(TX_BG$perHispanic, 
#                           breaks = quantile(TX_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
TX_BG$perworkedfromhome<-df$P030016/df$P030001
# TX_BG$Qperworkedfromhome<- CutQ(TX_BG$perworkedfromhome, 
#                           breaks = quantile(TX_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
TX_BG$perwalked<-df$P030014/df$P030001
# TX_BG$Qperwalked<- CutQ(TX_BG$perwalked, 
#                                 breaks = quantile(TX_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#TXr,truck,van
TX_BG$perTXr_varn_truck<-df$P030002/df$P030001
# TX_BG$QperTXr_varn_truck<- CutQ(TX_BG$perTXr_varn_truck, 
#                         breaks = quantile(TX_BG$perTXr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
TX_BG$permotorcycle<-df$P030012/df$P030001
# TX_BG$Qpermotorcycle<- CutQ(TX_BG$permotorcycle, 
#                                 breaks = quantile(TX_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
TX_BG$perbicycle<-df$P030013/df$P030001
#TX_BG$Qperbicycle<- CutQ(TX_BG$perbicycle, 
#                            breaks = quantile(TX_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# TX_BG$Qperbicycle<- CutQ(TX_BG$perbicycle, 
#                             breaks = quantile(TX_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
TX_BG$perothercommutemeans<-df$P030015<-df$P030001
# TX_BG$Qperothercommutemeans<- CutQ(TX_BG$perothercommutemeans, 
#                          breaks = quantile(TX_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
TX_BG$pertraveltimeless30<-df$P033002/df$P033001
# TX_BG$Qpertraveltimeless30<- CutQ(TX_BG$pertraveltimeless30, 
#                                    breaks = quantile(TX_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_BG$pertraveltime30_44<-df$P033005/df$P033001
# TX_BG$Qpertraveltime30_44<- CutQ(TX_BG$pertraveltime30_44, 
#                                   breaks = quantile(TX_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



TX_BG$pertraveltime45_59<-df$P033008/df$P033001
# TX_BG$pertraveltime45_59<- CutQ(TX_BG$pertraveltime45_59, 
#                                  breaks = quantile(TX_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_BG$pertraveltimemore60<-df$P033011/df$P033001
# TX_BG$Qpertraveltimemore60<- CutQ(TX_BG$pertraveltimemore60, 
#                                 breaks = quantile(TX_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
TX_BG$perurbanized<-df$P005002/df$P005001
# TX_BG$Qperurbanized<- CutQ(TX_BG$perurbanized, 
#                                   breaks = quantile(TX_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perrural<-df$P005005/df$P005001
# TX_BG$Qperrural<- CutQ(TX_BG$perrural, 
#                           breaks = quantile(TX_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# TX_BG$Qperinsideurbanizedareas<- CutQ(TX_BG$perinsideurbanizedareas, 
#                        breaks = quantile(TX_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_BG$perinsideurbancluster<-df$P005004/df$P005001
# TX_BG$Qperinsideurbancluster<- CutQ(TX_BG$perinsideurbancluster, 
#                                       breaks = quantile(TX_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(TX_BlockGroups,file = "M:\\RESPOND\\BG\\TXBG_var2000.csv")
write.csv(TX_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawTXBG_neighborvars2000.csv")
write.csv(TX_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\TXBG_neighborvars2000.csv")
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

#Population density
MI_BG$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# MI_BG$Qpopulation_density<- CutQ(MI_BG$population_density, 
#                                     breaks = quantile(MI_BG$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
MI_BG$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# MI_BG$Qcrowding<- CutQ(MI_BG$crowding, 
#                                  breaks = quantile(MI_BG$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
MI_BG$renting<-df$H007003/df$H007001

# MI_BG$Qrenting<- CutQ(MI_BG$renting, 
#                       breaks = quantile(MI_BG$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
MI_BG$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# MI_BG$Qpernonsinglefamilyunits<- CutQ(MI_BG$pernonsinglefamilyunits, 
#                      breaks = quantile(MI_BG$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
MI_BG$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# MI_BG$Qpermoreunits<- CutQ(MI_BG$MI_BG$permoreunits, 
#                                       breaks = quantile(MI_BG$MI_BG$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

MI_BG$perNonhispanic<-df$P007002/df$P007001
# MI_BG$QperNonhispanic<- CutQ(MI_BG$perNonhispanic, 
#                            breaks = quantile(MI_BG$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_white<-df$P007003/df$P007001
# MI_BG$QperNH_white<- CutQ(MI_BG$perNH_white, 
#                              breaks = quantile(MI_BG$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_black<-df$P007004/df$P007001
# MI_BG$QperNH_black<- CutQ(MI_BG$perNH_black, 
#                           breaks = quantile(MI_BG$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_asian<-df$P007006/df$P007001
# MI_BG$QperNH_asian<- CutQ(MI_BG$perNH_asian, 
#                           breaks = quantile(MI_BG$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_AIAN<-df$P007005/df$P007001
# MI_BG$QperNH_AIAN<- CutQ(MI_BG$perNH_AIAN, 
#                           breaks = quantile(MI_BG$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_NHPI<-df$P007007/df$P007001
# MI_BG$QperNH_NHPI<- CutQ(MI_BG$perNH_NHPI, 
#                          breaks = quantile(MI_BG$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perNH_other<-df$P007008/df$P007001
# MI_BG$QperNH_other<- CutQ(MI_BG$perNH_other, 
#                          breaks = quantile(MI_BG$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perHispanic<-df$P007010/df$P007001
# MI_BG$QperHispanic<- CutQ(MI_BG$perHispanic, 
#                           breaks = quantile(MI_BG$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
MI_BG$perworkedfromhome<-df$P030016/df$P030001
# MI_BG$Qperworkedfromhome<- CutQ(MI_BG$perworkedfromhome, 
#                           breaks = quantile(MI_BG$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
MI_BG$perwalked<-df$P030014/df$P030001
# MI_BG$Qperwalked<- CutQ(MI_BG$perwalked, 
#                                 breaks = quantile(MI_BG$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#MIr,truck,van
MI_BG$perMIr_varn_truck<-df$P030002/df$P030001
# MI_BG$QperMIr_varn_truck<- CutQ(MI_BG$perMIr_varn_truck, 
#                         breaks = quantile(MI_BG$perMIr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
MI_BG$permotorcycle<-df$P030012/df$P030001
# MI_BG$Qpermotorcycle<- CutQ(MI_BG$permotorcycle, 
#                                 breaks = quantile(MI_BG$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
MI_BG$perbicycle<-df$P030013/df$P030001
#MI_BG$Qperbicycle<- CutQ(MI_BG$perbicycle, 
#                            breaks = quantile(MI_BG$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# MI_BG$Qperbicycle<- CutQ(MI_BG$perbicycle, 
#                             breaks = quantile(MI_BG$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
MI_BG$perothercommutemeans<-df$P030015<-df$P030001
# MI_BG$Qperothercommutemeans<- CutQ(MI_BG$perothercommutemeans, 
#                          breaks = quantile(MI_BG$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
MI_BG$pertraveltimeless30<-df$P033002/df$P033001
# MI_BG$Qpertraveltimeless30<- CutQ(MI_BG$pertraveltimeless30, 
#                                    breaks = quantile(MI_BG$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_BG$pertraveltime30_44<-df$P033005/df$P033001
# MI_BG$Qpertraveltime30_44<- CutQ(MI_BG$pertraveltime30_44, 
#                                   breaks = quantile(MI_BG$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



MI_BG$pertraveltime45_59<-df$P033008/df$P033001
# MI_BG$pertraveltime45_59<- CutQ(MI_BG$pertraveltime45_59, 
#                                  breaks = quantile(MI_BG$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_BG$pertraveltimemore60<-df$P033011/df$P033001
# MI_BG$Qpertraveltimemore60<- CutQ(MI_BG$pertraveltimemore60, 
#                                 breaks = quantile(MI_BG$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
MI_BG$perurbanized<-df$P005002/df$P005001
# MI_BG$Qperurbanized<- CutQ(MI_BG$perurbanized, 
#                                   breaks = quantile(MI_BG$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perrural<-df$P005005/df$P005001
# MI_BG$Qperrural<- CutQ(MI_BG$perrural, 
#                           breaks = quantile(MI_BG$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perinsideurbanizedareas<-df$P005003/df$P005001
# MI_BG$Qperinsideurbanizedareas<- CutQ(MI_BG$perinsideurbanizedareas, 
#                        breaks = quantile(MI_BG$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_BG$perinsideurbancluster<-df$P005004/df$P005001
# MI_BG$Qperinsideurbancluster<- CutQ(MI_BG$perinsideurbancluster, 
#                                       breaks = quantile(MI_BG$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(MI_BlockGroups,file = "M:\\RESPOND\\BG\\MIBG_var2000.csv")
write.csv(MI_BlockGroups,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\rawMIBG_neighborvars2000.csv")
write.csv(MI_BG,file = "M:\\RESPOND\\2000\\BG\\neighborhood_vars\\MIBG_neighborvars2000.csv")







#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------
#-------------------  ------------------------------ ----------------------    -------------------------------  --------------------------------------

## Census Tract 
#CA
CA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
CA_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# CA_CT$Qpopulation_density<- CutQ(CA_CT$population_density, 
#                                     breaks = quantile(CA_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
CA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# CA_CT$Qcrowding<- CutQ(CA_CT$crowding, 
#                                  breaks = quantile(CA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
CA_CT$renting<-df$H007003/df$H007001

# CA_CT$Qrenting<- CutQ(CA_CT$renting, 
#                       breaks = quantile(CA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
CA_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# CA_CT$Qpernonsinglefamilyunits<- CutQ(CA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(CA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
CA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# CA_CT$Qpermoreunits<- CutQ(CA_CT$CA_CT$permoreunits, 
#                                       breaks = quantile(CA_CT$CA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

CA_CT$perNonhispanic<-df$P007002/df$P007001
# CA_CT$QperNonhispanic<- CutQ(CA_CT$perNonhispanic, 
#                            breaks = quantile(CA_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_white<-df$P007003/df$P007001
# CA_CT$QperNH_white<- CutQ(CA_CT$perNH_white, 
#                              breaks = quantile(CA_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_black<-df$P007004/df$P007001
# CA_CT$QperNH_black<- CutQ(CA_CT$perNH_black, 
#                           breaks = quantile(CA_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_asian<-df$P007006/df$P007001
# CA_CT$QperNH_asian<- CutQ(CA_CT$perNH_asian, 
#                           breaks = quantile(CA_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_AIAN<-df$P007005/df$P007001
# CA_CT$QperNH_AIAN<- CutQ(CA_CT$perNH_AIAN, 
#                           breaks = quantile(CA_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_NHPI<-df$P007007/df$P007001
# CA_CT$QperNH_NHPI<- CutQ(CA_CT$perNH_NHPI, 
#                          breaks = quantile(CA_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perNH_other<-df$P007008/df$P007001
# CA_CT$QperNH_other<- CutQ(CA_CT$perNH_other, 
#                          breaks = quantile(CA_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perHispanic<-df$P007010/df$P007001
# CA_CT$QperHispanic<- CutQ(CA_CT$perHispanic, 
#                           breaks = quantile(CA_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
CA_CT$perworkedfromhome<-df$P030016/df$P030001
# CA_CT$Qperworkedfromhome<- CutQ(CA_CT$perworkedfromhome, 
#                           breaks = quantile(CA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
CA_CT$perwalked<-df$P030014/df$P030001
# CA_CT$Qperwalked<- CutQ(CA_CT$perwalked, 
#                                 breaks = quantile(CA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#car,truck,van
CA_CT$percar_varn_truck<-df$P030002/df$P030001
# CA_CT$Qpercar_varn_truck<- CutQ(CA_CT$percar_varn_truck, 
#                         breaks = quantile(CA_CT$percar_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
CA_CT$permotorcycle<-df$P030012/df$P030001
# CA_CT$Qpermotorcycle<- CutQ(CA_CT$permotorcycle, 
#                                 breaks = quantile(CA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
CA_CT$perbicycle<-df$P030013/df$P030001
#CA_CT$Qperbicycle<- CutQ(CA_CT$perbicycle, 
#                            breaks = quantile(CA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# CA_CT$Qperbicycle<- CutQ(CA_CT$perbicycle, 
#                             breaks = quantile(CA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
CA_CT$perothercommutemeans<-df$P030015<-df$P030001
# CA_CT$Qperothercommutemeans<- CutQ(CA_CT$perothercommutemeans, 
#                          breaks = quantile(CA_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
CA_CT$pertraveltimeless30<-df$P033002/df$P033001
# CA_CT$Qpertraveltimeless30<- CutQ(CA_CT$pertraveltimeless30, 
#                                    breaks = quantile(CA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_CT$pertraveltime30_44<-df$P033005/df$P033001
# CA_CT$Qpertraveltime30_44<- CutQ(CA_CT$pertraveltime30_44, 
#                                   breaks = quantile(CA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



CA_CT$pertraveltime45_59<-df$P033008/df$P033001
# CA_CT$pertraveltime45_59<- CutQ(CA_CT$pertraveltime45_59, 
#                                  breaks = quantile(CA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

CA_CT$pertraveltimemore60<-df$P033011/df$P033001
# CA_CT$Qpertraveltimemore60<- CutQ(CA_CT$pertraveltimemore60, 
#                                 breaks = quantile(CA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
CA_CT$perurbanized<-df$P005002/df$P005001
# CA_CT$Qperurbanized<- CutQ(CA_CT$perurbanized, 
#                                   breaks = quantile(CA_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perrural<-df$P005005/df$P005001
# CA_CT$Qperrural<- CutQ(CA_CT$perrural, 
#                           breaks = quantile(CA_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# CA_CT$Qperinsideurbanizedareas<- CutQ(CA_CT$perinsideurbanizedareas, 
#                        breaks = quantile(CA_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


CA_CT$perinsideurbancluster<-df$P005004/df$P005001
# CA_CT$Qperinsideurbancluster<- CutQ(CA_CT$perinsideurbancluster, 
#                                       breaks = quantile(CA_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(CA_Tracts,file = "M:\\RESPOND\\CT\\CACT_var2000.csv")
write.csv(CA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawCACT_neighborvars2000.csv")
write.csv(CA_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\CACT_neighborvars2000.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------

#FL
FL_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
FL_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# FL_CT$Qpopulation_density<- CutQ(FL_CT$population_density, 
#                                     breaks = quantile(FL_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
FL_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# FL_CT$Qcrowding<- CutQ(FL_CT$crowding, 
#                                  breaks = quantile(FL_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
FL_CT$renting<-df$H007003/df$H007001

# FL_CT$Qrenting<- CutQ(FL_CT$renting, 
#                       breaks = quantile(FL_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
FL_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# FL_CT$Qpernonsinglefamilyunits<- CutQ(FL_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(FL_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
FL_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# FL_CT$Qpermoreunits<- CutQ(FL_CT$FL_CT$permoreunits, 
#                                       breaks = quantile(FL_CT$FL_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

FL_CT$perNonhispanic<-df$P007002/df$P007001
# FL_CT$QperNonhispanic<- CutQ(FL_CT$perNonhispanic, 
#                            breaks = quantile(FL_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_white<-df$P007003/df$P007001
# FL_CT$QperNH_white<- CutQ(FL_CT$perNH_white, 
#                              breaks = quantile(FL_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_black<-df$P007004/df$P007001
# FL_CT$QperNH_black<- CutQ(FL_CT$perNH_black, 
#                           breaks = quantile(FL_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_asian<-df$P007006/df$P007001
# FL_CT$QperNH_asian<- CutQ(FL_CT$perNH_asian, 
#                           breaks = quantile(FL_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_AIAN<-df$P007005/df$P007001
# FL_CT$QperNH_AIAN<- CutQ(FL_CT$perNH_AIAN, 
#                           breaks = quantile(FL_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_NHPI<-df$P007007/df$P007001
# FL_CT$QperNH_NHPI<- CutQ(FL_CT$perNH_NHPI, 
#                          breaks = quantile(FL_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perNH_other<-df$P007008/df$P007001
# FL_CT$QperNH_other<- CutQ(FL_CT$perNH_other, 
#                          breaks = quantile(FL_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perHispanic<-df$P007010/df$P007001
# FL_CT$QperHispanic<- CutQ(FL_CT$perHispanic, 
#                           breaks = quantile(FL_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
FL_CT$perworkedfromhome<-df$P030016/df$P030001
# FL_CT$Qperworkedfromhome<- CutQ(FL_CT$perworkedfromhome, 
#                           breaks = quantile(FL_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
FL_CT$perwalked<-df$P030014/df$P030001
# FL_CT$Qperwalked<- CutQ(FL_CT$perwalked, 
#                                 breaks = quantile(FL_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#FLr,truck,van
FL_CT$perFLr_varn_truck<-df$P030002/df$P030001
# FL_CT$QperFLr_varn_truck<- CutQ(FL_CT$perFLr_varn_truck, 
#                         breaks = quantile(FL_CT$perFLr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
FL_CT$permotorcycle<-df$P030012/df$P030001
# FL_CT$Qpermotorcycle<- CutQ(FL_CT$permotorcycle, 
#                                 breaks = quantile(FL_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
FL_CT$perbicycle<-df$P030013/df$P030001
#FL_CT$Qperbicycle<- CutQ(FL_CT$perbicycle, 
#                            breaks = quantile(FL_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# FL_CT$Qperbicycle<- CutQ(FL_CT$perbicycle, 
#                             breaks = quantile(FL_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
FL_CT$perothercommutemeans<-df$P030015<-df$P030001
# FL_CT$Qperothercommutemeans<- CutQ(FL_CT$perothercommutemeans, 
#                          breaks = quantile(FL_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
FL_CT$pertraveltimeless30<-df$P033002/df$P033001
# FL_CT$Qpertraveltimeless30<- CutQ(FL_CT$pertraveltimeless30, 
#                                    breaks = quantile(FL_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_CT$pertraveltime30_44<-df$P033005/df$P033001
# FL_CT$Qpertraveltime30_44<- CutQ(FL_CT$pertraveltime30_44, 
#                                   breaks = quantile(FL_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



FL_CT$pertraveltime45_59<-df$P033008/df$P033001
# FL_CT$pertraveltime45_59<- CutQ(FL_CT$pertraveltime45_59, 
#                                  breaks = quantile(FL_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

FL_CT$pertraveltimemore60<-df$P033011/df$P033001
# FL_CT$Qpertraveltimemore60<- CutQ(FL_CT$pertraveltimemore60, 
#                                 breaks = quantile(FL_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
FL_CT$perurbanized<-df$P005002/df$P005001
# FL_CT$Qperurbanized<- CutQ(FL_CT$perurbanized, 
#                                   breaks = quantile(FL_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perrural<-df$P005005/df$P005001
# FL_CT$Qperrural<- CutQ(FL_CT$perrural, 
#                           breaks = quantile(FL_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# FL_CT$Qperinsideurbanizedareas<- CutQ(FL_CT$perinsideurbanizedareas, 
#                        breaks = quantile(FL_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


FL_CT$perinsideurbancluster<-df$P005004/df$P005001
# FL_CT$Qperinsideurbancluster<- CutQ(FL_CT$perinsideurbancluster, 
#                                       breaks = quantile(FL_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(FL_Tracts,file = "M:\\RESPOND\\CT\\FLCT_var2000.csv")
write.csv(FL_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawFLCT_neighborvars2000.csv")
write.csv(FL_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\FLCT_neighborvars2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#GA
GA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
GA_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# GA_CT$Qpopulation_density<- CutQ(GA_CT$population_density, 
#                                     breaks = quantile(GA_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
GA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# GA_CT$Qcrowding<- CutQ(GA_CT$crowding, 
#                                  breaks = quantile(GA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
GA_CT$renting<-df$H007003/df$H007001

# GA_CT$Qrenting<- CutQ(GA_CT$renting, 
#                       breaks = quantile(GA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
GA_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# GA_CT$Qpernonsinglefamilyunits<- CutQ(GA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(GA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
GA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# GA_CT$Qpermoreunits<- CutQ(GA_CT$GA_CT$permoreunits, 
#                                       breaks = quantile(GA_CT$GA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

GA_CT$perNonhispanic<-df$P007002/df$P007001
# GA_CT$QperNonhispanic<- CutQ(GA_CT$perNonhispanic, 
#                            breaks = quantile(GA_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_white<-df$P007003/df$P007001
# GA_CT$QperNH_white<- CutQ(GA_CT$perNH_white, 
#                              breaks = quantile(GA_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_black<-df$P007004/df$P007001
# GA_CT$QperNH_black<- CutQ(GA_CT$perNH_black, 
#                           breaks = quantile(GA_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_asian<-df$P007006/df$P007001
# GA_CT$QperNH_asian<- CutQ(GA_CT$perNH_asian, 
#                           breaks = quantile(GA_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_AIAN<-df$P007005/df$P007001
# GA_CT$QperNH_AIAN<- CutQ(GA_CT$perNH_AIAN, 
#                           breaks = quantile(GA_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_NHPI<-df$P007007/df$P007001
# GA_CT$QperNH_NHPI<- CutQ(GA_CT$perNH_NHPI, 
#                          breaks = quantile(GA_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perNH_other<-df$P007008/df$P007001
# GA_CT$QperNH_other<- CutQ(GA_CT$perNH_other, 
#                          breaks = quantile(GA_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perHispanic<-df$P007010/df$P007001
# GA_CT$QperHispanic<- CutQ(GA_CT$perHispanic, 
#                           breaks = quantile(GA_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
GA_CT$perworkedfromhome<-df$P030016/df$P030001
# GA_CT$Qperworkedfromhome<- CutQ(GA_CT$perworkedfromhome, 
#                           breaks = quantile(GA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
GA_CT$perwalked<-df$P030014/df$P030001
# GA_CT$Qperwalked<- CutQ(GA_CT$perwalked, 
#                                 breaks = quantile(GA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#GAr,truck,van
GA_CT$perGAr_varn_truck<-df$P030002/df$P030001
# GA_CT$QperGAr_varn_truck<- CutQ(GA_CT$perGAr_varn_truck, 
#                         breaks = quantile(GA_CT$perGAr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
GA_CT$permotorcycle<-df$P030012/df$P030001
# GA_CT$Qpermotorcycle<- CutQ(GA_CT$permotorcycle, 
#                                 breaks = quantile(GA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
GA_CT$perbicycle<-df$P030013/df$P030001
#GA_CT$Qperbicycle<- CutQ(GA_CT$perbicycle, 
#                            breaks = quantile(GA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# GA_CT$Qperbicycle<- CutQ(GA_CT$perbicycle, 
#                             breaks = quantile(GA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
GA_CT$perothercommutemeans<-df$P030015<-df$P030001
# GA_CT$Qperothercommutemeans<- CutQ(GA_CT$perothercommutemeans, 
#                          breaks = quantile(GA_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
GA_CT$pertraveltimeless30<-df$P033002/df$P033001
# GA_CT$Qpertraveltimeless30<- CutQ(GA_CT$pertraveltimeless30, 
#                                    breaks = quantile(GA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_CT$pertraveltime30_44<-df$P033005/df$P033001
# GA_CT$Qpertraveltime30_44<- CutQ(GA_CT$pertraveltime30_44, 
#                                   breaks = quantile(GA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



GA_CT$pertraveltime45_59<-df$P033008/df$P033001
# GA_CT$pertraveltime45_59<- CutQ(GA_CT$pertraveltime45_59, 
#                                  breaks = quantile(GA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

GA_CT$pertraveltimemore60<-df$P033011/df$P033001
# GA_CT$Qpertraveltimemore60<- CutQ(GA_CT$pertraveltimemore60, 
#                                 breaks = quantile(GA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
GA_CT$perurbanized<-df$P005002/df$P005001
# GA_CT$Qperurbanized<- CutQ(GA_CT$perurbanized, 
#                                   breaks = quantile(GA_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perrural<-df$P005005/df$P005001
# GA_CT$Qperrural<- CutQ(GA_CT$perrural, 
#                           breaks = quantile(GA_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# GA_CT$Qperinsideurbanizedareas<- CutQ(GA_CT$perinsideurbanizedareas, 
#                        breaks = quantile(GA_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


GA_CT$perinsideurbancluster<-df$P005004/df$P005001
# GA_CT$Qperinsideurbancluster<- CutQ(GA_CT$perinsideurbancluster, 
#                                       breaks = quantile(GA_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(GA_Tracts,file = "M:\\RESPOND\\CT\\GACT_var2000.csv")
write.csv(GA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawGACT_neighborvars2000.csv")
write.csv(GA_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\GACT_neighborvars2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------

#LA
LA_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
LA_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# LA_CT$Qpopulation_density<- CutQ(LA_CT$population_density, 
#                                     breaks = quantile(LA_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
LA_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# LA_CT$Qcrowding<- CutQ(LA_CT$crowding, 
#                                  breaks = quantile(LA_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
LA_CT$renting<-df$H007003/df$H007001

# LA_CT$Qrenting<- CutQ(LA_CT$renting, 
#                       breaks = quantile(LA_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
LA_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# LA_CT$Qpernonsinglefamilyunits<- CutQ(LA_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(LA_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
LA_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# LA_CT$Qpermoreunits<- CutQ(LA_CT$LA_CT$permoreunits, 
#                                       breaks = quantile(LA_CT$LA_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

LA_CT$perNonhispanic<-df$P007002/df$P007001
# LA_CT$QperNonhispanic<- CutQ(LA_CT$perNonhispanic, 
#                            breaks = quantile(LA_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_white<-df$P007003/df$P007001
# LA_CT$QperNH_white<- CutQ(LA_CT$perNH_white, 
#                              breaks = quantile(LA_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_black<-df$P007004/df$P007001
# LA_CT$QperNH_black<- CutQ(LA_CT$perNH_black, 
#                           breaks = quantile(LA_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_asian<-df$P007006/df$P007001
# LA_CT$QperNH_asian<- CutQ(LA_CT$perNH_asian, 
#                           breaks = quantile(LA_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_AIAN<-df$P007005/df$P007001
# LA_CT$QperNH_AIAN<- CutQ(LA_CT$perNH_AIAN, 
#                           breaks = quantile(LA_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_NHPI<-df$P007007/df$P007001
# LA_CT$QperNH_NHPI<- CutQ(LA_CT$perNH_NHPI, 
#                          breaks = quantile(LA_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perNH_other<-df$P007008/df$P007001
# LA_CT$QperNH_other<- CutQ(LA_CT$perNH_other, 
#                          breaks = quantile(LA_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perHispanic<-df$P007010/df$P007001
# LA_CT$QperHispanic<- CutQ(LA_CT$perHispanic, 
#                           breaks = quantile(LA_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
LA_CT$perworkedfromhome<-df$P030016/df$P030001
# LA_CT$Qperworkedfromhome<- CutQ(LA_CT$perworkedfromhome, 
#                           breaks = quantile(LA_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
LA_CT$perwalked<-df$P030014/df$P030001
# LA_CT$Qperwalked<- CutQ(LA_CT$perwalked, 
#                                 breaks = quantile(LA_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#LAr,truck,van
LA_CT$perLAr_varn_truck<-df$P030002/df$P030001
# LA_CT$QperLAr_varn_truck<- CutQ(LA_CT$perLAr_varn_truck, 
#                         breaks = quantile(LA_CT$perLAr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
LA_CT$permotorcycle<-df$P030012/df$P030001
# LA_CT$Qpermotorcycle<- CutQ(LA_CT$permotorcycle, 
#                                 breaks = quantile(LA_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
LA_CT$perbicycle<-df$P030013/df$P030001
#LA_CT$Qperbicycle<- CutQ(LA_CT$perbicycle, 
#                            breaks = quantile(LA_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# LA_CT$Qperbicycle<- CutQ(LA_CT$perbicycle, 
#                             breaks = quantile(LA_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
LA_CT$perothercommutemeans<-df$P030015<-df$P030001
# LA_CT$Qperothercommutemeans<- CutQ(LA_CT$perothercommutemeans, 
#                          breaks = quantile(LA_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
LA_CT$pertraveltimeless30<-df$P033002/df$P033001
# LA_CT$Qpertraveltimeless30<- CutQ(LA_CT$pertraveltimeless30, 
#                                    breaks = quantile(LA_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_CT$pertraveltime30_44<-df$P033005/df$P033001
# LA_CT$Qpertraveltime30_44<- CutQ(LA_CT$pertraveltime30_44, 
#                                   breaks = quantile(LA_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



LA_CT$pertraveltime45_59<-df$P033008/df$P033001
# LA_CT$pertraveltime45_59<- CutQ(LA_CT$pertraveltime45_59, 
#                                  breaks = quantile(LA_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

LA_CT$pertraveltimemore60<-df$P033011/df$P033001
# LA_CT$Qpertraveltimemore60<- CutQ(LA_CT$pertraveltimemore60, 
#                                 breaks = quantile(LA_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
LA_CT$perurbanized<-df$P005002/df$P005001
# LA_CT$Qperurbanized<- CutQ(LA_CT$perurbanized, 
#                                   breaks = quantile(LA_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perrural<-df$P005005/df$P005001
# LA_CT$Qperrural<- CutQ(LA_CT$perrural, 
#                           breaks = quantile(LA_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# LA_CT$Qperinsideurbanizedareas<- CutQ(LA_CT$perinsideurbanizedareas, 
#                        breaks = quantile(LA_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


LA_CT$perinsideurbancluster<-df$P005004/df$P005001
# LA_CT$Qperinsideurbancluster<- CutQ(LA_CT$perinsideurbancluster, 
#                                       breaks = quantile(LA_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(LA_Tracts,file = "M:\\RESPOND\\CT\\LACT_var2000.csv")
write.csv(LA_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawLACT_neighborvars2000.csv")
write.csv(LA_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\LACT_neighborvars2000.csv")

#-------------------  ------------------------------ ----------------------    -------------------------------


#NJ
NJ_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
NJ_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# NJ_CT$Qpopulation_density<- CutQ(NJ_CT$population_density, 
#                                     breaks = quantile(NJ_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
NJ_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# NJ_CT$Qcrowding<- CutQ(NJ_CT$crowding, 
#                                  breaks = quantile(NJ_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
NJ_CT$renting<-df$H007003/df$H007001

# NJ_CT$Qrenting<- CutQ(NJ_CT$renting, 
#                       breaks = quantile(NJ_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
NJ_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# NJ_CT$Qpernonsinglefamilyunits<- CutQ(NJ_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(NJ_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
NJ_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# NJ_CT$Qpermoreunits<- CutQ(NJ_CT$NJ_CT$permoreunits, 
#                                       breaks = quantile(NJ_CT$NJ_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

NJ_CT$perNonhispanic<-df$P007002/df$P007001
# NJ_CT$QperNonhispanic<- CutQ(NJ_CT$perNonhispanic, 
#                            breaks = quantile(NJ_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_white<-df$P007003/df$P007001
# NJ_CT$QperNH_white<- CutQ(NJ_CT$perNH_white, 
#                              breaks = quantile(NJ_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_black<-df$P007004/df$P007001
# NJ_CT$QperNH_black<- CutQ(NJ_CT$perNH_black, 
#                           breaks = quantile(NJ_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_asian<-df$P007006/df$P007001
# NJ_CT$QperNH_asian<- CutQ(NJ_CT$perNH_asian, 
#                           breaks = quantile(NJ_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_AIAN<-df$P007005/df$P007001
# NJ_CT$QperNH_AIAN<- CutQ(NJ_CT$perNH_AIAN, 
#                           breaks = quantile(NJ_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_NHPI<-df$P007007/df$P007001
# NJ_CT$QperNH_NHPI<- CutQ(NJ_CT$perNH_NHPI, 
#                          breaks = quantile(NJ_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perNH_other<-df$P007008/df$P007001
# NJ_CT$QperNH_other<- CutQ(NJ_CT$perNH_other, 
#                          breaks = quantile(NJ_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perHispanic<-df$P007010/df$P007001
# NJ_CT$QperHispanic<- CutQ(NJ_CT$perHispanic, 
#                           breaks = quantile(NJ_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
NJ_CT$perworkedfromhome<-df$P030016/df$P030001
# NJ_CT$Qperworkedfromhome<- CutQ(NJ_CT$perworkedfromhome, 
#                           breaks = quantile(NJ_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
NJ_CT$perwalked<-df$P030014/df$P030001
# NJ_CT$Qperwalked<- CutQ(NJ_CT$perwalked, 
#                                 breaks = quantile(NJ_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#NJr,truck,van
NJ_CT$perNJr_varn_truck<-df$P030002/df$P030001
# NJ_CT$QperNJr_varn_truck<- CutQ(NJ_CT$perNJr_varn_truck, 
#                         breaks = quantile(NJ_CT$perNJr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
NJ_CT$permotorcycle<-df$P030012/df$P030001
# NJ_CT$Qpermotorcycle<- CutQ(NJ_CT$permotorcycle, 
#                                 breaks = quantile(NJ_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
NJ_CT$perbicycle<-df$P030013/df$P030001
#NJ_CT$Qperbicycle<- CutQ(NJ_CT$perbicycle, 
#                            breaks = quantile(NJ_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# NJ_CT$Qperbicycle<- CutQ(NJ_CT$perbicycle, 
#                             breaks = quantile(NJ_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
NJ_CT$perothercommutemeans<-df$P030015<-df$P030001
# NJ_CT$Qperothercommutemeans<- CutQ(NJ_CT$perothercommutemeans, 
#                          breaks = quantile(NJ_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
NJ_CT$pertraveltimeless30<-df$P033002/df$P033001
# NJ_CT$Qpertraveltimeless30<- CutQ(NJ_CT$pertraveltimeless30, 
#                                    breaks = quantile(NJ_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_CT$pertraveltime30_44<-df$P033005/df$P033001
# NJ_CT$Qpertraveltime30_44<- CutQ(NJ_CT$pertraveltime30_44, 
#                                   breaks = quantile(NJ_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



NJ_CT$pertraveltime45_59<-df$P033008/df$P033001
# NJ_CT$pertraveltime45_59<- CutQ(NJ_CT$pertraveltime45_59, 
#                                  breaks = quantile(NJ_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

NJ_CT$pertraveltimemore60<-df$P033011/df$P033001
# NJ_CT$Qpertraveltimemore60<- CutQ(NJ_CT$pertraveltimemore60, 
#                                 breaks = quantile(NJ_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
NJ_CT$perurbanized<-df$P005002/df$P005001
# NJ_CT$Qperurbanized<- CutQ(NJ_CT$perurbanized, 
#                                   breaks = quantile(NJ_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perrural<-df$P005005/df$P005001
# NJ_CT$Qperrural<- CutQ(NJ_CT$perrural, 
#                           breaks = quantile(NJ_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# NJ_CT$Qperinsideurbanizedareas<- CutQ(NJ_CT$perinsideurbanizedareas, 
#                        breaks = quantile(NJ_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


NJ_CT$perinsideurbancluster<-df$P005004/df$P005001
# NJ_CT$Qperinsideurbancluster<- CutQ(NJ_CT$perinsideurbancluster, 
#                                       breaks = quantile(NJ_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(NJ_Tracts,file = "M:\\RESPOND\\CT\\NJCT_var2000.csv")
write.csv(NJ_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawNJCT_neighborvars2000.csv")
write.csv(NJ_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\NJCT_neighborvars2000.csv")



#-------------------  ------------------------------ ----------------------    -------------------------------


#TX
TX_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
TX_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# TX_CT$Qpopulation_density<- CutQ(TX_CT$population_density, 
#                                     breaks = quantile(TX_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
TX_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# TX_CT$Qcrowding<- CutQ(TX_CT$crowding, 
#                                  breaks = quantile(TX_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
TX_CT$renting<-df$H007003/df$H007001

# TX_CT$Qrenting<- CutQ(TX_CT$renting, 
#                       breaks = quantile(TX_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
TX_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# TX_CT$Qpernonsinglefamilyunits<- CutQ(TX_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(TX_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
TX_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# TX_CT$Qpermoreunits<- CutQ(TX_CT$TX_CT$permoreunits, 
#                                       breaks = quantile(TX_CT$TX_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

TX_CT$perNonhispanic<-df$P007002/df$P007001
# TX_CT$QperNonhispanic<- CutQ(TX_CT$perNonhispanic, 
#                            breaks = quantile(TX_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_white<-df$P007003/df$P007001
# TX_CT$QperNH_white<- CutQ(TX_CT$perNH_white, 
#                              breaks = quantile(TX_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_black<-df$P007004/df$P007001
# TX_CT$QperNH_black<- CutQ(TX_CT$perNH_black, 
#                           breaks = quantile(TX_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_asian<-df$P007006/df$P007001
# TX_CT$QperNH_asian<- CutQ(TX_CT$perNH_asian, 
#                           breaks = quantile(TX_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_AIAN<-df$P007005/df$P007001
# TX_CT$QperNH_AIAN<- CutQ(TX_CT$perNH_AIAN, 
#                           breaks = quantile(TX_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_NHPI<-df$P007007/df$P007001
# TX_CT$QperNH_NHPI<- CutQ(TX_CT$perNH_NHPI, 
#                          breaks = quantile(TX_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perNH_other<-df$P007008/df$P007001
# TX_CT$QperNH_other<- CutQ(TX_CT$perNH_other, 
#                          breaks = quantile(TX_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perHispanic<-df$P007010/df$P007001
# TX_CT$QperHispanic<- CutQ(TX_CT$perHispanic, 
#                           breaks = quantile(TX_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
TX_CT$perworkedfromhome<-df$P030016/df$P030001
# TX_CT$Qperworkedfromhome<- CutQ(TX_CT$perworkedfromhome, 
#                           breaks = quantile(TX_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
TX_CT$perwalked<-df$P030014/df$P030001
# TX_CT$Qperwalked<- CutQ(TX_CT$perwalked, 
#                                 breaks = quantile(TX_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#TXr,truck,van
TX_CT$perTXr_varn_truck<-df$P030002/df$P030001
# TX_CT$QperTXr_varn_truck<- CutQ(TX_CT$perTXr_varn_truck, 
#                         breaks = quantile(TX_CT$perTXr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
TX_CT$permotorcycle<-df$P030012/df$P030001
# TX_CT$Qpermotorcycle<- CutQ(TX_CT$permotorcycle, 
#                                 breaks = quantile(TX_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
TX_CT$perbicycle<-df$P030013/df$P030001
#TX_CT$Qperbicycle<- CutQ(TX_CT$perbicycle, 
#                            breaks = quantile(TX_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# TX_CT$Qperbicycle<- CutQ(TX_CT$perbicycle, 
#                             breaks = quantile(TX_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
TX_CT$perothercommutemeans<-df$P030015<-df$P030001
# TX_CT$Qperothercommutemeans<- CutQ(TX_CT$perothercommutemeans, 
#                          breaks = quantile(TX_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
TX_CT$pertraveltimeless30<-df$P033002/df$P033001
# TX_CT$Qpertraveltimeless30<- CutQ(TX_CT$pertraveltimeless30, 
#                                    breaks = quantile(TX_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_CT$pertraveltime30_44<-df$P033005/df$P033001
# TX_CT$Qpertraveltime30_44<- CutQ(TX_CT$pertraveltime30_44, 
#                                   breaks = quantile(TX_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



TX_CT$pertraveltime45_59<-df$P033008/df$P033001
# TX_CT$pertraveltime45_59<- CutQ(TX_CT$pertraveltime45_59, 
#                                  breaks = quantile(TX_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

TX_CT$pertraveltimemore60<-df$P033011/df$P033001
# TX_CT$Qpertraveltimemore60<- CutQ(TX_CT$pertraveltimemore60, 
#                                 breaks = quantile(TX_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
TX_CT$perurbanized<-df$P005002/df$P005001
# TX_CT$Qperurbanized<- CutQ(TX_CT$perurbanized, 
#                                   breaks = quantile(TX_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perrural<-df$P005005/df$P005001
# TX_CT$Qperrural<- CutQ(TX_CT$perrural, 
#                           breaks = quantile(TX_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# TX_CT$Qperinsideurbanizedareas<- CutQ(TX_CT$perinsideurbanizedareas, 
#                        breaks = quantile(TX_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


TX_CT$perinsideurbancluster<-df$P005004/df$P005001
# TX_CT$Qperinsideurbancluster<- CutQ(TX_CT$perinsideurbancluster, 
#                                       breaks = quantile(TX_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(TX_Tracts,file = "M:\\RESPOND\\CT\\TXCT_var2000.csv")
write.csv(TX_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawTXCT_neighborvars2000.csv")
write.csv(TX_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\TXCT_neighborvars2000.csv")
#-------------------  ------------------------------ ----------------------    -------------------------------


#MI
MI_Tracts<- getCensus(name = 'sf3', vintage = myvintage, vars = Vars_List,
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

#Population density
MI_CT$population_density<-df$POP100/(as.numeric(df$AREALAND)/2589988)
# MI_CT$Qpopulation_density<- CutQ(MI_CT$population_density, 
#                                     breaks = quantile(MI_CT$population_density, seq(0, 1, by = 0.20), na.rm = TRUE)) 

##Housing Characteristics
#Crowding
sum_list<-c("H020005","H020006","H020007","H020011","H020012","H020013")
MI_CT$crowding <- (rowSums(df[,sum_list],na.rm = T)/df$H020001)

# MI_CT$Qcrowding<- CutQ(MI_CT$crowding, 
#                                  breaks = quantile(MI_CT$crowding, seq(0, 1, by = 0.20), na.rm = TRUE))


#Renting
MI_CT$renting<-df$H007003/df$H007001

# MI_CT$Qrenting<- CutQ(MI_CT$renting, 
#                       breaks = quantile(MI_CT$renting, seq(0, 1, by = 0.20), na.rm = TRUE))


#FamilyUnits
MI_CT$pernonsinglefamilyunits<-(df$H030001-(df$H030002+df$H030003))/df$H030001

# MI_CT$Qpernonsinglefamilyunits<- CutQ(MI_CT$pernonsinglefamilyunits, 
#                      breaks = quantile(MI_CT$pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

#more than 10units
sum_list<-c("H030007","H030008","H030009")
MI_CT$permoreunits<-(rowSums(df[,sum_list],na.rm = T))/df$H030001

# MI_CT$Qpermoreunits<- CutQ(MI_CT$MI_CT$permoreunits, 
#                                       breaks = quantile(MI_CT$MI_CT$permoreunits, seq(0, 1, by = 0.20), na.rm = TRUE))

##Race/ethnicity

MI_CT$perNonhispanic<-df$P007002/df$P007001
# MI_CT$QperNonhispanic<- CutQ(MI_CT$perNonhispanic, 
#                            breaks = quantile(MI_CT$perNonhispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_white<-df$P007003/df$P007001
# MI_CT$QperNH_white<- CutQ(MI_CT$perNH_white, 
#                              breaks = quantile(MI_CT$perNH_white, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_black<-df$P007004/df$P007001
# MI_CT$QperNH_black<- CutQ(MI_CT$perNH_black, 
#                           breaks = quantile(MI_CT$perNH_black, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_asian<-df$P007006/df$P007001
# MI_CT$QperNH_asian<- CutQ(MI_CT$perNH_asian, 
#                           breaks = quantile(MI_CT$perNH_asian, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_AIAN<-df$P007005/df$P007001
# MI_CT$QperNH_AIAN<- CutQ(MI_CT$perNH_AIAN, 
#                           breaks = quantile(MI_CT$perNH_AIAN, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_NHPI<-df$P007007/df$P007001
# MI_CT$QperNH_NHPI<- CutQ(MI_CT$perNH_NHPI, 
#                          breaks = quantile(MI_CT$perNH_NHPI, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perNH_other<-df$P007008/df$P007001
# MI_CT$QperNH_other<- CutQ(MI_CT$perNH_other, 
#                          breaks = quantile(MI_CT$perNH_other, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perHispanic<-df$P007010/df$P007001
# MI_CT$QperHispanic<- CutQ(MI_CT$perHispanic, 
#                           breaks = quantile(MI_CT$perHispanic, seq(0, 1, by = 0.20), na.rm = TRUE))


##Commute
#worked from home
MI_CT$perworkedfromhome<-df$P030016/df$P030001
# MI_CT$Qperworkedfromhome<- CutQ(MI_CT$perworkedfromhome, 
#                           breaks = quantile(MI_CT$perworkedfromhome, seq(0, 1, by = 0.20), na.rm = TRUE))

#walked
MI_CT$perwalked<-df$P030014/df$P030001
# MI_CT$Qperwalked<- CutQ(MI_CT$perwalked, 
#                                 breaks = quantile(MI_CT$perwalked, seq(0, 1, by = 0.20), na.rm = TRUE))

#MIr,truck,van
MI_CT$perMIr_varn_truck<-df$P030002/df$P030001
# MI_CT$QperMIr_varn_truck<- CutQ(MI_CT$perMIr_varn_truck, 
#                         breaks = quantile(MI_CT$perMIr_varn_truck, seq(0, 1, by = 0.20), na.rm = TRUE))


#motercycle
MI_CT$permotorcycle<-df$P030012/df$P030001
# MI_CT$Qpermotorcycle<- CutQ(MI_CT$permotorcycle, 
#                                 breaks = quantile(MI_CT$permotorcycle, seq(0, 1, by = 0.20), na.rm = TRUE))


#bike
MI_CT$perbicycle<-df$P030013/df$P030001
#MI_CT$Qperbicycle<- CutQ(MI_CT$perbicycle, 
#                            breaks = quantile(MI_CT$perbicycle, seq(0,1, by = 0.20), na.rm = TRUE))

# MI_CT$Qperbicycle<- CutQ(MI_CT$perbicycle, 
#                             breaks = quantile(MI_CT$perbicycle, seq(0, 1, by = 0.20), na.rm = F))

#other
MI_CT$perothercommutemeans<-df$P030015<-df$P030001
# MI_CT$Qperothercommutemeans<- CutQ(MI_CT$perothercommutemeans, 
#                          breaks = quantile(MI_CT$perothercommutemeans, seq(0, 1, by = 0.20), na.rm = TRUE))

#%length of time
MI_CT$pertraveltimeless30<-df$P033002/df$P033001
# MI_CT$Qpertraveltimeless30<- CutQ(MI_CT$pertraveltimeless30, 
#                                    breaks = quantile(MI_CT$pertraveltimeless30, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_CT$pertraveltime30_44<-df$P033005/df$P033001
# MI_CT$Qpertraveltime30_44<- CutQ(MI_CT$pertraveltime30_44, 
#                                   breaks = quantile(MI_CT$pertraveltime30_44, seq(0, 1, by = 0.20), na.rm = TRUE))



MI_CT$pertraveltime45_59<-df$P033008/df$P033001
# MI_CT$pertraveltime45_59<- CutQ(MI_CT$pertraveltime45_59, 
#                                  breaks = quantile(MI_CT$pertraveltime45_59, seq(0, 1, by = 0.20), na.rm = TRUE))

MI_CT$pertraveltimemore60<-df$P033011/df$P033001
# MI_CT$Qpertraveltimemore60<- CutQ(MI_CT$pertraveltimemore60, 
#                                 breaks = quantile(MI_CT$pertraveltimemore60, seq(0, 1, by = 0.20), na.rm = TRUE))


#Rural/urban measure
MI_CT$perurbanized<-df$P005002/df$P005001
# MI_CT$Qperurbanized<- CutQ(MI_CT$perurbanized, 
#                                   breaks = quantile(MI_CT$perurbanized, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perrural<-df$P005005/df$P005001
# MI_CT$Qperrural<- CutQ(MI_CT$perrural, 
#                           breaks = quantile(MI_CT$perrural, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perinsideurbanizedareas<-df$P005003/df$P005001
# MI_CT$Qperinsideurbanizedareas<- CutQ(MI_CT$perinsideurbanizedareas, 
#                        breaks = quantile(MI_CT$perinsideurbanizedareas, seq(0, 1, by = 0.20), na.rm = TRUE))


MI_CT$perinsideurbancluster<-df$P005004/df$P005001
# MI_CT$Qperinsideurbancluster<- CutQ(MI_CT$perinsideurbancluster, 
#                                       breaks = quantile(MI_CT$perinsideurbancluster, seq(0, 1, by = 0.20), na.rm = TRUE))


#write.csv(MI_Tracts,file = "M:\\RESPOND\\CT\\MICT_var2000.csv")
write.csv(MI_Tracts,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\rawMICT_neighborvars2000.csv")
write.csv(MI_CT,file = "M:\\RESPOND\\2000\\CT\\neighborhood_vars\\MICT_neighborvars2000.csv")

