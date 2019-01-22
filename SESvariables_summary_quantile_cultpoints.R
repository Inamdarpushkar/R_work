setwd('M:\\RESPOND\\Summary_quantiles')
#-------------------------------------------------------------------------------------------------------------
#2000
#BG
CABG00<-read.csv("M:\\RESPOND\\2000\\BG\\CA_BGSES_UpdatedCCR2000.csv")
CABG00r<-CABG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_CABG00<-sapply(CABG00r, summary)
CABG00Min<-as.data.frame(tapply(CABG00$Prin1,CABG00$Q,min))
CABG00Max<-as.data.frame(tapply(CABG00$Prin1,CABG00$Q,max))
CABG00_c<-cbind(CABG00Min,CABG00Max)
#CT
CACT00<-read.csv("M:\\RESPOND\\2000\\CT\\CA_CTSES_UpdatedCCR2000.csv")
CACT00r<-CACT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_CACT00<-sapply(CACT00r, summary)
CACT00Min<-as.data.frame(tapply(CACT00$Prin1,CACT00$Q,min))
CACT00Max<-as.data.frame(tapply(CACT00$Prin1,CACT00$Q,max))
CACT00_c<-cbind(CACT00Min,CACT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
CABG12<-read.csv("M:\\RESPOND\\2010\\BG\\CA_BGSES_UpdatedCCR2010.csv")
CABG12r<-CABG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_CABG12<-sapply(CABG12r, summary)
CABG12Min<-as.data.frame(tapply(CABG12$Prin1,CABG12$Q,min))
CABG12Max<-as.data.frame(tapply(CABG12$Prin1,CABG12$Q,max))
CABG12_c<-cbind(CABG12Min,CABG12Max)

#CT
CACT12<-read.csv("M:\\RESPOND\\2010\\CT\\CA_CTSES_UpdatedCCR2010.csv")
CACT12r<-CACT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_CACT12<-sapply(CACT12r, summary)
CACT12Min<-as.data.frame(tapply(CACT12$Prin1,CACT12$Q,min))
CACT12Max<-as.data.frame(tapply(CACT12$Prin1,CACT12$Q,max))
CACT12_c<-cbind(CACT12Min,CACT12Max)

#Sink 

sink('CARespond_SESvariables_summary.csv')


cat('CABG00')
write.csv(result_CABG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('CACT00')
write.csv(result_CACT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('CABG12')
write.csv(result_CABG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('CACT12')
write.csv(result_CACT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('CABG00_c')
write.csv(CABG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('CACT00_c')
write.csv(CACT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('CABG12_c')
write.csv(CABG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('CACT12_c')
write.csv(CACT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#FLORIDA
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#2000
#BG
FLBG00<-read.csv("M:\\RESPOND\\2000\\BG\\FL_BGSES_UpdatedCCR2000.csv")
FLBG00r<-FLBG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_FLBG00<-sapply(FLBG00r, summary)
FLBG00Min<-as.data.frame(tapply(FLBG00$Prin1,FLBG00$Q,min))
FLBG00Max<-as.data.frame(tapply(FLBG00$Prin1,FLBG00$Q,max))
FLBG00_c<-cbind(FLBG00Min,FLBG00Max)
#CT
FLCT00<-read.csv("M:\\RESPOND\\2000\\CT\\FL_CTSES_UpdatedCCR2000.csv")
FLCT00r<-FLCT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_FLCT00<-sapply(FLCT00r, summary)
FLCT00Min<-as.data.frame(tapply(FLCT00$Prin1,FLCT00$Q,min))
FLCT00Max<-as.data.frame(tapply(FLCT00$Prin1,FLCT00$Q,max))
FLCT00_c<-cbind(FLCT00Min,FLCT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
FLBG12<-read.csv("M:\\RESPOND\\2010\\BG\\FL_BGSES_UpdatedCCR2010.csv")
FLBG12r<-FLBG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_FLBG12<-sapply(FLBG12r, summary)
FLBG12Min<-as.data.frame(tapply(FLBG12$Prin1,FLBG12$Q,min))
FLBG12Max<-as.data.frame(tapply(FLBG12$Prin1,FLBG12$Q,max))
FLBG12_c<-cbind(FLBG12Min,FLBG12Max)

#CT
FLCT12<-read.csv("M:\\RESPOND\\2010\\CT\\FL_CTSES_UpdatedCCR2010.csv")
FLCT12r<-FLCT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_FLCT12<-sapply(FLCT12r, summary)
FLCT12Min<-as.data.frame(tapply(FLCT12$Prin1,FLCT12$Q,min))
FLCT12Max<-as.data.frame(tapply(FLCT12$Prin1,FLCT12$Q,max))
FLCT12_c<-cbind(FLCT12Min,FLCT12Max)

#Sink 

sink('FLRespond_SESvariables_summary.csv')


cat('FLBG00')
write.csv(result_FLBG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('FLCT00')
write.csv(result_FLCT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('FLBG12')
write.csv(result_FLBG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('FLCT12')
write.csv(result_FLCT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('FLBG00_c')
write.csv(FLBG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('FLCT00_c')
write.csv(FLCT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('FLBG12_c')
write.csv(FLBG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('FLCT12_c')
write.csv(FLCT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#GEORGIA
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------

#2000
#BG
GABG00<-read.csv("M:\\RESPOND\\2000\\BG\\GA_BGSES_UpdatedCCR2000.csv")
GABG00r<-GABG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_GABG00<-sapply(GABG00r, summary)
GABG00Min<-as.data.frame(tapply(GABG00$Prin1,GABG00$Q,min))
GABG00Max<-as.data.frame(tapply(GABG00$Prin1,GABG00$Q,max))
GABG00_c<-cbind(GABG00Min,GABG00Max)
#CT
GACT00<-read.csv("M:\\RESPOND\\2000\\CT\\GA_CTSES_UpdatedCCR2000.csv")
GACT00r<-GACT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_GACT00<-sapply(GACT00r, summary)
GACT00Min<-as.data.frame(tapply(GACT00$Prin1,GACT00$Q,min))
GACT00Max<-as.data.frame(tapply(GACT00$Prin1,GACT00$Q,max))
GACT00_c<-cbind(GACT00Min,GACT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
GABG12<-read.csv("M:\\RESPOND\\2010\\BG\\GA_BGSES_UpdatedCCR2010.csv")
GABG12r<-GABG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_GABG12<-sapply(GABG12r, summary)
GABG12Min<-as.data.frame(tapply(GABG12$Prin1,GABG12$Q,min))
GABG12Max<-as.data.frame(tapply(GABG12$Prin1,GABG12$Q,max))
GABG12_c<-cbind(GABG12Min,GABG12Max)

#CT
GACT12<-read.csv("M:\\RESPOND\\2010\\CT\\GA_CTSES_UpdatedCCR2010.csv")
GACT12r<-GACT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_GACT12<-sapply(GACT12r, summary)
GACT12Min<-as.data.frame(tapply(GACT12$Prin1,GACT12$Q,min))
GACT12Max<-as.data.frame(tapply(GACT12$Prin1,GACT12$Q,max))
GACT12_c<-cbind(GACT12Min,GACT12Max)

#Sink 

sink('GARespond_SESvariables_summary.csv')


cat('GABG00')
write.csv(result_GABG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('GACT00')
write.csv(result_GACT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('GABG12')
write.csv(result_GABG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('GACT12')
write.csv(result_GACT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('GABG00_c')
write.csv(GABG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('GACT00_c')
write.csv(GACT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('GABG12_c')
write.csv(GABG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('GACT12_c')
write.csv(GACT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#Louisina
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------

#2000
#BG
LABG00<-read.csv("M:\\RESPOND\\2000\\BG\\LA_BGSES_UpdatedCCR2000.csv")
LABG00r<-LABG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_LABG00<-sapply(LABG00r, summary)
LABG00Min<-as.data.frame(tapply(LABG00$Prin1,LABG00$Q,min))
LABG00Max<-as.data.frame(tapply(LABG00$Prin1,LABG00$Q,max))
LABG00_c<-cbind(LABG00Min,LABG00Max)
#CT
LACT00<-read.csv("M:\\RESPOND\\2000\\CT\\LA_CTSES_UpdatedCCR2000.csv")
LACT00r<-LACT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_LACT00<-sapply(LACT00r, summary)
LACT00Min<-as.data.frame(tapply(LACT00$Prin1,LACT00$Q,min))
LACT00Max<-as.data.frame(tapply(LACT00$Prin1,LACT00$Q,max))
LACT00_c<-cbind(LACT00Min,LACT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
LABG12<-read.csv("M:\\RESPOND\\2010\\BG\\LA_BGSES_UpdatedCCR2010.csv")
LABG12r<-LABG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_LABG12<-sapply(LABG12r, summary)
LABG12Min<-as.data.frame(tapply(LABG12$Prin1,LABG12$Q,min))
LABG12Max<-as.data.frame(tapply(LABG12$Prin1,LABG12$Q,max))
LABG12_c<-cbind(LABG12Min,LABG12Max)

#CT
LACT12<-read.csv("M:\\RESPOND\\2010\\CT\\LA_CTSES_UpdatedCCR2010.csv")
LACT12r<-LACT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_LACT12<-sapply(LACT12r, summary)
LACT12Min<-as.data.frame(tapply(LACT12$Prin1,LACT12$Q,min))
LACT12Max<-as.data.frame(tapply(LACT12$Prin1,LACT12$Q,max))
LACT12_c<-cbind(LACT12Min,LACT12Max)

#Sink 

sink('LARespond_SESvariables_summary.csv')


cat('LABG00')
write.csv(result_LABG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('LACT00')
write.csv(result_LACT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('LABG12')
write.csv(result_LABG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('LACT12')
write.csv(result_LACT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('LABG00_c')
write.csv(LABG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('LACT00_c')
write.csv(LACT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('LABG12_c')
write.csv(LABG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('LACT12_c')
write.csv(LACT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#Mishigan
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#2000
#BG
MIBG00<-read.csv("M:\\RESPOND\\2000\\BG\\MI_BGSES_UpdatedCCR2000.csv")
MIBG00r<-MIBG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_MIBG00<-sapply(MIBG00r, summary)
MIBG00Min<-as.data.frame(tapply(MIBG00$Prin1,MIBG00$Q,min))
MIBG00Max<-as.data.frame(tapply(MIBG00$Prin1,MIBG00$Q,max))
MIBG00_c<-cbind(MIBG00Min,MIBG00Max)
#CT
MICT00<-read.csv("M:\\RESPOND\\2000\\CT\\MI_CTSES_UpdatedCCR2000.csv")
MICT00r<-MICT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_MICT00<-sapply(MICT00r, summary)
MICT00Min<-as.data.frame(tapply(MICT00$Prin1,MICT00$Q,min))
MICT00Max<-as.data.frame(tapply(MICT00$Prin1,MICT00$Q,max))
MICT00_c<-cbind(MICT00Min,MICT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
MIBG12<-read.csv("M:\\RESPOND\\2010\\BG\\MI_BGSES_UpdatedCCR2010.csv")
MIBG12r<-MIBG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_MIBG12<-sapply(MIBG12r, summary)
MIBG12Min<-as.data.frame(tapply(MIBG12$Prin1,MIBG12$Q,min))
MIBG12Max<-as.data.frame(tapply(MIBG12$Prin1,MIBG12$Q,max))
MIBG12_c<-cbind(MIBG12Min,MIBG12Max)

#CT
MICT12<-read.csv("M:\\RESPOND\\2010\\CT\\MI_CTSES_UpdatedCCR2010.csv")
MICT12r<-MICT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_MICT12<-sapply(MICT12r, summary)
MICT12Min<-as.data.frame(tapply(MICT12$Prin1,MICT12$Q,min))
MICT12Max<-as.data.frame(tapply(MICT12$Prin1,MICT12$Q,max))
MICT12_c<-cbind(MICT12Min,MICT12Max)

#Sink 

sink('MIRespond_SESvariables_summary.csv')


cat('MIBG00')
write.csv(result_MIBG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('MICT00')
write.csv(result_MICT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('MIBG12')
write.csv(result_MIBG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('MICT12')
write.csv(result_MICT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('MIBG00_c')
write.csv(MIBG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('MICT00_c')
write.csv(MICT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('MIBG12_c')
write.csv(MIBG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('MICT12_c')
write.csv(MICT12_c)
#cat('____________________________')
cat('\n')
cat('\n')
sink()
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#New Jersey
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------

NJBG00<-read.csv("M:\\RESPOND\\2000\\BG\\NJ_BGSES_UpdatedCCR2000.csv")
NJBG00r<-NJBG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_NJBG00<-sapply(NJBG00r, summary)
NJBG00Min<-as.data.frame(tapply(NJBG00$Prin1,NJBG00$Q,min))
NJBG00Max<-as.data.frame(tapply(NJBG00$Prin1,NJBG00$Q,max))
NJBG00_c<-cbind(NJBG00Min,NJBG00Max)
#CT
NJCT00<-read.csv("M:\\RESPOND\\2000\\CT\\NJ_CTSES_UpdatedCCR2000.csv")
NJCT00r<-NJCT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_NJCT00<-sapply(NJCT00r, summary)
NJCT00Min<-as.data.frame(tapply(NJCT00$Prin1,NJCT00$Q,min))
NJCT00Max<-as.data.frame(tapply(NJCT00$Prin1,NJCT00$Q,max))
NJCT00_c<-cbind(NJCT00Min,NJCT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
NJBG12<-read.csv("M:\\RESPOND\\2010\\BG\\NJ_BGSES_UpdatedCCR2010.csv")
NJBG12r<-NJBG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_NJBG12<-sapply(NJBG12r, summary)
NJBG12Min<-as.data.frame(tapply(NJBG12$Prin1,NJBG12$Q,min))
NJBG12Max<-as.data.frame(tapply(NJBG12$Prin1,NJBG12$Q,max))
NJBG12_c<-cbind(NJBG12Min,NJBG12Max)

#CT
NJCT12<-read.csv("M:\\RESPOND\\2010\\CT\\NJ_CTSES_UpdatedCCR2010.csv")
NJCT12r<-NJCT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_NJCT12<-sapply(NJCT12r, summary)
NJCT12Min<-as.data.frame(tapply(NJCT12$Prin1,NJCT12$Q,min))
NJCT12Max<-as.data.frame(tapply(NJCT12$Prin1,NJCT12$Q,max))
NJCT12_c<-cbind(NJCT12Min,NJCT12Max)

#Sink 

sink('NJRespond_SESvariables_summary.csv')


cat('NJBG00')
write.csv(result_NJBG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('NJCT00')
write.csv(result_NJCT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('NJBG12')
write.csv(result_NJBG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('NJCT12')
write.csv(result_NJCT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('NJBG00_c')
write.csv(NJBG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('NJCT00_c')
write.csv(NJCT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('NJBG12_c')
write.csv(NJBG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('NJCT12_c')
write.csv(NJCT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#Texas
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------


#2000
#BG
TXBG00<-read.csv("M:\\RESPOND\\2000\\BG\\TX_BGSES_UpdatedCCR2000.csv")
TXBG00r<-TXBG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_TXBG00<-sapply(TXBG00r, summary)
TXBG00Min<-as.data.frame(tapply(TXBG00$Prin1,TXBG00$Q,min))
TXBG00Max<-as.data.frame(tapply(TXBG00$Prin1,TXBG00$Q,max))
TXBG00_c<-cbind(TXBG00Min,TXBG00Max)
#CT
TXCT00<-read.csv("M:\\RESPOND\\2000\\CT\\TX_CTSES_UpdatedCCR2000.csv")
TXCT00r<-TXCT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_TXCT00<-sapply(TXCT00r, summary)
TXCT00Min<-as.data.frame(tapply(TXCT00$Prin1,TXCT00$Q,min))
TXCT00Max<-as.data.frame(tapply(TXCT00$Prin1,TXCT00$Q,max))
TXCT00_c<-cbind(TXCT00Min,TXCT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
TXBG12<-read.csv("M:\\RESPOND\\2010\\BG\\TX_BGSES_UpdatedCCR2010.csv")
TXBG12r<-TXBG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_TXBG12<-sapply(TXBG12r, summary)
TXBG12Min<-as.data.frame(tapply(TXBG12$Prin1,TXBG12$Q,min))
TXBG12Max<-as.data.frame(tapply(TXBG12$Prin1,TXBG12$Q,max))
TXBG12_c<-cbind(TXBG12Min,TXBG12Max)

#CT
TXCT12<-read.csv("M:\\RESPOND\\2010\\CT\\TX_CTSES_UpdatedCCR2010.csv")
TXCT12r<-TXCT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                   ,"Blue_Collarupdated","Prin1")]
result_TXCT12<-sapply(TXCT12r, summary)
TXCT12Min<-as.data.frame(tapply(TXCT12$Prin1,TXCT12$Q,min))
TXCT12Max<-as.data.frame(tapply(TXCT12$Prin1,TXCT12$Q,max))
TXCT12_c<-cbind(TXCT12Min,TXCT12Max)

#Sink 

sink('TXRespond_SESvariables_summary.csv')


cat('TXBG00')
write.csv(result_TXBG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('TXCT00')
write.csv(result_TXCT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('TXBG12')
write.csv(result_TXBG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('TXCT12')
write.csv(result_TXCT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('TXBG00_c')
write.csv(TXBG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('TXCT00_c')
write.csv(TXCT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('TXBG12_c')
write.csv(TXBG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('TXCT12_c')
write.csv(TXCT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()


#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#DetroitMSA
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------

#2000
#BG
DetroitMIBG00<-read.csv("M:\\RESPOND\\2000\\BG\\DetroitMI_BGSES_UpdatedCCR2000.csv")
DetroitMIBG00r<-DetroitMIBG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                                 ,"Blue_Collarupdated","Prin1")]
result_DetroitMIBG00<-sapply(DetroitMIBG00r, summary)
DetroitMIBG00Min<-as.data.frame(tapply(DetroitMIBG00$Prin1,DetroitMIBG00$Q,min))
DetroitMIBG00Max<-as.data.frame(tapply(DetroitMIBG00$Prin1,DetroitMIBG00$Q,max))
DetroitMIBG00_c<-cbind(DetroitMIBG00Min,DetroitMIBG00Max)
#CT
DetroitMICT00<-read.csv("M:\\RESPOND\\2000\\CT\\DetroitMI_CTSES_UpdatedCCR2000.csv")
DetroitMICT00r<-DetroitMICT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                                 ,"Blue_Collarupdated","Prin1")]
result_DetroitMICT00<-sapply(DetroitMICT00r, summary)
DetroitMICT00Min<-as.data.frame(tapply(DetroitMICT00$Prin1,DetroitMICT00$Q,min))
DetroitMICT00Max<-as.data.frame(tapply(DetroitMICT00$Prin1,DetroitMICT00$Q,max))
DetroitMICT00_c<-cbind(DetroitMICT00Min,DetroitMICT00Max)
#-------------------------------------------------------------------------------------------------------------
#2010
#BG
DetroitMIBG12<-read.csv("M:\\RESPOND\\2010\\BG\\DetroitMI_BGSES_UpdatedCCR2010.csv")
DetroitMIBG12r<-DetroitMIBG12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                                 ,"Blue_Collarupdated","Prin1")]
result_DetroitMIBG12<-sapply(DetroitMIBG12r, summary)
DetroitMIBG12Min<-as.data.frame(tapply(DetroitMIBG12$Prin1,DetroitMIBG12$Q,min))
DetroitMIBG12Max<-as.data.frame(tapply(DetroitMIBG12$Prin1,DetroitMIBG12$Q,max))
DetroitMIBG12_c<-cbind(DetroitMIBG12Min,DetroitMIBG12Max)

#CT
DetroitMICT12<-read.csv("M:\\RESPOND\\2010\\CT\\DetroitMI_CTSES_UpdatedCCR2010.csv")
DetroitMICT12r<-DetroitMICT12[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","employment"
                                 ,"Blue_Collarupdated","Prin1")]
result_DetroitMICT12<-sapply(DetroitMICT12r, summary)
DetroitMICT12Min<-as.data.frame(tapply(DetroitMICT12$Prin1,DetroitMICT12$Q,min))
DetroitMICT12Max<-as.data.frame(tapply(DetroitMICT12$Prin1,DetroitMICT12$Q,max))
DetroitMICT12_c<-cbind(DetroitMICT12Min,DetroitMICT12Max)

#Sink 

sink('DetroitMIRespond_SESvariables_summary.csv')


cat('DetroitMIBG00')
write.csv(result_DetroitMIBG00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('DetroitMICT00')
write.csv(result_DetroitMICT00)
#cat('____________________________')
cat('\n')
cat('\n')
cat('DetroitMIBG12')
write.csv(result_DetroitMIBG12)
#cat('____________________________')
cat('\n')
cat('\n')

cat('DetroitMICT12')
write.csv(result_DetroitMICT12)
#cat('____________________________')
cat('\n')
cat('\n')


cat('DetroitMIBG00_c')
write.csv(DetroitMIBG00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('DetroitMICT00_c')
write.csv(DetroitMICT00_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('DetroitMIBG12_c')
write.csv(DetroitMIBG12_c)
#cat('____________________________')
cat('\n')
cat('\n')
cat('DetroitMICT12_c')
write.csv(DetroitMICT12_c)
#cat('____________________________')
cat('\n')
cat('\n')

sink()





