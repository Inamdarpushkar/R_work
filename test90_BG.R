options(scipen=999)
library(stringr)

shape_dbf<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\SHP_NHGIS_1990_HI\\BG\\90BGcsv_shp.csv")
#original_dbf<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\BGSES_UpdatedCCR1990.csv")
original<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\BGSES_UpdatedCCR1990.csv")
---------------------------------------------------------------------------------------------------------------------
shape_dbf$ID<-shape_dbf$STFID
shape_dbf$ID<-as.character(shape_dbf$STFID)
shape_dbf$ST<-substr(shape_dbf$ID,0,2)
shape_dbf$County<-substr(shape_dbf$ID,5,5)
shape_dbf$BG<-substr(shape_dbf$ID,12,12)
shape_dbf$newtract<-sub("0*$", "", shape_dbf$TRACT)
---------------------------------------------------------------------------------------------------------------------
#Tract Fips Adjustments
#county 3
newO_3<-subset(original,County==3)
newS_3<-subset(shape_dbf,County==3) 

newO_3$char<-str_length(newO_3$Tract)
newO_3$Ntract<-newO_3$Tract

newO_3$Ntract[newO_3$char==1] <- str_pad(newO_3$Ntract[newO_3$char==1],width=3,side="right",pad="0")
newO_3$Ntract[newO_3$char==2] <- str_pad(newO_3$Ntract[newO_3$char==2],width=4,side="right",pad="0")

newO_3$Ntract[newO_3$Ntract==100] <- str_pad(newO_3$Ntract[newO_3$Ntract==100],width=5,side="right",pad="0")
newO_3$Ntract[newO_3$Ntract==101] <- str_pad(newO_3$Ntract[newO_3$Ntract==101],width=5,side="right",pad="0")
newO_3$Ntract[newO_3$Ntract==110] <- str_pad(newO_3$Ntract[newO_3$Ntract==110],width=5,side="right",pad="0")
newO_3$Ntract[newO_3$Ntract==108&newO_3$BG==9] <- str_pad(newO_3$Ntract[newO_3$Ntract==108&newO_3$BG==9],width=5,side="right",pad="0")

newO_3$fixed_tract<-as.integer(newO_3$Ntract)

newO_3$Ntract<-NULL
newO_3$char<-NULL
---------------------------------------------------------------------------------------------------------------------
#county 1_5_7_9
newO_1579<-subset(original,County==1|County==5|County==7|County==9)
newS_1579<-subset(shape_dbf,County==1|County==5|County==7|County==9)

newO_1579$fixed_tract<-str_pad(newO_1579$Tract,width=5,side="right",pad="0")  
newO_1579$fixed_tract<-as.integer(newO_1579$fixed_tract)  
---------------------------------------------------------------------------------------------------------------------  
total<-rbind(newO_1579,newO_3)
---------------------------------------------------------------------------------------------------------------------  
total$County <- sprintf("%03d",total$County)
total$fixed_tract<-sprintf("%06d",total$fixed_tract)
total$ID <- paste0(total$State,total$County,total$fixed_tract,total$BG)  
---------------------------------------------------------------------------------------------------------------------  
merged<-merge(total,shape_dbf,by="ID")  
  
write.csv(merged,"M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\90linkedSHP_SES_BG.csv")




  