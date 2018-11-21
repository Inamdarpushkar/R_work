

####California 

#1990
#BG
CABG90<-read.csv("M:\\LCS_UPDATED\\SES\\California\\1990\\CA_1990BGSES_UpdatedCCR_containsOneExtra.csv")
CABG90r<-CABG90[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                    ,"Blue_Collarupdated","Prin1")]
result_CABG90<-sapply(CABG90r, summary)
#CT
CACT90<-read.csv("M:\\LCS_UPDATED\\SES\\California\\1990\\CA_TractSES_UpdatedCCR1990.csv")
CACT90r<-CACT90[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                       ,"Blue_Collarupdated","Prin1")]
result_CACT90<-sapply(CACT90r, summary)

#2000
#BG
CABG00<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2000\\CA_BGSES_UpdatedCCR2000.csv")
CABG00r<-CABG00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_CABG00<-sapply(CABG00r, summary)

#CT
CACT00<-read.csv("M:\\LCS_UPDATED\\SES\\California\\2000\\CA_TractSES_UpdatedCCR2000.csv")
CACT00r<-CACT00[,c("Poverty","Education_Index","Median_HHI","Median_Rent","Median_hv","Unemployment"
                   ,"Blue_Collarupdated","Prin1")]
result_CACT00<-sapply(CACT00r, summary)
\
#2010
#BG

#CT

####Hawaii









