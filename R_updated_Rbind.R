library(DescTools)
library(descr)
library(stringr)
library(readxl)

CA_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\CA\\Census tracts_00\\CA_CT00_SES_neigh_bayer_gibbons.csv")
FL_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\FL\\Census tracts_00\\FL_CT00_SES_neigh_bayer_gibbons.csv")
LA_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\LA\\Census tracts_00\\LA_CT00_SES_neigh_bayer_gibbons.csv")
NJ_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\NJ\\Census tracts_00\\NJ_CT00_SES_neigh_bayer_gibbons.csv")
TX_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\TX\\Census tracts_00\\TX_CT00_SES_neigh_bayer_gibbons.csv")
MI_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\MI\\Census tracts_00\\MI_CT00_SES_neigh_bayer_gibbons.csv")
GA_CT00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\GA\\Census tracts_00\\GA_CT00_SES_neigh_bayer_gibbons.csv")

l=list(CA_CT00,FL_CT00,LA_CT00,NJ_CT00,TX_CT00,MI_CT00,GA_CT00)
k<-do.call("rbind",l)

k$State<-str_pad(k$State,2,"left","0")
k$County<-str_pad(k$County,3,"left","0")
k$Tract<-str_pad(k$Tract,6,"left","0")
k$ID<-paste0(k$State,k$County,k$Tract)


Gibbons<-read.csv("T:\\Aim 1\\Neighborhood data\\Gibbons typology\\Gibbons_Typology_2000.csv")
Gibbons$tractid1<-str_pad(Gibbons$tractid,11,"left","0")
Gibbons$state<-substr(Gibbons$tractid1,1,2)

k$CT00_lq_nhwhite<-NULL
k$CT00_lq_hispanic<-NULL
k$CT00_lq_white<-NULL
k$CT00_lq_black<-NULL
k$CT00_nhood_00v2<-NULL
k$CT00_Redline<-NULL
k$CT00_EthBias<-NULL
k$CT00_RacBias<-NULL


k_gibbons<-merge(k,Gibbons,by.x = "ID",by.y="tractid1",all.x = T)

Beyer<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\tract00_StrRac7.xlsx")
Beyer$state<-substr(Beyer$TractID00,1,2)

k_gibbons_Beyer<-merge(k_gibbons,Beyer,by.x ="ID",by.y = "TractID00",all.x = T)

MSA_LQ<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\tract00_MSA2000_lq_7states.xlsx")
MSA_LQ$state<-substr(MSA_LQ$TractID00,1,2)

k_gibbons_Beyer_MSA<-merge(k_gibbons_Beyer,MSA_LQ,by.x ="ID",by.y = "TractID00",all.x = T)

k_gibbons_Beyer_MSA<-subset(k_gibbons_Beyer_MSA,k_gibbons_Beyer_MSA$Tract!="000000")


k_gibbons_Beyer_MSA$X<-NULL
k_gibbons_Beyer_MSA$State<-NULL
k_gibbons_Beyer_MSA$County<-NULL
k_gibbons_Beyer_MSA$Tract<-NULL
k_gibbons_Beyer_MSA$state.y<-NULL
k_gibbons_Beyer_MSA$state<-NULL
k_gibbons_Beyer_MSA$state.x<-NULL
k_gibbons_Beyer_MSA$CT00_perNonhispanic<-NULL
k_gibbons_Beyer_MSA$CT00_perNH_asian<-NULL
k_gibbons_Beyer_MSA$CT00_perNH_AIAN<-NULL
k_gibbons_Beyer_MSA$CT00_perNH_NHPI<-NULL
k_gibbons_Beyer_MSA$CT00_perNH_other<-NULL
k_gibbons_Beyer_MSA$CT00_perHispanic<-NULL
k_gibbons_Beyer_MSA$EthBias<-NULL
k_gibbons_Beyer_MSA$tractid<-NULL

colnames(k_gibbons_Beyer_MSA)[1]<-"CT00_geoID"
colnames(k_gibbons_Beyer_MSA)[43]<-"CT00_nhood_00v2"
colnames(k_gibbons_Beyer_MSA)[44]<-"CT00_RacBias"
colnames(k_gibbons_Beyer_MSA)[45]<-"CT00_Redline"
colnames(k_gibbons_Beyer_MSA)[46]<-"CT00_lq_black"
colnames(k_gibbons_Beyer_MSA)[47]<-"CT00_lq_white"
colnames(k_gibbons_Beyer_MSA)[48]<-"CT00_lq_hispanic"
colnames(k_gibbons_Beyer_MSA)[49]<-"CT00_lq_nhwhite"

k_gibbons_Beyer_MSA$CT00_geoID<-as.character(k_gibbons_Beyer_MSA$CT00_geoID)

#write.csv(k_gibbons_Beyer_MSA,"M:\\RESPOND\\2000\\CT\\Combined_2000\\CT00_RespondStates.csv")

#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------
CA_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\CA\\Block groups_00\\CA_BG00_SES_neigh_bayer_gibbons.csv")
FL_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\FL\\Block groups_00\\FL_BG00_SES_neigh_bayer_gibbons.csv")
LA_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\LA\\Block groups_00\\LA_BG00_SES_neigh_bayer_gibbons.csv")
NJ_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\NJ\\Block groups_00\\NJ_BG00_SES_neigh_bayer_gibbons.csv")
TX_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\TX\\Block groups_00\\TX_BG00_SES_neigh_bayer_gibbons.csv")
MI_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\MI\\Block groups_00\\MI_BG00_SES_neigh_bayer_gibbons.csv")
GA_BG00<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2000\\GA\\Block groups_00\\GA_BG00_SES_neigh_bayer_gibbons.csv")


l=list(CA_BG00,FL_BG00,LA_BG00,NJ_BG00,TX_BG00,MI_BG00,GA_BG00)
k<-do.call("rbind",l)

k$State<-str_pad(k$State,2,"left","0")
k$County<-str_pad(k$County,3,"left","0")
k$Tract<-str_pad(k$Tract,6,"left","0")
k$ID<-paste0(k$State,k$County,k$Tract,k$BG)

k<-subset(k,k$Tract!="000000")

Gibbons<-read.csv("M:\\RESPOND\\Gibbons\\blockgroup_typology_00.csv")
#Gibbons1<-read.csv("T:\\Aim 1\\Neighborhood data\\Gibbons typology\\blockgroup_typology_00.csv")
Gibbons$GEOID<-str_pad(Gibbons$GEOID,12,"left","0")
Gibbons$state<-substr(Gibbons$GEOID,1,2)

k$BG00_lq_nhwhite<-NULL
k$BG00_lq_hispanic<-NULL
k$BG00_lq_white<-NULL
k$BG00_lq_black<-NULL
k$BG00_nhood_00v2<-NULL
k$BG00_Redline<-NULL
k$BG00_EthBias<-NULL
k$BG00_RacBias<-NULL

k_gibbons<-merge(k,Gibbons,by.x = "ID",by.y="GEOID",all.x = T)

Beyer<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\blockgroup00_StrRac7.xlsx")
Beyer$state<-substr(Beyer$BGID00,1,2)

k_gibbons_Beyer<-merge(k_gibbons,Beyer,by.x ="ID",by.y = "BGID00",all.x = T)

MSA_LQ<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\blockgroup00_MSA2000_lq_7states.xlsx")
MSA_LQ$state<-substr(MSA_LQ$BGID00,1,2)


k_gibbons_Beyer_MSA<-merge(k_gibbons_Beyer,MSA_LQ,by.x ="ID",by.y = "BGID00",all.x = T)

k_gibbons_Beyer_MSA$X<-NULL
k_gibbons_Beyer_MSA$State<-NULL
k_gibbons_Beyer_MSA$County<-NULL
k_gibbons_Beyer_MSA$Tract<-NULL
k_gibbons_Beyer_MSA$state.y<-NULL
k_gibbons_Beyer_MSA$state<-NULL
k_gibbons_Beyer_MSA$state.x<-NULL
k_gibbons_Beyer_MSA$BG00_perNonhispanic<-NULL
k_gibbons_Beyer_MSA$BG00_perNH_asian<-NULL
k_gibbons_Beyer_MSA$BG00_perNH_AIAN<-NULL
k_gibbons_Beyer_MSA$BG00_perNH_NHPI<-NULL
k_gibbons_Beyer_MSA$BG00_perNH_other<-NULL
k_gibbons_Beyer_MSA$BG00_perHispanic<-NULL
k_gibbons_Beyer_MSA$EthBias<-NULL

k_gibbons_Beyer_MSA$BG<-NULL
k_gibbons_Beyer_MSA$white00pct<-NULL
k_gibbons_Beyer_MSA$black00pct<-NULL
k_gibbons_Beyer_MSA$asian00pct<-NULL
k_gibbons_Beyer_MSA$hisp00pct<-NULL
k_gibbons_Beyer_MSA$BG00_black00pct<-NULL

colnames(k_gibbons_Beyer_MSA)[1]<-"BG00_geoID"
colnames(k_gibbons_Beyer_MSA)[43]<-"BG00_nhood_00v2"
colnames(k_gibbons_Beyer_MSA)[44]<-"BG00_RacBias"
colnames(k_gibbons_Beyer_MSA)[45]<-"BG00_Redline"
colnames(k_gibbons_Beyer_MSA)[46]<-"BG00_lq_black"
colnames(k_gibbons_Beyer_MSA)[47]<-"BG00_lq_white"
colnames(k_gibbons_Beyer_MSA)[48]<-"BG00_lq_hispanic"
colnames(k_gibbons_Beyer_MSA)[49]<-"BG00_lq_nhwhite"

write.csv(k_gibbons_Beyer_MSA,"M:\\RESPOND\\2000\\BG\\Combined_2000\\BG00_RespondStates.csv")

#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------

library(stringr)
library(readxl)

CA_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\CA\\Census tracts_10\\CA_CT10_SES_neigh_bayer_gibbons.csv")
FL_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\FL\\Census tracts_10\\FL_CT10_SES_neigh_bayer_gibbons.csv")
LA_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\LA\\Census tracts_10\\LA_CT10_SES_neigh_bayer_gibbons.csv")
NJ_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\NJ\\Census tracts_10\\NJ_CT10_SES_neigh_bayer_gibbons.csv")
TX_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\TX\\Census tracts_10\\TX_CT10_SES_neigh_bayer_gibbons.csv")
MI_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\MI\\Census tracts_10\\MI_CT10_SES_neigh_bayer_gibbons.csv")
GA_CT10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\GA\\Census tracts_10\\GA_CT10_SES_neigh_bayer_gibbons.csv")


l=list(CA_CT10,FL_CT10,LA_CT10,NJ_CT10,TX_CT10,MI_CT10,GA_CT10)
k<-do.call("rbind",l)

k$State<-str_pad(k$State,2,"left","0")
k$County<-str_pad(k$County,3,"left","0")
k$Tract<-str_pad(k$Tract,6,"left","0")
k$ID<-paste0(k$State,k$County,k$Tract)

Gibbons<-read.csv("T:\\Aim 1\\Neighborhood data\\Gibbons typology\\gibbons_typology_full.csv")
Gibbons$TRTID10<-str_pad(Gibbons$TRTID10,11,"left","0")
Gibbons$state<-substr(Gibbons$TRTID10,1,2)

k$CT10_lq_nhwhite<-NULL
k$CT10_lq_hispanic<-NULL
k$CT10_lq_white<-NULL
k$CT10_lq_black<-NULL
k$CT10_nhood_00v2<-NULL
k$CT10_Redline<-NULL
k$CT10_EthBias<-NULL
k$CT10_RacBias<-NULL

k_gibbons<-merge(k,Gibbons,by.x = "ID",by.y="TRTID10",all.x = T)

Beyer<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\tract10_StrRac7.xlsx")
Beyer$state<-substr(Beyer$TractID10,1,2)

k_gibbons_Beyer<-merge(k_gibbons,Beyer,by.x ="ID",by.y = "TractID10",all.x = T)

MSA_LQ<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\tract10_MSA2010_lq_7states.xlsx")
MSA_LQ$state<-substr(MSA_LQ$TractID10  ,1,2)

k_gibbons_Beyer_MSA<-merge(k_gibbons_Beyer,MSA_LQ,by.x ="ID",by.y = "TractID10",all.x = T)

k_gibbons_Beyer_MSA<-subset(k_gibbons_Beyer_MSA,k_gibbons_Beyer_MSA$Tract!="000000")


k_gibbons_Beyer_MSA$X<-NULL
k_gibbons_Beyer_MSA$State<-NULL
k_gibbons_Beyer_MSA$state<-NULL
k_gibbons_Beyer_MSA$County<-NULL
k_gibbons_Beyer_MSA$county<-NULL
k_gibbons_Beyer_MSA$Tract<-NULL
k_gibbons_Beyer_MSA$tract<-NULL
k_gibbons_Beyer_MSA$state.y<-NULL
k_gibbons_Beyer_MSA$state<-NULL
k_gibbons_Beyer_MSA$state.x<-NULL
k_gibbons_Beyer_MSA$CT10_perNonhispanic<-NULL
k_gibbons_Beyer_MSA$CT10_perNH_asian<-NULL
k_gibbons_Beyer_MSA$CT10_perNH_AIAN<-NULL
k_gibbons_Beyer_MSA$CT10_perNH_NHPI<-NULL
k_gibbons_Beyer_MSA$CT10_perNH_other<-NULL
k_gibbons_Beyer_MSA$CT10_perHispanic<-NULL
k_gibbons_Beyer_MSA$EthBias<-NULL
k_gibbons_Beyer_MSA$tractid<-NULL
k_gibbons_Beyer_MSA$CT10_cnhood_10<-NULL
k_gibbons_Beyer_MSA$placefp10<-NULL
k_gibbons_Beyer_MSA$cbsa10<-NULL
k_gibbons_Beyer_MSA$nhood_90v2<-NULL
k_gibbons_Beyer_MSA$nhood_00v2<-NULL
k_gibbons_Beyer_MSA$cnhood_00<-NULL
k_gibbons_Beyer_MSA$cnhood_10<-NULL

colnames(k_gibbons_Beyer_MSA)[1]<-"CT10_geoID"
colnames(k_gibbons_Beyer_MSA)[41]<-"CT10_nhood_00v2"
colnames(k_gibbons_Beyer_MSA)[42]<-"CT10_RacBias"
colnames(k_gibbons_Beyer_MSA)[43]<-"CT10_Redline"
colnames(k_gibbons_Beyer_MSA)[44]<-"CT10_lq_black"
colnames(k_gibbons_Beyer_MSA)[45]<-"CT10_lq_white"
colnames(k_gibbons_Beyer_MSA)[46]<-"CT10_lq_hispanic"
colnames(k_gibbons_Beyer_MSA)[47]<-"CT10_lq_nhwhite"

#write.csv(k_gibbons_Beyer_MSA,"M:\\RESPOND\\2010\\CT\\Combined_2010\\CT10_RespondStates.csv")

#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------

library(stringr)
library(readxl)

CA_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\CA\\Block groups_10\\CA_BG10_SES_neigh_bayer_gibbons.csv")
FL_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\FL\\Block groups_10\\FL_BG10_SES_neigh_bayer_gibbons.csv")
LA_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\LA\\Block groups_10\\LA_BG10_SES_neigh_bayer_gibbons.csv")
NJ_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\NJ\\Block groups_10\\NJ_BG10_SES_neigh_bayer_gibbons.csv")
TX_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\TX\\Block groups_10\\TX_BG10_SES_neigh_bayer_gibbons.csv")
MI_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\MI\\Block groups_10\\MI_BG10_SES_neigh_bayer_gibbons.csv")
GA_BG10<-read.csv("M:\\RESPOND\\T_folder_bkup_16May19\\2010\\GA\\Block groups_10\\GA_BG10_SES_neigh_bayer_gibbons.csv")

l=list(CA_BG10,FL_BG10,LA_BG10,NJ_BG10,TX_BG10,MI_BG10,GA_BG10)
k<-do.call("rbind",l)

k$State<-str_pad(k$State,2,"left","0")
k$County<-str_pad(k$County,3,"left","0")
k$Tract<-str_pad(k$Tract,6,"left","0")
k$ID<-paste0(k$State,k$County,k$Tract,k$BG)
k<-subset(k,k$Tract!="000000")

Gibbons<-read.csv("T:\\Aim 1\\Neighborhood data\\Gibbons typology\\blockgroup_typology_10.csv")
Gibbons$GEOID<-str_pad(Gibbons$GEOID,12,"left","0")
Gibbons$state<-substr(Gibbons$GEOID,1,2)


k$BG10_lq_nhwhite<-NULL
k$BG10_lq_hispanic<-NULL
k$BG10_lq_white<-NULL
k$BG10_lq_black<-NULL
k$BG10_nhood_00v2<-NULL
k$BG10_Redline<-NULL
k$BG10_EthBias<-NULL
k$BG10_RacBias<-NULL


k_gibbons<-merge(k,Gibbons,by.x = "ID",by.y="GEOID",all.x = T)

Beyer<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\blockgroup10_StrRac7.xlsx")
Beyer$state<-substr(Beyer$BGID10,1,2)

k_gibbons_Beyer<-merge(k_gibbons,Beyer,by.x ="ID",by.y = "BGID10",all.x = T)


MSA_LQ<-read_excel("T:\\Aim 1\\Neighborhood data\\Beyer structural racism\\blockgroup10_MSA2010_lq_7states.xlsx")
MSA_LQ$state<-substr(MSA_LQ$BGID10,1,2)


k_gibbons_Beyer_MSA<-merge(k_gibbons_Beyer,MSA_LQ,by.x ="ID",by.y = "BGID10",all.x = T)

k_gibbons_Beyer_MSA$X<-NULL
k_gibbons_Beyer_MSA$State<-NULL
k_gibbons_Beyer_MSA$County<-NULL
k_gibbons_Beyer_MSA$Tract<-NULL
k_gibbons_Beyer_MSA$state.y<-NULL
k_gibbons_Beyer_MSA$state<-NULL
k_gibbons_Beyer_MSA$state.x<-NULL
k_gibbons_Beyer_MSA$BG10_perNonhispanic<-NULL
k_gibbons_Beyer_MSA$BG10_perNH_asian<-NULL
k_gibbons_Beyer_MSA$BG10_perNH_AIAN<-NULL
k_gibbons_Beyer_MSA$BG10_perNH_NHPI<-NULL
k_gibbons_Beyer_MSA$BG10_perNH_other<-NULL
k_gibbons_Beyer_MSA$BG10_perHispanic<-NULL
k_gibbons_Beyer_MSA$EthBias<-NULL

k_gibbons_Beyer_MSA$BG<-NULL
k_gibbons_Beyer_MSA$white10pct<-NULL
k_gibbons_Beyer_MSA$black10pct<-NULL
k_gibbons_Beyer_MSA$black00pct<-NULL
k_gibbons_Beyer_MSA$asian10pct<-NULL
k_gibbons_Beyer_MSA$hisp10pct<-NULL
k_gibbons_Beyer_MSA$BG10_black00pct<-NULL

colnames(k_gibbons_Beyer_MSA)[1]<-"BG10_geoID"
colnames(k_gibbons_Beyer_MSA)[36]<-"BG10_nhood_10v2"
colnames(k_gibbons_Beyer_MSA)[37]<-"BG10_RacBias"
colnames(k_gibbons_Beyer_MSA)[38]<-"BG10_Redline"
colnames(k_gibbons_Beyer_MSA)[39]<-"BG10_lq_black"
colnames(k_gibbons_Beyer_MSA)[40]<-"BG10_lq_white"
colnames(k_gibbons_Beyer_MSA)[41]<-"BG10_lq_hispanic"
colnames(k_gibbons_Beyer_MSA)[42]<-"BG10_lq_nhwhite"

#write.csv(k_gibbons_Beyer_MSA,"M:\\RESPOND\\2010\\BG\\Combined_2010\\BG10_RespondStates.csv")

#Import datasets
CT00_RespondStates<-read.csv("M:\\RESPOND\\2000\\CT\\Combined_2000\\CT00_RespondStates.csv")
BG00_RespondStates<-read.csv("M:\\RESPOND\\2000\\BG\\Combined_2000\\BG00_RespondStates.csv")
CT10_RespondStates<-read.csv("M:\\RESPOND\\2010\\CT\\Combined_2010\\CT10_RespondStates.csv")
BG10_RespondStates<-read.csv("M:\\RESPOND\\2010\\BG\\Combined_2010\\BG10_RespondStates.csv")


CT00_RespondStates<-k_gibbons_Beyer_MSA

CT00_RespondStates$CT00_geoID<-as.String(str_pad(CT00_RespondStates$CT00_geoID,11,"left","0"))
CT00_RespondStates$state<-substr(CT00_RespondStates$CT00_geoID,1,2)
table(CT00_RespondStates$state)

CA_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="06")
CA_CT00$X<-NULL
CA_CT00$state<-NULL
write.csv(CA_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\CA1_CT00.csv")


FL_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="12")
FL_CT00$X<-NULL
FL_CT00$state<-NULL
write.csv(FL_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\FL_CT00.csv")


GA_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="13")
GA_CT00$X<-NULL
GA_CT00$state<-NULL
write.csv(GA_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\GA_CT00.csv")

LA_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="22")
LA_CT00$X<-NULL
LA_CT00$state<-NULL
write.csv(LA_CT00

MI_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="26")
MI_CT00$X<-NULL
MI_CT00$state<-NULL
write.csv(MI_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\MI_CT00.csv")

NJ_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="34")
NJ_CT00$X<-NULL
NJ_CT00$state<-NULL
write.csv(NJ_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\NJ_CT00.csv")

TX_CT00<-subset(CT00_RespondStates,CT00_RespondStates$state=="48")
TX_CT00$X<-NULL
TX_CT00$state<-NULL
write.csv(TX_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\TX_CT00.csv")

#------------------------------------------------------------------------------------------------------------------------------

#CT2010

CT10_RespondStates$CT10_geoID<-as.character(str_pad(CT10_RespondStates$CT10_geoID,11,"left","0"))
CT10_RespondStates$state<-substr(CT10_RespondStates$CT10_geoID,1,2)
table(CT10_RespondStates$state)

CA_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="06")
CA_CT10$X<-NULL
CA_CT10$state<-NULL
write.csv(CA_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\CA_CT10.csv")


FL_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="12")
FL_CT10$X<-NULL
FL_CT10$state<-NULL
write.csv(FL_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\FL_CT10.csv")


GA_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="13")
GA_CT10$X<-NULL
GA_CT10$state<-NULL
write.csv(GA_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\GA_CT10.csv")

LA_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="22")
LA_CT10$X<-NULL
LA_CT10$state<-NULL
write.csv(LA_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\LA_CT10.csv")

MI_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="26")
MI_CT10$X<-NULL
MI_CT10$state<-NULL
write.csv(MI_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\MI_CT10.csv")

NJ_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="34")
NJ_CT10$X<-NULL
NJ_CT10$state<-NULL
write.csv(NJ_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\NJ_CT10.csv")

TX_CT10<-subset(CT10_RespondStates,CT10_RespondStates$state=="48")
TX_CT10$X<-NULL
TX_CT10$state<-NULL
write.csv(TX_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\TX_CT10.csv")


#------------------------------------------------------------------------------

BG00_RespondStates$BG00_geoID<-as.character(str_pad(BG00_RespondStates$BG00_geoID,12,"left","0"))
BG00_RespondStates$state<-substr(BG00_RespondStates$BG00_geoID,1,2)
table(BG00_RespondStates$state)

CA_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="06")
CA_BG00$X<-NULL
CA_BG00$state<-NULL
write.csv(CA_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\CA_BG00.csv")


FL_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="12")
FL_BG00$X<-NULL
FL_BG00$state<-NULL
write.csv(FL_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\FL_BG00.csv")


GA_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="13")
GA_BG00$X<-NULL
GA_BG00$state<-NULL
write.csv(GA_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\GA_BG00.csv")

LA_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="22")
LA_BG00$X<-NULL
LA_BG00$state<-NULL
write.csv(LA_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\LA_BG00.csv")

MI_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="26")
MI_BG00$X<-NULL
MI_BG00$state<-NULL
write.csv(MI_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\MI_BG00.csv")

NJ_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="34")
NJ_BG00$X<-NULL
NJ_BG00$state<-NULL
write.csv(NJ_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\NJ_BG00.csv")

TX_BG00<-subset(BG00_RespondStates,BG00_RespondStates$state=="48")
TX_BG00$X<-NULL
TX_BG00$state<-NULL
write.csv(TX_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\TX_BG00.csv")

#------------------------------------------------------------------------------------------------------------------------------

#BG2010

BG10_RespondStates$BG10_geoID<-as.character(str_pad(BG10_RespondStates$BG10_geoID,12,"left","0"))
BG10_RespondStates$state<-substr(BG10_RespondStates$BG10_geoID,1,2)
table(BG10_RespondStates$state)

CA_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="06")
CA_BG10$X<-NULL
CA_BG10$state<-NULL
write.csv(CA_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\CA_BG10.csv")


FL_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="12")
FL_BG10$X<-NULL
FL_BG10$state<-NULL
write.csv(FL_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\FL_BG10.csv")


GA_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="13")
GA_BG10$X<-NULL
GA_BG10$state<-NULL
write.csv(GA_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\GA_BG10.csv")

LA_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="22")
LA_BG10$X<-NULL
LA_BG10$state<-NULL
write.csv(LA_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\LA_BG10.csv")

MI_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="26")
MI_BG10$X<-NULL
MI_BG10$state<-NULL
write.csv(MI_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\MI_BG10.csv")

NJ_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="34")
NJ_BG10$X<-NULL
NJ_BG10$state<-NULL
write.csv(NJ_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\NJ_BG10.csv")

TX_BG10<-subset(BG10_RespondStates,BG10_RespondStates$state=="48")
TX_BG10$X<-NULL
TX_BG10$state<-NULL
write.csv(TX_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\TX_BG10.csv")


#Detroit


MI_BG10<-read.csv("M:\\RESPOND\\2010\\BG\\Combined_2010\\MI_BG10.csv")
MI_BG10$County<-substr(MI_BG10$BG10_geoID,3,5)
Detroit_MI_BG10<-subset(MI_BG10,County==163 | County==87 | County==93| County==99| County==125| County==147)

Detroit_MI_BG10$BG10_Q5population_density<-CutQ(Detroit_MI_BG10$BG10_population_density, 
                                                breaks = quantile(Detroit_MI_BG10$BG10_population_density, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_BG10$BG10_Q4population_density<-CutQ(Detroit_MI_BG10$BG10_population_density, 
                                                breaks = quantile(Detroit_MI_BG10$BG10_population_density, seq(0, 1, by = 0.25), na.rm = TRUE))

#Detroit_MI_BG10$BG10_Qcrowding<-
# for (i in 1:length(Detroit_MI_BG10$BG10_crowding)){
#   if (is.nan(Detroit_MI_BG10$BG10_crowding[i])==TRUE){
#     Detroit_MI_BG10$BG10_Qcrowding[i]<-"NaN"
#   }
#   else if (Detroit_MI_BG10$BG10_crowding[i]<=0.33){
#     Detroit_MI_BG10$BG10_Qcrowding[i]<-"Less than 33 percent"
#   }
#   else if (Detroit_MI_BG10$BG10_crowding[i]>.33 & Detroit_MI_BG10$BG10_crowding[i]<0.66){
#     Detroit_MI_BG10$BG10_Qcrowding[i]<-"Between 33 and 66 percent"
#   }
#   else{
#     Detroit_MI_BG10$BG10_Qcrowding[i]<-"Greater than 66 percent"
#   }
# }

Detroit_MI_BG10$BG10_Qrenting<- CutQ(Detroit_MI_BG10$BG10_renting, 
                                     breaks = quantile(Detroit_MI_BG10$BG10_renting, seq(0, 1, by = 0.20), na.rm = TRUE))

# Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits<- CutQ(Detroit_MI_BG10$BG10_pernonsinglefamilyunits, 
                                                     # breaks = quantile(Detroit_MI_BG10$BG10_pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

for (i in 1:length(Detroit_MI_BG10$BG10_pernonsinglefamilyunits)){
  if (is.na(Detroit_MI_BG10$BG10_pernonsinglefamilyunits[i])==TRUE){
    Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1[i]<-"NaN"
  }
  else if (Detroit_MI_BG10$BG10_pernonsinglefamilyunits[i]<=0.33){
    Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1[i]<-"Less than 33 percent"
  }
  else if (Detroit_MI_BG10$BG10_pernonsinglefamilyunits[i]>.33 & Detroit_MI_BG10$BG10_pernonsinglefamilyunits[i]<0.66){
    Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1[i]<-"Between 33 and 66 percent"
  }
  else{
    Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1[i]<-"Greater than 66 percent"
  }
}
Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits<-Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1
Detroit_MI_BG10$BG10_Qpernonsinglefamilyunits1<-NULL
# 
# #Detroit_MI_BG10$BG10_Qpermoreunits<-
#   for (i in 1:length(Detroit_MI_BG10$BG10_permoreunits)){
#     if (is.nan(Detroit_MI_BG10$BG10_permoreunits[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qpermoreunits[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_permoreunits[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qpermoreunits[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_permoreunits[i]>.33 & Detroit_MI_BG10$BG10_permoreunits[i]<0.66){
#       Detroit_MI_BG10$BG10_Qpermoreunits[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qpermoreunits[i]<-"Greater than 66 percent"
#     }
#   }
# 
# 
# #Detroit_MI_BG10$BG10_Qpertraveltimeless30<-
#   
#   for (i in 1:length(Detroit_MI_BG10$BG10_pertraveltimeless30)){
#     if (is.nan(Detroit_MI_BG10$BG10_pertraveltimeless30[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qpertraveltimeless30[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltimeless30[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qpertraveltimeless30[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltimeless30[i]>.33 & Detroit_MI_BG10$BG10_pertraveltimeless30[i]<0.66){
#       Detroit_MI_BG10$BG10_Qpertraveltimeless30[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qpertraveltimeless30[i]<-"Greater than 66 percent"
#     }
#   }
# 
# 
# 
# #Detroit_MI_BG10$BG10_Qpertraveltime30_44<-
#   for (i in 1:length(Detroit_MI_BG10$BG10_pertraveltime30_44)){
#     if (is.nan(Detroit_MI_BG10$BG10_pertraveltime30_44[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qpertraveltime30_44[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltime30_44[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qpertraveltime30_44[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltime30_44[i]>.33 & Detroit_MI_BG10$BG10_pertraveltime30_44[i]<0.66){
#       Detroit_MI_BG10$BG10_Qpertraveltime30_44[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qpertraveltime30_44[i]<-"Greater than 66 percent"
#     }
#   } 
# 
# #Detroit_MI_BG10$BG10_Qpertraveltime45_59<-
#   for (i in 1:length(Detroit_MI_BG10$BG10_pertraveltime45_59)){
#     if (is.nan(Detroit_MI_BG10$BG10_pertraveltime45_59[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qpertraveltime45_59[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltime45_59[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qpertraveltime45_59[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltime45_59[i]>.33 & Detroit_MI_BG10$BG10_pertraveltime45_59[i]<0.66){
#       Detroit_MI_BG10$BG10_Qpertraveltime45_59[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qpertraveltime45_59[i]<-"Greater than 66 percent"
#     }
#   } 
#   
# #Detroit_MI_BG10$BG10_Qpertraveltimemore60<-
#   for (i in 1:length(Detroit_MI_BG10$BG10_pertraveltimemore60)){
#     if (is.nan(Detroit_MI_BG10$BG10_pertraveltimemore60[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qpertraveltimemore60[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltimemore60[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qpertraveltimemore60[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_pertraveltimemore60[i]>.33 & Detroit_MI_BG10$BG10_pertraveltimemore60[i]<0.66){
#       Detroit_MI_BG10$BG10_Qpertraveltimemore60[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qpertraveltimemore60[i]<-"Greater than 66 percent"}
#   }
# 
# #Detroit_MI_BG10$BG10_Qperrural<-
#   for (i in 1:length(Detroit_MI_BG10$BG10_perrural)){
#     if (is.nan(Detroit_MI_BG10$BG10_perrural[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qperrural[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_perrural[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qperrural[i]<-"Urban"
#     }
#     else if (Detroit_MI_BG10$BG10_perrural[i]>.33 & Detroit_MI_BG10$BG10_perrural[i]<0.66){
#       Detroit_MI_BG10$BG10_Qperrural[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qperrural[i]<-"Rural"
#     }
#   }
# 
# 
# #Detroit_MI_BG10$BG10_Qperinsideurbanizedareas<-
#   
#   
#   for (i in 1:length(Detroit_MI_BG10$BG10_perinsideurbanizedareas)){
#     if (is.nan(Detroit_MI_BG10$BG10_perinsideurbanizedareas[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qperinsideurbanizedareas[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_perinsideurbanizedareas[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qperinsideurbanizedareas[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_perinsideurbanizedareas[i]>.33 & Detroit_MI_BG10$BG10_perinsideurbanizedareas[i]<0.66){
#       Detroit_MI_BG10$BG10_Qperinsideurbanizedareas[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qperinsideurbanizedareas[i]<-"Greater than 66 percent"
#     }
#   }
# 
# #Detroit_MI_BG10$BG10_Qperinsideurbancluster<
#   #                                    
#   for (i in 1:length(Detroit_MI_BG10$BG10_perinsideurbancluster)){
#     if (is.nan(Detroit_MI_BG10$BG10_perinsideurbancluster[i])==TRUE){
#       Detroit_MI_BG10$BG10_Qperinsideurbancluster[i]<-"NaN"
#     }
#     else if (Detroit_MI_BG10$BG10_perinsideurbancluster[i]<=0.33){
#       Detroit_MI_BG10$BG10_Qperinsideurbancluster[i]<-"Less than 33 percent"
#     }
#     else if (Detroit_MI_BG10$BG10_perinsideurbancluster[i]>.33 & Detroit_MI_BG10$BG10_perinsideurbancluster[i]<0.66){
#       Detroit_MI_BG10$BG10_Qperinsideurbancluster[i]<-"Between 33 and 66 percent"
#     }
#     else{
#       Detroit_MI_BG10$BG10_Qperinsideurbancluster[i]<-"Greater than 66 percent"
#     }
#   }

Detroit_MI_BG10$BG10_QSES<-CutQ(Detroit_MI_BG10$BG10_SES, breaks = quantile(Detroit_MI_BG10$BG10_SES,seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_BG10$County<-NULL
Detroit_MI_BG10$X<-NULL
#write.csv(Detroit_MI_BG10,"M:\\RESPOND\\2010\\BG\\Combined_2010\\Detroit_MI_BG10.csv")

#-----------------------------------------------------------------------------------------------------------------------------------------

MI_CT10<-read.csv("M:\\RESPOND\\2010\\CT\\Combined_2010\\MI_CT10.csv")
MI_CT10$County<-substr(MI_CT10$CT10_geoID,3,5)
Detroit_MI_CT10<-subset(MI_CT10,County==163 | County==87 | County==93| County==99| County==125| County==147)

Detroit_MI_CT10$CT10_Q5population_density<-CutQ(Detroit_MI_CT10$CT10_population_density, 
                                                breaks = quantile(Detroit_MI_CT10$CT10_population_density, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT10$CT10_Q4population_density<-CutQ(Detroit_MI_CT10$CT10_population_density, 
                                                breaks = quantile(Detroit_MI_CT10$CT10_population_density, seq(0, 1, by = 0.25), na.rm = TRUE))


Detroit_MI_CT10$CT10_Qrenting<- CutQ(Detroit_MI_CT10$CT10_renting, 
                                     breaks = quantile(Detroit_MI_CT10$CT10_renting, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT10$CT10_Qpernonsinglefamilyunits<- CutQ(Detroit_MI_CT10$CT10_pernonsinglefamilyunits, 
                                                     breaks = quantile(Detroit_MI_CT10$CT10_pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT10$CT10_QSES<-CutQ(Detroit_MI_CT10$CT10_SES, breaks = quantile(Detroit_MI_CT10$CT10_SES,seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT10$County<-NULL
Detroit_MI_CT10$X<-NULL

write.csv(Detroit_MI_CT10,"M:\\RESPOND\\2010\\CT\\Combined_2010\\Detroit_MI_CT10.csv")
#------------------------------------------------------------------------------------------------------------------------------------------------------------

MI_CT00<-read.csv("M:\\RESPOND\\2000\\CT\\Combined_2000\\MI_CT00.csv")
MI_CT00$County<-substr(MI_CT00$CT00_geoID,3,5)
Detroit_MI_CT00<-subset(MI_CT00,County==163 | County==87 | County==93| County==99| County==125| County==147)

Detroit_MI_CT00$CT00_Q5population_density<-CutQ(Detroit_MI_CT00$CT00_population_density, 
                                                breaks = quantile(Detroit_MI_CT00$CT00_population_density, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT00$CT00_Q4population_density<-CutQ(Detroit_MI_CT00$CT00_population_density, 
                                                breaks = quantile(Detroit_MI_CT00$CT00_population_density, seq(0, 1, by = 0.25), na.rm = TRUE))


Detroit_MI_CT00$CT00_Qrenting<- CutQ(Detroit_MI_CT00$CT00_renting, 
                                     breaks = quantile(Detroit_MI_CT00$CT00_renting, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT00$CT00_Qpernonsinglefamilyunits<- CutQ(Detroit_MI_CT00$CT00_pernonsinglefamilyunits, 
                                                     breaks = quantile(Detroit_MI_CT00$CT00_pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT00$CT00_QSES<-CutQ(Detroit_MI_CT00$CT00_SES, breaks = quantile(Detroit_MI_CT00$CT00_SES,seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_CT00$County<-NULL
Detroit_MI_CT00$X<-NULL
write.csv(Detroit_MI_CT00,"M:\\RESPOND\\2000\\CT\\Combined_2000\\Detroit_MI_CT00.csv")

#----------------------------------------------------------------------------------------------------------------
MI_BG001<-read.csv("M:\\RESPOND\\2000\\BG\\Combined_2000\\MI_BG00.csv")
MI_BG00$County<-substr(MI_BG00$BG00_geoID,3,5)
Detroit_MI_BG00<-subset(MI_BG00,County==163 | County==87 | County==93| County==99| County==125| County==147)

Detroit_MI_BG00$BG00_Q5population_density<-CutQ(Detroit_MI_BG00$BG00_population_density, 
                                                breaks = quantile(Detroit_MI_BG00$BG00_population_density, seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_BG00$BG00_Q4population_density<-CutQ(Detroit_MI_BG00$BG00_population_density, 
                                                breaks = quantile(Detroit_MI_BG00$BG00_population_density, seq(0, 1, by = 0.25), na.rm = TRUE))


Detroit_MI_BG00$BG00_Qrenting<- CutQ(Detroit_MI_BG00$BG00_renting, 
                                     breaks = quantile(Detroit_MI_BG00$BG00_renting, seq(0, 1, by = 0.20), na.rm = TRUE))

# Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits<- CutQ(Detroit_MI_BG00$BG00_pernonsinglefamilyunits, 
#                                                      breaks = quantile(Detroit_MI_BG00$BG00_pernonsinglefamilyunits, seq(0, 1, by = 0.20), na.rm = TRUE))

for (i in 1:length(Detroit_MI_BG00$BG00_pernonsinglefamilyunits)){
  if (is.na(Detroit_MI_BG00$BG00_pernonsinglefamilyunits[i])==TRUE){
    Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1[i]<-"NaN"
  }
  else if (Detroit_MI_BG00$BG00_pernonsinglefamilyunits[i]<=0.33){
    Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1[i]<-"Less than 33 percent"
  }
  else if (Detroit_MI_BG00$BG00_pernonsinglefamilyunits[i]>.33 & Detroit_MI_BG00$BG00_pernonsinglefamilyunits[i]<0.66){
    Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1[i]<-"Between 33 and 66 percent"
  }
  else{
    Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1[i]<-"Greater than 66 percent"
  }
}
Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits<-Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1
Detroit_MI_BG00$BG00_Qpernonsinglefamilyunits1<-NULL



Detroit_MI_BG00$BG00_QSES<-CutQ(Detroit_MI_BG00$BG00_SES, breaks = quantile(Detroit_MI_BG00$BG00_SES,seq(0, 1, by = 0.20), na.rm = TRUE))

Detroit_MI_BG00$County<-NULL
Detroit_MI_BG00$X<-NULL

write.csv(Detroit_MI_BG00,"M:\\RESPOND\\2000\\BG\\Combined_2000\\Detroit_MI_BG00.csv")

df<-read.csv("M:\\RESPOND\\2000\\BG\\Combined_2000\\Detroit_MI_BG00.csv")
df1<-read.csv("M:\\RESPOND\\2000\\BG\\Combined_2000\\MI_BG00.csv")

d<-dff[duplicated(dff$GEOID)]

dff<-read.csv("T:\\Aim 1\\Neighborhood data\\Gibbons typology\\blockgroup_typology_00 May 2019.csv")

d<-as.data.frame(dff$GEOID[duplicated(dff$GEOID)])
colnames(d)[1]<-"GEOID"

dff$GEOID<-str_pad(dff$GEOID,12,"left",pad="0")

dff$st<-substr(dff$GEOID,1,2)





