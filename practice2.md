## 시계열 데이터 분석
- R을 활용하여 시계열 데이터 분석

#워킹디렉토리 설정
setwd("C:/Rworks") 

#데이터파일을 읽고 변수에 저장
gendata<-read.csv("solor_power_generation.csv", header = TRUE) Cancel Changes
head(gendata)

#dplyr패키지 활용
library(dplyr)

#발전소 1호기의 발전량만 추출하여 변수에 저장
gen1 <- filter(gendata,gendata[,2]==1, .preserve = FALSE ) 

#as.date()함수 활용하여 문자열을 날짜로 변환
time<-gen1[,1]
y<-as.Date(time)
generation<-gen1[,"X8"]
dt<-data.frame(y,generation)

#xts()함수를 활용하여 데이터를 시계열로 변환
library(xts)
power<-xts(dt$generation, order.by = dt$y)

dygraph(power) #시계열 그래프 생성
