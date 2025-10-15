library(tidyverse)
library(readxl)
library(writexl)
library(stringr)
library(data.table)
library(dplyr)
##
#FRN
homedir <- "/Users/yanmq/Desktop/haoyesun/singletrial data" #
setwd(homedir)
FRN= list.files(pattern="*_FRN.xlsx")
for (i in 1:length(FRN)) {
  i=3
  #for (i in 5:6) {
  #i=24. _21_2
  filename<-substr(FRN[i], 1, nchar(FRN[i])-4);
  frn=read_xlsx(FRN[i])
  FRN_tidy=frn %>% 
    set_names('sub','F1','FZ','F2','FC1','FCZ','FC2','type','agent') %>% 

    slice(nrow(frn)-169+1:n())
  #write_xlsx(df,'test.xlsx')
  FRN_tidy[FRN_tidy== 'Var1']<- '0'  #
  FRN_tidy2=FRN_tidy %>% 
    mutate(across(everything(),as.double))
  #as.double(test1$type)
  filename=paste("R_subj",str_sub(FRN[i],6,9),"_FRN_tidy.xlsx",sep="")#
  #filename=paste('R_',temp[i],sep="")#
  write_xlsx (FRN_tidy2, filename)
}



files=fs::dir_ls('/Users/yanmq/Desktop/haoyesun/singletrial data',recurse=TRUE,glob = '*_FRN_tidy.xlsx')
#files=fs::dir_ls(homedir,recurse=TRUE,glob = 'subj*_P300_tidy.xlsx')
eeg=map_dfr(files,read_xlsx)
#filename=paste("R_subj",str_sub(P300[i],6,9),"_P300_tidy.xlsx",sep="")#
#filename=paste('R_',temp[i],sep="")#
write_xlsx (eeg,'EEG_FRN.xlsx')
#df3=df %>% 
#  rename(self1other2=agent)





