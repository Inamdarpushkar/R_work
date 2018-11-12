df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\90linkedSHP_SES_CT.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\90linkedSHP_SES_CT.csv")
--------------------------------------------------------------------------------
  
df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_CT.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_CT.csv")

--------------------------------------------------------------------------------
df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_BG.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State","County","Tract","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_BG.csv")

--------------------------------------------------------------------------------
df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_BG.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State","County","Tract","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\2000\\2000linkedSHP_SES_BG.csv")
--------------------------------------------------------------------------------
  df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\imputation2012\\BG\\HI_BGSES_imputed_UpdatedCCR2012.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\imputation2012\\BG\\HI_BGSES_imputed_UpdatedCCR2012.csv")
--------------------------------------------------------------------------------
df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\imputation2012\\CT\\HI_CTSES_imputed_UpdatedCCR2012.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\imputation2012\\CT\\HI_CTSES_imputed_UpdatedCCR2012.csv")


--------------------------------------------------------------------------------
  df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\1990\\CA_1990BGSES_UpdatedCCR.csv")

df<-df[,c("ID","State","County","Tract","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\1990\\CA_1990BGSES_UpdatedCCR.csv")

--------------------------------------------------------------------------------
df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\1990\\CA_TractSES_UpdatedCCR1990.csv")

df<-df[,c("ID","State","County","Tract","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\1990\\CA_TractSES_UpdatedCCR1990.csv")

--------------------------------------------------------------------------------


df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2000\\2000linkedSHP_SES_CT.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\2000\\2000linkedSHP_SES_CT.csv")

--------------------------------------------------------------------------------
  
  df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2000\\2000linkedSHP_SES_BG.csv")

df<-df[,c("ID","GISJOIN2","GISJOIN","State","County","Tract","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "Unemployment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\2000\\2000linkedSHP_SES_BG.csv")

--------------------------------------------------------------------------------
  
df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\imputation2012\\BG\\CA_BGSES_imputed_UpdatedCCR2012.csv")

df<-df[,c("ID","GEOID.x","GISJOIN.x","State.x","County.x","Tract.x","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]

write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\imputation2012\\BG\\CA_BGSES_imputed_UpdatedCCR2012.csv")
--------------------------------------------------------------------------------
  
df<-read.csv("M:\\LCS_UPDATED\\SES\\California\\imputation2012\\CT\\CA_CTSES_imputed_UpdatedCCR2012.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]

write.csv(df,"M:\\LCS_UPDATED\\SES\\California\\imputation2012\\CT\\CA_CTSES_imputed_UpdatedCCR2012.csv")
--------------------------------------------------------------------------------

df<-read.csv("M:\\LCS_UPDATED\\SES\\CAlifornia\\2012(5years)\\2012linkedSHP_SES_CA_BG.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\CAlifornia\\2012(5years)\\2012linkedSHP_SES_CA_BG.csv")


--------------------------------------------------------------------------------
  
  df<-read.csv("M:\\LCS_UPDATED\\SES\\CAlifornia\\2012(5years)\\2012linkedSHP_SES_CA_CT.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\CAlifornia\\2012(5years)\\2012linkedSHP_SES_CA_CT.csv")


--------------------------------------------------------------------------------
  
  df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\2012(5years)\\2012linkedSHP_SES_BG.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","BG","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\2012(5years)\\2012linkedSHP_SES_BG.csv")


--------------------------------------------------------------------------------
  
  df<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\2012(5years)\\2012linkedSHP_SES_CT.csv")

df<-df[,c("ID","GEOID","GISJOIN","State.x","County.x","Tract.x","Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv",
          "employment","Blue_Collarupdated","Prin1","Q")]
write.csv(df,"M:\\LCS_UPDATED\\SES\\Hawaii\\2012(5years)\\2012linkedSHP_SES_CT.csv")







