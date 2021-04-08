setwd("C:/Rworks")
gendata<-read.csv("solor_power_generation.csv", header = TRUE)
gendata
#문제정의 : 낮의 길이가 가장 긴 여름에 가장 발전량이 가장 많지 않을까? 


#1호기 2호기의 시간대별 발전량 추출하기
library(dplyr)
gen1 <- filter(gendata,gendata[,2]==1, .preserve = FALSE )
gen2 <- filter(gendata,gendata[,2]==2, .preserve = FALSE )

time<-gen1[,1]
#as.date 함수로 문자열을 날짜로 변환
x<-as.Date(time) 
generation<-gen1[,"X8"]
dt<-data.frame(x,generation)
str(dt)

#시계열 데이터로 전환
library(xts)
power<-xts(dt$generation, order.by = dt$x)

#데이터 시각화
library(dygraphs)
dygraph(power)

#처음 가설을 세워 데이터를 분석하고 시각화하여 결론을 도출했다.
#봄과 가을이 발전량이 가장 많고 여름이 그다음 겨울이 가장 적다.
 





