library(haven)

CA_07111_imputedSES<-acs07115_tract_sep2013 <- read_sas("Z:/nSES/acs07115_tract_sep2013.sas7bdat", 
                                                        NULL)
CA_07111_imputedSES$STATE<-substr(CA_07111_imputedSES$STATE,2,2)

CA_07111_imputedSES$ID<-paste0(CA_07111_imputedSES$STATE,CA_07111_imputedSES$COUNTY,CA_07111_imputedSES$TRACT)

SF_original_SES0711<-subset(CA_07111_imputedSES,COUNTY=='075')

SF_original_SES0711<-SF_original_SES0711[,c("STATE","COUNTY","TRACT","ID","quinnSES","quinnSES_imp")]

-----------------------------------------------------------------------------------------------------------------------


shape0711_original<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2007-11 imputed SES CA\\CA_0711_shp.csv")


shape0711<-shape0711_original[,c("STATEFP","COUNTYFP","TRACTCE","GEOID","GISJOIN")]

shape0711<-subset(shape0711,county=='075')

shape0711$county<-str_pad(shape0711$COUNTYFP,width=3,side="left",pad="0")

total<-merge(SF_original_SES0711,shape0711,by.x="ID",by.y="GEOID")

write.csv(total,"M:\\LCS_UPDATED\\SES\\California\\2007-11 imputed SES CA\\linked2007_11_imputedSES_CA.csv")


