
lib_pack<-c("DescTools","descr","plyr","dplyr","tidyr","sas7bdat","stargazer","psych","formattable",
            "tidyverse","foreign","stringr","rgdal","censusapi","readr","data.table","DescTools")

lapply(lib_pack,require,character.only=TRUE)

cat("\014")
-------------------------------------------------------------------------------------
df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2012(5years)\\CA_BGSES_UpdatedCCR2012.csv")
-------------------------------------------------------------------------------------

nt<-df%>%group_by(Q)%>%summarise(n=n(),
                                   MeanPoverty=mean(Poverty),MedianPoverty=median(Poverty),
                                   MeanEducation=mean(Education_Index),MedianEducation=median(Education_Index),
                                   MeanHHI=mean(Median_HHI),MedianHHI=median(Median_HHI),
                                   MeanHV=mean(Median_hv),MedianHV=median(Median_hv),
                                   MeanRent=mean(Median_Rent),MedianRent=median(Median_Rent),
                                   #MeanUnemp=mean(Unemployment),MedianUnemp=median(Unemployment),
                                   Meanemp=mean(employment),Medianemp=median(employment),
                                   MeanBluecollar=mean(Blue_Collarupdated),MedianBluecollar=median(Blue_Collarupdated))
-------------------------------------------------------------------------------------
new<-sapply(nt, is.numeric)
nt[new]<-lapply(nt[new],round,3)
-------------------------------------------------------------------------------------

nnt<-data.frame(nt$Q)
colnames(nnt)[1]<-"Q"
nnt$Count<-nt$n
nnt$Poverty<-paste(nt$MeanPoverty,nt$MedianPoverty,sep='/')
nnt$EducationIndex<-paste(nt$MeanEducation,nt$MedianEducation,sep='/')
nnt$HHI<-paste(nt$MeanHHI,nt$MedianHHI,sep='/')
nnt$HV<-paste(nt$MeanHV,nt$MedianHV,sep='/')
nnt$MedianRent<-paste(nt$MeanRent,nt$MedianRent,sep = '/')
#nnt$Unmployment<-paste(nt$MeanUnemp,nt$MedianUnemp,sep='/')
nnt$employment<-paste(nt$Meanemp,nt$Medianemp,sep='/')
nnt$BlueCollar<-paste(nt$MeanBluecollar,nt$MedianBluecollar,sep='/')

-------------------------------------------------------------------------------------  
write.csv(nnt,file = "M:\\LCS_UPDATED\\SES\\Result_tables\\CA_BG_2012.csv")


