#최종모의고사 1회 p.3-3
#작업형 1유형
#No.11
#1.medv 상위 50개 값을 상위 50번째 값으로 변환
#2.crim > 1인 값에 대한 crim의 평균
library(caret)
library(base)
library(stats)
library(dplyr)
df <- BostonHousing
View(df)
str(df)
summary(df)
desc_medv <- df %>% arrange(desc(medv)) %>% head(50)
fifth <- desc_medv$medv[50]
fifth
df$medv <- ifelse(df$medv >= fifth,
                  fifth,
                  df$medv) #1해결
head(sort(df$medv, decreasing=T),200) #확인

mean_crim <- df %>% filter(crim > 1) %>% summarise(mean(crim, na.rm=T)) #2해결 
print(mean_crim) #10.13898

boston <- df[order(-df$medv),]#책의 해설에서는 order함수를 썼다. -가 붙으면 내림차순, 안 붙으면 올림차순
boston
######################################################################
#No.12
#1.iris 세트에서 순서대로 70% 샘플링 해서 
#2.Sepal.Length의 표편
df <- iris
seq_train <- df[c(1:(nrow(df)*0.7)),] #1해결
sd_sepal_1 <- sd(seq_train$Sepal.Length, na.rm=T) #2해결
sd_sepal_1
######################################################################
#p.3-4
#No.13
#1.wt를 minmax scale로 변환 후
#2.0.5보다 큰 레코드 수
df <- mtcars
minmax <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}
df$wt <- minmax(df$wt) #1해결
df$wt
row_higher_0.5 <- df %>% filter(wt > 0.5) %>% summarise(n = n()) #2해결
row_higher_0.5
######################################################################
#작업형 2유형
#No.14
#1.Species(다중범주) 예측 모델로 svm, 의사결정나무CART기법을 이용
library(rpart)
library(e1071)
#탐색
df <- iris
View(df)
summary(df)
str(df) #Species는 이미 factor형
dim(df)
#D.Split
idx <- sample(x = c('train', 'valid', 'test'),
              size = nrow(df),
              replace=T,
              prob = c(3,1,1))
train_x <- df[idx=='train',-5]
train_y <- df[idx=='train',5,drop=F]
valid_x <- df[idx=='valid',-5]
valid_y <- df[idx=='valid',5,drop=F]
test_x <- df[idx=='test',-5]
test_y <- df[idx=='test',5,drop=F]
dim(df)
dim(train_x)
dim(train_y)
dim(valid_x)
dim(valid_y)
dim(test_x)
dim(test_y)
#X데이터들 scale
scale <- preProcess(train_x, method = 'range')
scaled_t_x <- predict(scale, train_x)
scaled_v_x <- predict(scale, valid_x)
scaled_test_x <- predict(scale, test_x)
scaled_t_x
##모델1: rpart
model_rpart <- rpart(train_y$Species ~.,
                     data = scaled_t_x)
ls(model_rpart)
model_rpart$cptable #xerror가 가장 작은  세번째 모델이 좋음
#예측
pred_rpart <- predict(model_rpart,
                      newdata = scaled_v_x,
                      type = 'class')
pred_rpart
pred_rpart1 <- predict(model_rpart,
                      newdata = scaled_v_x,
                      type = 'prob')
pred_rpart1
pred_rpart2 <- predict(model_rpart,
                       newdata = scaled_v_x,
                       type = 'matrix')
pred_rpart2
caret :: confusionMatrix(pred_rpart, reference = valid_y$Species) #virginica 2개를 틀렸고, ACC = 0.92
library(ModelMetrics)
##모델2 : svm
model_svm <- svm(train_y$Species ~.,
                 data = scaled_t_x)
pred_svm <- predict(model_svm,
                    newdata = scaled_v_x,
                    type = 'class')
caret :: confusionMatrix(pred_svm, reference = valid_y$Species) #위와 똑같음
#svm으로 선택하겠음
pred_svm_result <- predict(model_svm, 
                           newdata = scaled_test_x,
                           type = 'class')
caret :: confusionMatrix(pred_svm_result, reference = test_y$Species) #100%분류! ACC = 1.0 데이터가 너무 적어서 과대적합인가..
write.csv(pred_svm_result, "0001.csv", row.names=F)
######################################################################
#최종모의고사 2회 p.3-6
#작업형 1유형
#No.11
#1.이상값은 평균에서 1.5표편 초과, 미만 값
#2.Sales의 이상값을 제외한 데이터로 훈련 데이터 생성
#3.#2의 Age의 표편
library(ISLR)
data(Carseats)
df <- Carseats
summary(df)
str(df)
View(df)
dim(df)
outlier <- function(x){
  return(x <= mean(x, na.rm=T) + 1.5*sd(x, na.rm=T)&
           x >= mean(x, na.rm=T) - 1.5*sd(x, na.rm=T))
} #1해결
train <- df %>% filter(outlier(Sales)) #2해결
sd_age <- train %>% summarise(sd(Age, na.rm=T)) #3해결
print(sd_age) #16.05213
######################################################################
#No.12
#1.Luggage.room의 결측을 중앙값으로 변환한 후
#2.변환 전후의 평균 차이
library(MASS)
data(Cars93)
df <- Cars93
summary(df)
str(df)
View(df)
dim(df)
colSums(is.na(df))
before_mean <- mean(df$Luggage.room, na.rm=T)
df$Luggage.room <- ifelse(is.na(df$Luggage.room),
                          median(df$Luggage.room, na.rm=T),
                          df$Luggage.room) #1해결
colSums(is.na(df))
after_mean <- mean(df$Luggage.room, na.rm=T)
diff <- abs(before_mean - after_mean) #2해결
print(diff) #0.0129819
######################################################################
#p.3-7
#No.13
#1.age=20s인 confirmed의 평균
#2.age=50s인 confirmed의 평균
#3.#1와 #2의 차이
df <- read.csv("C:/Users/dlrpa/Downloads/TimeAge.csv", header = T, fileEncoding = 'UTF-8-BOM')
View(df)
summary(df)
str(df)
dim(df)
mean_20s <- df %>% filter(age == '20s') %>% summarise(mean(confirmed)) #1해결 
mean_20s
mean_50s <- df %>% filter(age == '50s') %>% summarise(mean(confirmed)) #2해결
mean_50s
diff <- abs(mean_20s - mean_50s) #3해결
print(diff) #957
######################################################################
#작업형 2유형
#No.14
#1.훈련:테스트 = 7:3
#2.loan_status(이진분류) 예측 : svm, RF, glm, rpart
df <- read.csv("C:/Users/dlrpa/Downloads/Loan payments data.csv", header = T, fileEncoding = 'UTF-8-BOM')
View(df)
summary(df)
str(df)
#결측 확인 - 중앙값 대체 
colSums(is.na(df))
df$past_due_days <- ifelse(is.na(df$past_due_days),
                           median(df$past_due_days, na.rm=T),
                           df$past_due_days)
colSums(is.na(df))
#종속변수 및 여타 chr변수들 factor로 변환
df$loan_status <- as.factor(df$loan_status)
df$effective_date <- as.factor(df$effective_date)
df$due_date <- as.factor(df$due_date)
df$paid_off_time <- as.factor(df$paid_off_time)
df$education <- as.factor(df$education)
df$Gender <- as.factor(df$Gender)
class(df$loan_status)
#D.Split
set.seed(1357)
idx <- sample(1:nrow(df),
              size = 0.7*nrow(df))
train_x <- df[idx,-c(1,2)]
train_y <- df[idx,2,drop=F]
test_x <- df[-idx,-c(1,2)]
test_y <- df[-idx,2,drop=F]
dim(df)
dim(train_x)
dim(train_y)
dim(test_x)
dim(test_y)
#Scaling
library(caret)
scale <- preProcess(train_x, method = 'range')
scaled_t_x <- predict(scale, train_x)
scaled_test_x <- predict(scale, test_x)
##모델1 : svm
library(e1071)
model_svm <- svm(train_y$loan_status ~.,
                 data = scaled_t_x)
pred_svm <- predict(model_svm,
                    newdata = scaled_test_x,
                    type = 'response')
caret :: confusionMatrix(pred_svm, reference = test_y$loan_status) #ACC=0.74
##모델2 : RF
library(randomForest)
model_rf <- randomForest(train_y$loan_status ~.,
                         data = scaled_t_x,
                         ntree = 300,
                         do.trace = T) #오류 뜸:Can not handle categorical predictors with more than 53 categories.
##모델3 : glm
model_glm <- glm(train_y$loan_status ~.,
                 data = scaled_t_x) #오류 뜸
##모델4 : rpart 
library(rpart)
model_rpart <- rpart(train_y$loan_status ~.,
                     data = scaled_t_x) # 자꾸 오류 뜸..
ls(model_rpart)
model_rpart$cptable
pred_rpart <- predict(model_rpart, 
                      newdata = scaled_test_x,
                      type = 'response')
caret :: confusionMatrix(pred_rpart, reference = test_y$loan_status)
#최종 모델로 svm선정
######################################################################
#최종모의고사 3회 p.3-9
#No.11
#1.ncases와 ncontrols를 합한 새로운 컬럼인 nsums를 생성
#2.이원 교차표를 생성하여 확인
#3.alcgp와 tobgp에 따른 nsums의 카이제곱 값을 구해라 
df <- esoph
View(df)
library(dplyr)
library(base)
library(Stats)
df <- df %>% mutate(nsums = ncases + ncontrols) #1해결
View(df)
table <- prop.table(table(df$alcgp, df$tobgp)) #아닌듯
table
taps <- xtabs(nsums ~ alcgp + tobgp, data = df)#2해결.교차분할표 생성 : xtabs : ~ 왼쪽 변수의 도수를 세는 것 
taps
chi <- chisq.test(taps) #카이제곱 검정(chisq.test)
result <- chi$statistic #3해결. 검정통계량 
result
chi$parameter #자유도
chi$p.value #p-value
chi$method
chi$data.name 
######################################################################
#No.12
#1.weight를 minmax scaling 진행
#2.#1 결과가 0.5 이상인 레코드 수
library(MASS)
data("ChickWeight")
df <- ChickWeight
View(df)
minmax <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}
df$weight <- minmax(df$weight) #1해결
row <- df %>% filter(weight >= 0.5) %>% summarise(n()) #2해결
row
######################################################################
#p.3-10 ★★★★★어려운 문제
#No.13
#1.glucose, pressure, mass의 결측 삭제
#2.age를 조건에 맞게 그룹화(1:20~40세, 2:41~59세, 3:60세 이상)
#3.발병률(diabetes 중 pos의 수/인원 수)이 가장 높은 나이 그룹의 발병률
library(mlbench)
data("PimaIndiansDiabetes2")
df <- PimaIndiansDiabetes2
View(df)
dim(df) 
colSums(is.na(df))
df1 <- df %>% filter(!is.na(glucose)&!is.na(pressure)&!is.na(mass)) #1해결 : 꼭 기억해두기
colSums(is.na(df1))
df1 <- df1 %>% mutate(age_gp = ifelse(age >= 60, "3",ifelse(age >=41, "2", "1"))) #2해결 : ifelse 안에 ifelse문 
df1
df2 <- df1 %>% group_by(age_gp) %>% summarise(age_n = n(),
                                       dia_pos = sum(diabetes == 'pos'),
                                       dia_percent = dia_pos/age_n) %>% arrange(desc(dia_percent)) #3해결
df2 <- as.data.frame(df2)
print(df2$dia_percent[1]) 
######################################################################
#작업형 2유형
#No.14
#1.charges(회귀)를 예측하고, RMSE가 가장 낮은 모델을 제출
df <- read.csv("C:/Users/dlrpa/Downloads/insurance.csv", header = T, fileEncoding = 'UTF-8-BOM')
View(df)
summary(df)
str(df)
df$sex <-as.factor(df$sex)
df$smoker <-as.factor(df$smoker)
df$region <-as.factor(df$region)
str(df)
