- 출처: https://www.data.go.kr/data/15050344/fileData.do
- 파일형식: .csv
- .csv파일을 통해 데이터 패턴을 파악한다.
- 날짜데이터를 확인하였고, 시계열 데이터분석을 해보기로 했다.
- 날짜데이터를 확인하였고, 여름이 가장 발전량이 많은지 확인해보기 위해 시계열 데이터분석을 해보기로 했다.

## 시계열 데이터 분석
R을 활용하여 시계열 데이터 분석

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
x<-as.Date(time)
generation<-gen1[,"X8"]
dt<-data.frame(x,generation)

#xts()함수를 활용하여 데이터를 시계열로 변환
library(xts)
power<-xts(dt$generation, order.by = dt$x)

#시계열 그래프 생성
libary(dygraphs)
dygraph(power) 
