library(stringr)

shape_dbf<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\SHP_NHGIS_1990_HI\\CT\\90CT_HI_shape.csv")
#original_dbf<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\BGSES_UpdatedCCR1990.csv")
original<-read.csv("M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\TractSES_UpdatedCCR1990.csv")
-----------------------------------------------------------------------------------------------------------
shape_dbf$State<-substr(shape_dbf$GISJOIN,2,3)
shape_dbf$County<-as.integer(substr(shape_dbf$GISJOIN,5,7))
shape_dbf$Tract<-substr(shape_dbf$GISJOIN,9,10000L)
shape_dbf$Tract<-str_pad(shape_dbf$Tract,width=6,side="right",pad="0")
-----------------------------------------------------------------------------------------------------------
original$fixed_tract<-str_pad(original$Tract,width=6,side="left",pad="0") 
-----------------------------------------------------------------------------------------------------------
original$County <- sprintf("%03d",original$County)
original$ID <- paste0(original$State,original$County,original$fixed_tract)  
-----------------------------------------------------------------------------------------------------------
shape_dbf$County <- sprintf("%03d",shape_dbf$County)
shape_dbf$ID <- paste0(shape_dbf$State,shape_dbf$County,shape_dbf$Tract)  
-----------------------------------------------------------------------------------------------------------
total<-merge(original,shape_dbf,by="ID",all.x = T)

write.csv(total,"M:\\LCS_UPDATED\\SES\\Hawaii\\1990\\90linkedSHP_SES_CT.csv")