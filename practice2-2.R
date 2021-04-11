#데이터 전처리
#확보한 데이터를 바로 분석할 수 없는 경우가 대부분 (결측값, 이상치, 상이한 단위, 오입력)

#결측값 (Missing value) ; NA in R

x<-c(1,2,3,NA,5,8)
sum(x)
sum(x, na.rm= T) #결측값을 제외하고 연산 (True=1, False=0)

z<-c(1,2,3,NA,5,NA,8)
is.na(z)
sum(is.na(z))

z[is.na(z)]<-0 #is.na가 True인 경우 0으로 치환하라
z

x<-c(1,2,3,NA,5,8)
x
y<-as.vector(na.omit(x))
y

x<-iris
x[1,2]<-NA; x[1,3]<-NA
x[2,3]<-NA; x[3,4]<-NA
head(x)

#컬럼별 결측값 개수 확인
#y는 어떤 컬럼값(벡터)
col_na <- function(y) {
  return(sum(is.na(y)))
}
na_count<-sapply(x, FUN=col_na) #Sapply()컬럼을 하나하나 잘라서 인풋으로 넣어라.
na_count

#NA를 포함한 행(row)의 개수파악
is.na(x) #데이터셋 전체
rowSums(is.na(x)) #행별 NA개수
sum(rowSums(is.na(x))>0) #NA가 포함된 행의 개수

#NA를 포함한 행(row)을 제외하고 새로운 데이터 생성
head(x)
x[!complete.cases(x),]
y<-x[complete.cases(x),]
head(y)

#결측값을 없애는 것은 가장 쉬운 방법이고 분석할 데이터가 없을 경우 발생 => 근사값을 추정하고 NA대신 치환
library(mice)
md.pattern(x) #x에 포함된 결측값 통계를 내는 함수
result<-mice(x, m=5, maxit=50, method='pmm', seed=500) #결측값을 적당한 값으로 추정하여 치환
impute_x<-complete(result, 2) #예측값 반영
head(impute_x)
head(iris)

#연습문제
library(mice)
ds<-ampute(iris[,1:4], 0.2)$amp
col_na<-function(y) {
  return(sum(is.na(y)))
}
na_count <-sapply(ds, FUN=col_na)
na_count

head(ds)
ds[!complete.cases(ds),]
is.na(ds)
rowSums(is.na(ds))
sum(rowSums(is.na(ds))>0)
ds.new<-ds[complete.cases(ds),]
ds.new

#이상치 outlier
# 정상 범위 밖의 값은 입력 실수 이거나 실제값
# 분석특성과 목표에 따라 이상치 에외여부 판단
# 이상치 탐색 
# 논리적으로 있을수 없는 값 / 상식을 벗어난 값/ boxplot을 그려봄

st<-data.frame(state.x77)
boxplot(st$Income)
boxplot.stats(st$Income)$out

# 각 컬럼의 이상치를 NA처리한 후 NA를 포함한 행들을 제거
out.val <-boxplot.stats(st$Income)$out
st$Income[st$Income %in% out.val] <- NA
st$Income
new.data<-st[complete.cases(st),]
new.data
boxplot(new.data$Income)

#정렬 (sort,order,rank)
v1<-c(1,7,6,8,4,2,3)
order(v1)
v1<-sort(v1) #오름차순
v1
v2 <-sort(v1,decreasing=T) #내림차순
v2

head(iris)
order(iris$Sepal.Length)
iris[order(iris$Sepal.Length),]
iris[order(iris$Sepal.Length, decreasing =T),]
iris[order(iris$Species, iris$Sepal.Length),]

v3<-c(1,7,2,5)
order(v3) # 1,7,2,5를 어떤 순서로 뽑는가
rank(v3) #현대 값에서 특정한 위치에 있는 것의 순위

#분리(split), 선택 (subset)
sp<- split(iris, iris$Species) #분리함수 데이터셋 분리기준
sp #list mode
summary(sp)
class(sp)
sp$setosa

subset(iris, Species == "setosa")
subset(iris, Sepal.Length > 5.1)
subset(iris, Sepal.Length >5.1 & Sepal.Width>3.9)
subset(iris, Sepal.Length >5.1, select=c(Petal.Length, Petal.Width))

#조건에 맞는 값들의 인덱스 알아내기
x<-c(3,1,7,8,5,9,4)
which(x>5)
which(iris$Species =="setosa")
#행 알아내기
which.max(iris$Sepal.Length)
which.min(iris$Sepal.Width)

#샘플링
x<-1:100
y<-sample(x, size=10, replace =FALSE) #repalce 비복원 추출
y

idx <- sample(nrow(iris), size =50, replace = FALSE)
iris.50<- iris[idx,]
head(iris.50)

#조합 combination
combn(5,3)
x<-c("red","green","blue","black","white")
com<-combn(x,2)
com

for (i in 1:ncol(com)) {
  cat(com[,i], "\n")
}
state.region
sp1<-split(state.x77, state.region)

sub<-subset(state.x77, state.area > 50708 & state.area < 156361) 
sub2<-data.frame(sub)
sub2$Population
sub2$Income
sub2$Area

idx<-sample(nrow(iris), size=40, replace = FALSE)
iris.40<-iris[idx,]
iris.110<-iris[-idx,]

x<-c("setosa", "versicolor","virginica")
com<-combn(x,2)
com

#데이터 요약 aggregation
agg<- aggregate(iris[,-5], by=list(iris$Species), FUN=mean)
agg
agg<- aggregate(iris[,-5], by=list(iris$Species), FUN=sd)
agg

head(mtcars)
agg<-aggregate(mtcars, by=list(mtcars$cyl, mtcars$vs), FUN=max)
agg
agg<-aggregate(mtcars, by=list(cyl=mtcars$cyl, vs=mtcars$vs), FUN=max)
agg

attach(mtcars) #사용하고자 하는 데이터셋 지정
agg<-aggregate(mtcars, by=list(cyl, vs), FUN=max)
agg
detach(mtcars) #작업하고 있는 데이터셋 지정해제

agg<- aggregate(iris[,-5], by=list(iris$Species), FUN=mean)
agg
agg<- aggregate(.~Species, data=iris, FUN=mean) #formula 방식, 같은뜻
agg

#데이터 병합
x<-data.frame(name=c("a","b","c"), math=c(90,80,40))
y<-data.frame(name=c("a","b","d"), korean=c(75,60,90))
x
y
merge(x,y, by="name")
merge(x,y, all.x=T)
merge(x,y, all.y=T)
merge(x,y, all=T)

x<-data.frame(name=c("a","b","c"), math=c(90,80,40))
y<-data.frame(sname=c("a","b","d"), korean=c(75,60,90))
merge(x,y, by.x="name", by.y="sname")


