setwd("C:/Rworks")
gendata<-read.csv("solor_power_generation.csv", header = TRUE)
gendata


library(dplyr)
gen1 <- filter(gendata,gendata[,2]==1, .preserve = FALSE )
gen2 <- filter(gendata,gendata[,2]==2, .preserve = FALSE )
#1호기 2호기의 시간대별 발전 추출하기

time<-gen1[,1]
y<-as.Date(time) #as.date 함수로 문자열을 날짜로 변환
generation<-gen1[,"X8"]
dt<-data.frame(y,generation)
str(dt)
library(xts)
power<-xts(dt$generation, order.by = dt$y)
dygraph(power)




library(ggplot2)
library(xts)
library(dygraphs)
str(economics)
eco<-xts(economics$unemploy, order.by = economics$date)
dygraph(eco)

