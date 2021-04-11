# dplyr 패키지를 활용한 데이터 가공
#부분 선택 (subsetting)
library(dplyr)
#dplyr 패키지의 slice, filter, select, mutate, arrange, summarize, group_by, do 등의 함수를 통해 데이터를 가공할 수있다.
# 파이프 연산자 %>%와 함께 사용하면 함수의 적용을 순서데로 이해할 수 있다.
data(mtcars)
str(mtcars)
tb=as_tibble(mtcars)
#tb의 두번째에서 다섯번째 행 참조 - slice함수
tb[2:5,]
slice(tb, 2:5)
tb %>% .[2:5,]
tb %>% slice(.,2:5)

tb %>% slice(2:5)
tb %>% slice(c(2:3,4,5))

#tb에서 mpg가 30 초과인 행만 뽑아보고 싶다 - filter 함수
tb[tb$mpg>30,]
filter(tb, mpg>30)
tb %>% filter(.,mpg>30)
tb %>% filter(mpg>30)

#tb에서 첫번째와 세번째 열을 보고 싶다. - select함수
tb[,c(1,3)]
select(tb, c(1,3))
tb %>% select(c(1,3))

tb[, c("mpg", "disp")]
select(tb,c("mpg", "disp"))
select(tb, c(mpg, disp)

tb %>% select(c("mpg", "disp"))
tb %>% select(c(mpg,disp))

tb %>% select("mpg", "disp")
tb %>% select(mpg, disp) #""를 제거해도 되고 열이름을 벡터로 만들 필요도 없다.

#mpg 열부터 disp열까지 선택하고 싶을때
which(colnames(tb)=="mpg")
which(colnames(tb)=="disp")#데이터가 많은 자료의 열번호를 한번에 파악하기란 쉽지 않다.
tb[,1:3]

tb %>% select(mpg:disp) #select 함수를 사용하면 한줄이면 가능

#열이름이 특정한 조건을 만족하는 열만 선별할떄
tb3<-slice(tb, 1:3)
tb3

tb3 %>% select(starts_with("c"))

tb3 %>% select(ends_with("p"))

tb3 %>% select(contains("c"))

#특정한 열 이름 제외할때
tb %>% select(-mpg, -disp)
tb %>% select(-c(mpg,disp))
tb %>% select(-contains("c"))

# 새로운 열 추가할때 -mutate함수
tb2<-tb%>%select(hp,cyl, qsec) %>% slice(1:3)
tb2
tb2 %>% mutate(hp/cyl)
tb2 %>% mutate(hpPercyl= hp/cyl)
tb2 %>% mutate(hpPercyl= hp/cyl, V2=hp*qsec)

#정렬하기 - arrange함수
#tb의 cyl열을 기준으로 정렬하고 싶다
tb %>% arrange(cyl)
tb[order(tb$cyl),]

tb %>% arrange(desc(cyl)) #내림차순 정렬
tb[order(tb$cyl,decreasing = T),]

tb %>% arrange(cyl, desc(qsec)) #cyl 올림차순, qsec의 내림차순
tb[order(tb$cyl,-tb$qsec),]

#요약하기 - summarise 함수
tb %>% summarise(mean(hp))
tb %>% summarise(V1 = mean(hp))
tb %>% summarise(V1= mean(hp), V2=median(qsec))

