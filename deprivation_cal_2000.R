
df<-CA_DI_00vars
Vars_List<-c("P037003","P037004","P037005","P037006","P037007","P037008","P037009","P037010","P037020","P037021","P037022",
             "P037023","P037024","P037025","P037026","P037027","P037001","P043007","P043014","P043005","P043012","P088002","P088003","P088004",
             "P088005","P088006","P088007","P088008","P088009","P088001","P052002","P052003","P052004","P052005","P052001","P064001","P064003","H044001","H044010","H044003",
             "P043007","P043005","H007003","H007003","H007001","H008001","H020001","H085001","P017015","P017016","P007004","P007001","P008074","P008075","P008076","P008077",
             "P008078","P008079","P008035","P008036","P008037","P008038","P008040","P008001","P024002","P024003")




ndf<- as.data.frame(df$state)
colnames(ndf)[1] <- "State"


ndf$County <- df$county

ndf$Tract <- df$tract
#Percent of total with less than high schoo
#-2000
#(P0370003 + P0370004 + P0370005 +P0370006 + P0370007 +P0370008 + P0370009 +P0370010  + P0370020 +P0370021 
#+P0370022 + P0370023 + P0370024 +P0370025 +P0370026 +P0370027) / P0370001
sum_list<-c("P037003","P037004","P037005","P037006","P037007","P037008","P037009","P037010","P037020","P037021","P037022",
              "P037023","P037024","P037025","P037026","P037027")

ndf$less_highschool <- (rowSums(df[,sum_list],na.rm = T)/df$P037001)

#Percent of total unemployed
#-2000
#(P0430007+P0430014)/(P043005+P043012)

ndf$unemployed<-(df$P043007+df$P043014)/(df$P043005+df$P043012)




#Percent of HH with income below poverty

#-2000
#(P088002+P088003+P088004+P088005+P088006+P088007+P088008+P088009)/P088001
sum_list<-c("P088002","P088003","P088004","P088005","P088006","P088007","P088008","P088009")

ndf$icm_blpoverty<-(rowSums(df[,sum_list],na.rm = T))/df$P088001


#Percent of HH income < $22,500

#-2000
#P052002,P052003,P052004,P052005/P052001

sum_list<-c("P052002","P052003","P052004","P052005")

ndf$lessthn_22500<-(rowSums(df[,sum_list],na.rm = T))/df$P052001


#Percent of HH on public assistance

#-2000
#P064001:Total
#P064003:Total: No public assistance income
ndf$public_assist<-df$P064002/df$P064001

#Percent of HH with no car
#-2000
#H044010+H044003: Total Housing Units: No Vehicle available
#H044001: Total Housing Units: vehicles/No vehicle
ndf$no_car<-(df$H044010+df$H044003)/df$H044001

#------------------------------------------------
#Percent of Unemployed Men
#2000
# P043007: Male Unemployed
# P043005=Total: Male: In labor force: Civilian:
ndf$unemployed_man<-df$P043007/df$P043005

#Percent of renter occupied housing units
#-2000
#H007003: Total: Renter occupied
#H007001: Total: Occupied housing units
ndf$renter_occupied<-df$H007003/(df$H007003+df$H007001)


#Percent of housing units vacant
#-2000
#H008001: Total: Vacant housing units
#H020001: Total rental/owner occupied 

ndf$vacant<-df$H008001/df$H020001

#Median value of all owner occupied housing units
#-2000
#H085001=Median value Owner-occupied housing units
ndf$median_owneroccupeid<-df$H085001

#Percent of female headed HH with dependent children
#-2000
#P017015: Total: Other family: Female householder, no husband present:
#P017016: Total: Other family: Female householder, no husband present: With related children under 18 years:
ndf$femalehead_chid<-df$P017016/df$P017015

#Percent of non-Hispanic (NH)blacks.
#-2000
#P0070004/P0070001
ndf$NH_blacks<-df$P007004/df$P007001

#Percent of residents 65 years and over
#-2000
#(P008074,P008075,P008076,P008077,P008078,P008079)+(P008035,P008036,P008037,P008038,P008040)/P008001
sum_list<-c("P008074","P008075","P008076","P008077","P008078","P008079","P008035","P008036","P008037","P008038","P008040")


ndf$age_65plus<-(rowSums(df[,sum_list],na.rm = T))/df$P008001

#Percent of persons in same residence since 1985
#-2000
#P024002: Total: Same house in 1995
#P024003: Total: different house in 1995

ndf$same_residence<-df$P024002/(df$P024002+df$P024003)

ca_2000_deprivarion$id<-paste0(ca_2000_deprivarion$State,ca_2000_deprivarion$County,ca_2000_deprivarion$Tract)
ca_2000_deprivarion$Tract<-as.numeric(ca_2000_deprivarion$ID)
ca_2000_deprivarion<-ca_2000_deprivarion[,-c(1)]

ca_2000_deprivarion<-ca_2000_deprivarion[,c(15,1,2,3,4,5,6,7,8,9,10,11,12,13,14)]
ca_2000_deprivarion$id<-as.numeric(ca_2000_deprivarion$id)

CA<-data.matrix(ca_2000_deprivarion)


pca<-prcomp(na.omit(ca_2000_deprivarion),scale=TRUE)


ca_2000_deprivarion<-na.omit(ndf)

write.csv(ca_2000_deprivarion,"M:\\LCS_UPDATED\\Deprivation\\ca2000_deprivation_NAomit.csv")


library(foreign)
write.foreign(ca_2000_deprivarion, "M:\\LCS_UPDATED\\Deprivation\\ca2000_deprivation.txt", "M:\\LCS_UPDATED\\Deprivation\\ca2000_deprivation.sas",   package="SAS")

eigen_vec<-read.csv("M:/LCS_UPDATED/Deprivation/deprivation_eigenvecs.csv")
write.csv(eigen_vec,"M:/LCS_UPDATED/Deprivation/deprivation_eigenvecs.csv")






