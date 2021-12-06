install.packages('caret')
help(package="caret")

installed.packages()[,c(3,4)]

#p.2-165 
#작업형 제1유형
#No.1
#1. crim의 상위에서 10번째 값으로 상위 10개 값을 변환
#2. age>80인 값에 대해 crim의 평균
install.packages('mlbench')
library('mlbench')
data("BostonHousing")
df <- BostonHousing
View(df)
summary(df)
dim(df)
str(df)

install.packages('dplyr')
library(dplyr)
help(package='dplyr')
tenth <- df %>% arrange(desc(crim)) %>% select(crim)
print(tenth)
head(tenth, 10)
class(tenth)
tenth_1 <- tenth[10,]
print(tenth_1)
df$crim <- ifelse(df$crim > tenth_1,
             tenth_1,
             df$crim)                  #1해결
head(sort(df$crim, decreasing=TRUE),10) 
df

over_80 <- df %>% filter(age >= 80) %>% summarise(mean_crim = mean(crim)) 
over_80                                #2해결
class(over_80)

#p.2-166
#No.2
#1. 첫 번째 행부터 80%행까지 훈련데이터로 추출 
#2. total_bedrooms 결측값을 중앙값으로 대체
#3. 대체 전후의 표편 값 차이
df<- read.csv('housing.csv', header = TRUE)
View(df)
str(df)
summary(df)
library(base)
head(df)

idx<-sample(x = c("train", "test"),
            size = nrow(df),
            replace = TRUE,
            prob = c(4,1))
train <- df[idx == 'train',]       #1해결
test <- df[idx == 'test',]
dim(train)
dim(test)
dim(df)

before_sd <- sd(df$total_bedrooms, na.rm=T)
df$total_bedrooms <- ifelse(is.na(df$total_bedrooms),
                            median(df$total_bedrooms, na.rm=TRUE),
                            df$total_bedrooms)
summary(df)
colSums(is.na(df))                #2해결
after_sd <- sd(df$total_bedrooms)
print(abs(before_sd - after_sd))  #3해결

#No.3
#1. 이상값은 평균에서 1.5 표편 이상인 값
#2. Charges의 이상값 합
df <- read.csv("C:/Users/dlrpa/Downloads/insurance.csv",header = T)
View(df)
dim(df)
summary(df)
str(df)
# 이상값 궁금해서 확인
Charges_box <- boxplot(df$charges)
Charges_box$out
Charges_box$stats
esd <- function(x){
  return(x >= mean(x,na.rm=T)+1.5*sd(x,na.rm=T)|
           x <= mean(x,na.rm=T)-1.5*sd(x,na.rm=T))
}                           #1해결
outlier <-esd(df$charges)   # 이렇게 쓰면 이상값이 맞냐 아니냐로 나오고
outlier_sum <- sum(outlier) # 이상값의 개수가 나온다.
print(outlier_sum)          # 그렇게 해서 156개(이상값 개수) 나온다. 

df_1 <- df %>% filter(esd(charges)) %>% select(charges) # dplyr써야 함
outlier_sum <- sum(df_1$charges)
print(outlier_sum)

#p.2-168
#2유형
#No.1 (책과는 다르게 10,999행 존재)
#1.정시도착 가능여부 예측 모델 생성
#2.예측 확률을 기록한 CSV 생성
df <- read.csv("C:/Users/dlrpa/Downloads/Train.csv", header = T,
               fileEncoding = "UTF-8-BOM")
View(df) #fileEncoding으로 1열명 오류 해결
summary(df)
str(df)
dim(df)
df$Reached.on.Time_Y.N <- as.factor(df$Reached.on.Time_Y.N) #종속변수 타입 변환
str(df)
#결측 확인
colSums(is.na(df)) 
#D Split
set.seed(1234)
idx <- sample(1:nrow(df),
              size = 0.8*nrow(df))
train <- df[idx,]
test <- df[-idx,]
dim(train)
dim(test)
dim(df)
train_x <- train[,-12]
train_y <- train[,12] #이렇게 하면 NULL이 나와 실패이고,
test_x <- test[,-12]
test_y <- test[,c(1,12)]
dim(train_x)
View(train_x)
train_y <- train[,c(1,12)] # 이렇게 해야 된다. 
dim(train_y)
View(train_y)
View(test_y)
#모델링 생성: 이진분류니까 svm, glm, RF 가능
#여러 모델을 비교할 것이기 때문에 scaling 진행
library(caret)
prepro <- preProcess(train_x,method = 'range')
scaled_x <- predict(prepro, train_x)
scaled_test_x <- predict(prepro, test_x)
##1) glm ##
model_glm <- glm(train_y$Reached.on.Time_Y.N ~.-ID,
                 family = binomial,   #binomial 필수
                 data = scaled_x)     
summary(model_glm)
model_glm_step <- step(model_glm, direction = 'both') #변수선택
summary(model_glm_step)
pred_glm_step <- predict(model_glm_step,
                         newdata = scaled_test_x,
                         type = 'response') #예측 
summary(pred_glm_step)
pred_glm_result <- ifelse(pred_glm_step >= 0.5, 1, 0)
pred_glm_result
pred_glm_result <- as.factor(pred_glm_result)
confusionMatrix(data = pred_glm_result, reference = test_y$Reached.on.Time_Y.N)
# Accuracy = 0.6445
# 만약 스케일링 안 하고 하면?
model_glm_1 <- glm(train_y$Reached.on.Time_Y.N ~.-ID,
                 family = binomial,   #binomial 필수
                 data = train_x)   
model_glm_step_1 <- step(model_glm_1, direction = 'both')
pred_glm_step_1 <- predict(model_glm_step_1,
                         newdata = test_x,
                         type = 'response')
pred_glm_result_1 <- ifelse(pred_glm_step_1 >=0.5, 1, 0)
pred_glm_result_1 <- as.factor(pred_glm_result_1) ##glm 필수 부분 
confusionMatrix(pred_glm_result_1, reference = test_y$Reached.on.Time_Y.N)
# Accuracy = 0.6445로 똑같다. 

## 2)svm ##
library(e1071)
model_svm <- svm(train_y$Reached.on.Time_Y.N ~.-ID,
                 data = scaled_x)
summary(model_svm)
pred_svm <- predict(model_svm,
                    newdata = scaled_test_x,
                    type = 'response') #예측
confusionMatrix(pred_svm, reference = test_y$Reached.on.Time_Y.N) 
#Accuracy = 0.6805

## 3)RF ##
install.packages('randomForest')
library(randomForest)
model_rf <- randomForest(train_y$Reached.on.Time_Y.N ~ .-ID,
                         data = scaled_x,
                         ntree = 300)
summary(model_rf)
pred_rf <- predict(model_rf, 
                   newdata = scaled_test_x,
                   type = 'response')
confusionMatrix(pred_rf, reference = test_y$Reached.on.Time_Y.N)
# Accuracy = 0.6641 만약 randomForest 옵션 중 ntree=500, do.trace = T로 두면?
help("randomForest")
model_rf_1 <- randomForest(train_y$Reached.on.Time_Y.N ~ .-ID,
                         data = scaled_x,
                         ntree = 500,
                         do.trace = T)
pred_rf_1 <- predict(model_rf_1, 
                     newdata = scaled_test_x,
                     type = 'response')
confusionMatrix(pred_rf_1, reference = test_y$Reached.on.Time_Y.N)
# Accuracy = 0.6727 좀 더 올라갔다!

# 모델 선택 및 제출
# svm이 가장 높았고, svm은 스케일 필수 모델이니까 스케일 된 데이터로 진행하자.
View(pred_svm)
write.csv(pred_svm, "수험번호.csv", row.names=F) #row.names = T로 하면 필요없는 index까지 출력
read.csv("수험번호.csv", header = T)
