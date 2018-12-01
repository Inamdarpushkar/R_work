library(data.table)
install.packages("descr")
install.packages("DescTools")
library(DescTools)
library(descr)
lib_pack<-c("plyr","dplyr","tidyr","sas7bdat","stargazer","psych","formattable",
            "tidyverse","foreign","stringr","rgdal","censusapi","readr","data.table","DescTools")

lapply(lib_pack,require,character.only=TRUE)

cat("\014")

#-----------------------------------------------------------------



CA<-read.csv( "M:\\RESPOND\\2010\\BG\\CABG_var2010.csv")
FL<-read.csv( "M:\\RESPOND\\2010\\BG\\FLBG_var2010.csv")
GA<-read.csv( "M:\\RESPOND\\2010\\BG\\GABG_var2010.csv")
LA<-read.csv( "M:\\RESPOND\\2010\\BG\\LABG_var2010.csv")
MI<-read.csv( "M:\\RESPOND\\2010\\BG\\MIBG_var2010.csv")
NJ<-read.csv( "M:\\RESPOND\\2010\\BG\\NJBG_var2010.csv")
TX<-read.csv( "M:\\RESPOND\\2010\\BG\\TXBG_var2010.csv")


df<-rbindlist(list(CA,FL,GA,LA,MI,NJ,TX))

df<-as.data.frame(df)

df$county <- sprintf("%03d",df$county)
df$tract<-sprintf("%06d",df$tract)
df$ID <- paste0(df$state,df$county,df$tract,df$block_group)

#-----------------------------------------------------------------

ndf<- as.data.frame(df$state)
colnames(ndf)[1] <- "state"


ndf$County <- df$county

ndf$Tract <- df$tract
ndf$BG<-df$block_group

ndf$ID<-df$ID

#-----------------------------------------------------------------

## Poverty 
ndf$Poverty <- df$C17002_008E / df$C17002_001E #No CHANGE

# sum_list <- c("C17002_002E","C17002_003E","C17002_004E","C17002_005E","C17002_006E","C17002_007E")
# ndf$Poverty1 <-(rowSums(df[,sum_list])/df$C17002_001E)
#--------------------------------------------------------------------------------------
  ## Education 
  
  # Less than high school 
  sum_list <- c("B15002_003E","B15002_004E","B15002_005E","B15002_006E","B15002_007E","B15002_008E","B15002_009E","B15002_010E","B15002_020E",
                "B15002_021E","B15002_022E","B15002_023E","B15002_024E","B15002_025E","B15002_026E","B15002_027E")
ndf$Lthighsch <- (rowSums(df[,sum_list])/df$B15002_001E) #No CHANGE

# High school 
sum_list <- c("B15002_011E","B15002_028E")
ndf$HS <- (rowSums(df[,sum_list])/df$B15002_001E) #No CHANGE
# College 
sum_list <- c("B15002_015E","B15002_016E","B15002_017E","B15002_018E","B15002_032E","B15002_033E","B15002_034E","B15002_035E","B15002_012E",
              "B15002_013E","B15002_014E","B15002_029E","B15002_030E","B15002_031E")
ndf$College <- (rowSums(df[,sum_list])/df$B15002_001E) #No CHANGE

# Education Index 
ndf$Education_Index <- (ndf$College*16)+(ndf$HS*12)+(ndf$Lthighsch*9) #No CHANGE

ndf$Lthighsch <- NULL
ndf$HS <- NULL
ndf$College <- NULL 
#-------------------------------------------------------------------------------------  
  # Median Household Income
  ndf$Median_HHI <- df$B19013_001E #No CHANGE
#-------------------------------------------------------------------------------------
  # Median Gross Rent
  ndf$Median_Rent <- df$B25064_001E #No CHANGE
#-------------------------------------------------------------------------------------
  # Median value of owner-occupied housing unit
  ndf$Median_hv <- df$B25077_001E #No CHANGE

#---------------------------------------------------------------------------------------
  # Unemployment updated:: total male+female labor force in denominator
  # Employed_sum_list <- c("B23001_007E","B23001_014E","B23001_021E","B23001_028E","B23001_035E","B23001_042E","B23001_049E",
  #               "B23001_056E","B23001_063E","B23001_070E","B23001_075E","B23001_080E","B23001_085E",
  #               
  #               "B23001_093E","B23001_100E","B23001_107E","B23001_114E","B23001_121E","B23001_128E", "B23001_135E","B23001_142E",
  #               "B23001_149E","B23001_156E","B23001_161E","B23001_166E","B23001_171E")
  # 
  # Unemployed_sum_list<-c("B23001_008E","B23001_015E","B23001_022E","B23001_029E","B23001_036E","B23001_043E","B23001_050E","B23001_057E",
  #                        "B23001_064E","B23001_071E", "B23001_076E","B23001_081E","B23001_086E",
  #                        
  #                        "B23001_094E","B23001_101E","B23001_108E","B23001_115E","B23001_122E","B23001_129E","B23001_136E","B23001_143E",
#                        "B23001_150E","B23001_157E","B23001_162E","B23001_167E","B23001_172E")
# 
# 
# 
# Inlabor_sum_list <- c("B23001_004E","B23001_011E","B23001_018E","B23001_025E","B23001_032E","B23001_039E","B23001_046E","B23001_053E",
#                       "B23001_060E","B23001_067E","B23001_074E","B23001_079E","B23001_084E",
#                       
#                       "B23001_090E","B23001_097E","B23001_104E","B23001_111E","B23001_118E","B23001_125E","B23001_132E","B23001_139E",
#                       "B23001_146E","B23001_153E","B23001_160E","B23001_165E","B23001_170E")
# 
# ndf$Unemployment <- (rowSums(df[,Employed_sum_list]))/(rowSums(df[,Inlabor_sum_list]))
# 
# ndf$Unemployment1 <- (rowSums(df[,Unemployed_sum_list]))/(rowSums(df[,Inlabor_sum_list]))

ndf$employment <- (df$B23025_004E)/(df$B23025_003E)
#ndf$unemployment<-(df$B23025_005E)/(df$B23025_002E)

# ndf$Unemployment1 <- (rowSums(df[,Unemployed_sum_list]))/(rowSums(df[,Inlabor_sum_list]))
#-------------------------------------------------------------------------------------
  # Blue Collar CNDS version
  #sum_list <- c("P050024","P050027","P050028","P050029", "P050030","P050031", "P050034","P050035", 
  #                "P050041","P050071","P050074","P050075","P050076","P050077",
  #               "P050078","P050081","P050082","P050088")
  
  #ndf$Blue_CollarCPIC <- (rowSums(df[,sum_list],na.rm = T)/df$P050001)
  
  # Blue Collar CCR version
  #sum_list <- c("P050028","P050029", "P050030","P050031","P050035", 
  #             "P050041","P050075","P050076","P050077",
  #            "P050078","P050082","P050088")

#ndf$Blue_CollarCCR <- (rowSums(df[,sum_list],na.rm = T)/df$P050001)

# Blue Collar updated version:: Farming,fishing,forestry|other forestry occupations excluded.

sum_list <- c("C24010_020E","C24010_024E","C24010_025E","C24010_026E","C24010_027E","C24010_032E",
              "C24010_033E","C24010_034E","C24010_056E","C24010_060E","C24010_061E","C24010_062E","C24010_063E","C24010_068E",
              "C24010_069E","C24010_071E")

ndf$Blue_Collarupdated <- (rowSums(df[,sum_list],na.rm = T)/df$C24010_001E)

ndf$totalpop<-df$B01003
#-------------------------------------------------------------------------------------
  #original_ndf<-ndf
  #ndf<-na.omit(ndf)
  #na_count<-sapply(original_ndf,function(y)sum(length(which(is.na(y)))))
  #na_count<-data.frame(na_count)
  
original_ndf<-ndf
newndf<-na.omit(ndf)
ndf<-subset(ndf,!is.na(ndf$totalpop))
ndf<-subset(ndf,!is.na(ndf$Median_HHI))
#CPICndf<-ndf
#CPICndf$Blue_CollarCCR<-NULL
#write.csv(CPICndf,"M:\\LCS_UPDATED\\SES\\California\\2000\\BGSES_data_CPIC.csv" )

#CCRndf<-ndf
#CCRndf$Blue_CollarCPIC<-NULL


write.csv(ndf,"M:\\RESPOND\\2010\\BG\\all_statesBG_omitNA.csv")

#----------------------------------------------------------------------------------------------------------------------

df<-read.csv("M:\\RESPOND\\2010\\BG\\all_statesBG_imputed.csv")

# CA 06
CA<-subset(df,df$state==6)
CA_o<-na.omit(CA)
CA$Q<- CutQ(CA$Prin1, breaks = quantile(CA$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(CA,"M:\\RESPOND\\2010\\BG\\CA_BGSES_UpdatedCCR2010.csv") 

# FL 12
FL<-subset(df,df$state==12)
FL_o<-na.omit(FL)
FL$Q<- CutQ(FL$Prin1, breaks = quantile(FL$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(FL,"M:\\RESPOND\\2010\\BG\\FL_BGSES_UpdatedCCR2010.csv") 

# GA 13
GA<-subset(df,df$state==13)
GA_o<-na.omit(GA)
GA$Q<- CutQ(GA$Prin1, breaks = quantile(GA$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(GA,"M:\\RESPOND\\2010\\BG\\GA_BGSES_UpdatedCCR2010.csv") 

# LA 22
LA<-subset(df,df$state==22)
LA_o<-na.omit(LA)
LA$Q<- CutQ(LA$Prin1, breaks = quantile(LA$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(LA,"M:\\RESPOND\\2010\\BG\\LA_BGSES_UpdatedCCR2010.csv")

# MI 26
MI<-subset(df,df$state==26)
MI_o<-na.omit(MI)
MI$Q<- CutQ(MI$Prin1, breaks = quantile(MI$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(MI,"M:\\RESPOND\\2010\\BG\\MI_BGSES_UpdatedCCR2010.csv")

# NJ 34
NJ<-subset(df,df$state==34)
NJ_o<-na.omit(NJ)
NJ$Q<- CutQ(NJ$Prin1, breaks = quantile(NJ$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(NJ,"M:\\RESPOND\\2010\\BG\\NJ_BGSES_UpdatedCCR2010.csv")

# TX 48
TX<-subset(df,df$state==48)
TX_o<-na.omit(TX)
TX$Q<- CutQ(TX$Prin1, breaks = quantile(TX$Prin1, seq(0, 1, by = 0.20), na.rm = TRUE)) 
write.csv(TX,"M:\\RESPOND\\2010\\BG\\TX_BGSES_UpdatedCCR2010.csv")

#----------------------------------------------------------------------------------------------------------------------

df<-read.csv("M:\\RESPOND\\2010\\BG\\all_statesBG_imputed.csv")
#CA 06
CA<-subset(df,df$state==6)

# FL 12
FL<-subset(df,df$state==12)

# GA 13
GA<-subset(df,df$state==13)

# LA 22
LA<-subset(df,df$state==22)

# MI 26
MI<-subset(df,df$state==26)

# NJ 34
NJ<-subset(df,df$state==34)

# TX 48
TX<-subset(df,df$state==48)









