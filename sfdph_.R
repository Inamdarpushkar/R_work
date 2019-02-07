library(gmodels)
library(haven)
library(dplyr)
library(data.table)
library(eeptools)
library(lubridate)
library(descr)

df<-read.csv("M:\\PHID\\HTN_maps\\HTN_GEOCODED7_join.csv")
sfdph_htn_mappop_20190129 <- read_sas("M:/PHID/HTN_maps/sfdph_htn_mappop_20190129.sas7bdat", 
                                      NULL)

sf<-subset(df,df$COUNTYFP==75)

sf[,c("MedHHInc_e","PerBlueCol", "PerUnEmp_e", "MedOwn_e" ,  "TotPop_e" ,  "nSESscl" ,"nSESscl_im","quinnSES","quinnSES_i","Education_","EduIndex_e", "PerBelowPo", "MedRent_e")]<-NULL

#sf<-subset(sf,sf$Status=="M"|sf$Status=="T")

final_sf<-merge(sf,sfdph_htn_mappop_20190129,by.x="MRN_blind",by.y = "MRN_blind_best")

final_sf_uncontrolled<-subset(final_sf,final_sf$BPUncontrolled==1)
final_sf_controlled<-subset(final_sf,final_sf$BPUncontrolled==0)


newgroup_uncontrolled<-group_by(final_sf_uncontrolled,final_sf_uncontrolled$GISJOIN)

summarise_tracts_uncontrolled<-summarise(newgroup_uncontrolled,
                count=n())

colnames(summarise_tracts_uncontrolled)[2]<-"Uncontrolled_count"

newgroup_controlled<-group_by(final_sf_controlled,final_sf_controlled$GISJOIN)

summarise_tracts_controlled<-summarise(newgroup_controlled,
                                         count=n())
colnames(summarise_tracts_controlled)[2]<-"controlled_count"


control_uncontrol<-merge(summarise_tracts_controlled,summarise_tracts_uncontrolled,by.x="final_sf_controlled$GISJOIN",by.y="final_sf_uncontrolled$GISJOIN",all = T)

control_uncontrol$total<-control_uncontrol$controlled_count+control_uncontrol$Uncontrolled_count

control_uncontrol$percent<-control_uncontrol$controlled_count/control_uncontrol$total

control_uncontrol_NotNA<-na.omit(control_uncontrol)

write.csv(control_uncontrol_NotNA,"M:\\PHID\\HTN_maps\\SFdph_HTNcontrol_uncontrol_GISjoin.csv")
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ars_20181130_htn_mappop_20190129 <- read_sas("M:/PHID/HTN_maps/ars_20181130_htn_mappop_20190129.sas7bdat", 
                                             NULL)
ucsf_geocode <- read_dta("M:/UCSF_geocode/Files from Mahasin/ucsf_geocode.dta")
Key_for_Mahasin <- read_dta("M:/UCSF_geocode/Files from Mahasin/Key_for_Mahasin.dta")
demo_data<-read.csv("M:\\PHID\\HTN_maps\\PatientCTatLastVisit_2018-11-09_blind.csv")

# ucsf_geocode_join<-merge(ucsf_geocode,Key_for_Mahasin,by="newindex")
# ars_ucsf_geocode_join<-merge(ars_20181130_htn_mappop_20190129,ucsf_geocode_join, by="pat_id_blind",all.x = T)
# ars_htn_Sf<-subset(ars_htn,ars_htn$City=="SAN FRANCISCO")
# SF_UCSF<-subset(ucsf_geocode,ucsf_geocode$geo_city16=="San Francisco"|ucsf_geocode$Status=="M")

UCSF<-merge(ucsf_geocode,Key_for_Mahasin,by="newindex")
demo_ars<-merge(demo_data,ars_20181130_htn_mappop_20190129,by="pat_id_blind")
UCSF_demo_ars<-merge(UCSF,demo_ars,by="newindex")


SF_UCSF_demo_ars<-subset(UCSF_demo_ars,UCSF_demo_ars$geo_county16=="San Francisco")

SF_UCSF_demo_ars_uncontrolled<-subset(SF_UCSF_demo_ars,SF_UCSF_demo_ars$BPUncontrolled==1)
SF_UCSF_demo_ars_controlled<-subset(SF_UCSF_demo_ars,SF_UCSF_demo_ars$BPUncontrolled==0)




#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

newgroup_uncontrolled<-group_by(SF_UCSF_demo_ars_uncontrolled,SF_UCSF_demo_ars_uncontrolled$stcotrk16)

summarise_tracts_uncontrolled<-summarise(newgroup_uncontrolled,
                                         count=n())

colnames(summarise_tracts_uncontrolled)[2]<-"Uncontrolled_count"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
newgroup_controlled<-group_by(SF_UCSF_demo_ars_controlled,SF_UCSF_demo_ars_controlled$stcotrk16)

summarise_tracts_controlled<-summarise(newgroup_controlled,
                                         count=n())

colnames(summarise_tracts_controlled)[2]<-"Controlled_count"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

control_uncontrol<-merge(summarise_tracts_controlled,summarise_tracts_uncontrolled,
                         by.x="SF_UCSF_demo_ars_controlled$stcotrk16",by.y="SF_UCSF_demo_ars_uncontrolled$stcotrk16",all = T)

control_uncontrol$total<-control_uncontrol$Controlled_count+control_uncontrol$Uncontrolled_count

control_uncontrol$percent<-control_uncontrol$Controlled_count/control_uncontrol$total

control_uncontrol_NotNA<-na.omit(control_uncontrol)

#control_uncontrol_NotNA<-control_uncontrol_NotNA[-c(1),]

write.csv(control_uncontrol_NotNA,"M:\\PHID\\HTN_maps\\UCSF_HTNcontrol_uncontrol_GISjoin.csv")
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

sfdph_HTN<-read.csv("M:\\PHID\\HTN_maps\\SFdph_HTNcontrol_uncontrol_GISjoin.csv")
UCSF_HTN<-read.csv("M:\\PHID\\HTN_maps\\UCSF_HTNcontrol_uncontrol_GISjoin.csv")
GIS_join<-read.csv("M:\\PHID\\HTN_maps\\GIS_ids.csv")

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GIS_sfdph_HTN<-merge(sfdph_HTN,GIS_join,by.x="final_sf_controlled.GISJOIN",by.y="GISJOIN",all = T)

Total_HTN<-merge(GIS_sfdph_HTN,UCSF_HTN,by.x="GEOID",by.y ="SF_UCSF_demo_ars_controlled.stcotrk16",all=T)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Total_HTN$Total_control<-Total_HTN$controlled_count+Total_HTN$Controlled_count
Total_HTN$Total_uncontrol<-Total_HTN$Uncontrolled_count.x+Total_HTN$Uncontrolled_count.y
Total_HTN$Total_Total<-Total_HTN$Total_control+Total_HTN$Total_uncontrol

Total_HTN$Total_percent<-Total_HTN$Total_control/Total_HTN$Total_Total




