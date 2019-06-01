## General Notes, Examples Related to Statistical Inference

library(tidyverse)

## grab data -> can use vancouver weather data in other R project
# data <- read_csv(file.choose())
# write_csv(data, 'data-input/vw-data.csv')

## set up to use data
idata <- read_csv('data-input/vw-data.csv')

## filter data for investigation
idata2 <- idata %>% filter(Year>=2017, Month==4) ## Daily April data for recent years
## summary stats for all
summary(idata2)

## summary statistics for each month
idata2.mth <- idata2 %>% group_by(Year, Month) %>% summarize(
  max.mean=mean(Max.Temp),
  min.mean=mean(Min.Temp),
  mean.mean=mean(Mean.Temp),
  mean.precip=mean(Total.Precip)
) 
View(idata2.mth)
