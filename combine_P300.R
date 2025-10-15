rm(list=ls())

library(tidyverse)
library(readxl)
library(writexl)
library(stringr)
library(data.table)
library(dplyr)

#P300
homedir <- "/Users/yanmq/Desktop/haoyesun/singletrial data" #
setwd(homedir)
P300 = list.files(pattern="*_P300.xlsx")
for (i in 1:length(P300)) {
  test<-substr(P300[i], 1, nchar(P300[i])-5);
  test=read_xlsx(P300[i])
  test1=test %>% 
    set_names('subj','CP1','CPz','CP2','P1','Pz','P2','type','agent') %>% 
    slice(nrow(test)-169+1:n())
  #write_xlsx(df,'test.xlsx')
  test1[test1== 'Var1']<- '0'  #
  test2=test1 %>% 
    mutate(across(everything(),as.double))
  #as.double(test1$type)
  filename=paste("R_subj",str_sub(P300[i],6,9),"_P300_tidy.xlsx",sep="")#
  #filename=paste('R_',temp[i],sep="")#
  write_xlsx (test2, filename)
}


files=fs::dir_ls('/Users/yanmq/Desktop/haoyesun/singletrial data',recurse=TRUE,glob = '*_P300_tidy.xlsx')
#files=fs::dir_ls(homedir,recurse=TRUE,glob = 'subj*_P300_tidy.xlsx')
df=map_dfr(files,read_xlsx)
#filename=paste("R_subj",str_sub(P300[i],6,9),"_P300_tidy.xlsx",sep="")#
#filename=paste('R_',temp[i],sep="")#
write_xlsx (df,'P300_EEG.xlsx')
df3=df %>% 
  rename(self1other2=agent)










