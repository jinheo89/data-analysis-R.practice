setwd("C:/Rworks")
gendata<-read.csv("solor_power_generation.csv", header = TRUE)
gendata


library(dplyr)
gen1 <- filter(gendata,gendata[,2]==1, .preserve = FALSE )
gen2 <- filter(gendata,gendata[,2]==2, .preserve = FALSE )
#1호기 2호기의 시간대별 발전 추출하기

time<-gen1[,1]
generation<-gen1[,"X8"]
dt<-data.frame(time,generation)
library(xts)
power<-xts(dt$generation, order.by = dt$time)



library(ggplot2)
library(xts)
library(dygraphs)
str(economics)
eco<-xts(economics$unemploy, order.by = economics$date)
dygraph(eco)

