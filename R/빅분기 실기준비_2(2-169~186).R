#p.2-169
#작업형 1유형
#No.1
#1.Solar.R 결측 행을 제거
#2.Ozone 결측을 중앙값으로 대체 
#3.중앙값으로 대체 전후의 Ozone 표편 차이
df <- airquality
summary(df)
library(dplyr)
library(stats)
colSums(is.na(df))
df <- na.omit(df$Solar.R) # 왜 안되지.. 왜냐하면 안되는 거니까..!
## na.omit은 결측행 전부 제거 때만 사용
df<-df[!is.na(df$Solar.R),] # 이렇게 해야 한다. 
summary(df)  # 1해결

before_sd <- sd(df$Ozone, na.rm = T)
df$Ozone <- ifelse(is.na(df$Ozone),
                   median(df$Ozone, na.rm = T),
                   df$Ozone)  #2해결
summary(df)
after_sd <- sd(df$Ozone, na.rm = T)
before_sd
after_sd
diff <- abs(before_sd - after_sd)
print(diff) #3해결
#####################################################################
#p.2-170
#No.2
#1.이상값은 중위수에서 IQR 2배 초과 값
#2.salary의 이상값 합
install.packages("ISLR")
library(ISLR)
data(Hitters)
df <- Hitters
str(df)
summary(df)
library(stats)
outlier <- function(x){
  return(x > median(x, na.rm=T) + 2*IQR(x,na.rm=T)|
           x < median(x, na.rm=T) - 2*IQR(x, na.rm=T))
} #1해결
salary_out <- df %>% filter(outlier(Salary)) %>% select(Salary) #select 있어야 함
summary(salary_out)
sum_outlier <- sum(salary_out)
print(sum_outlier) #2해결
#####################################################################
#p.2-171
#No.3
#1.데이터를 위에서부터 80%로 훈련 데이터 생성
#2.price를 기준으로 상위 100개 데이터
#3.#2에 대한 price 평균
library(ggplot2)
data("diamonds")
df <- diamonds
summary(df)
library(base)
idx <- sample(x = c('train', 'test'),
              size = nrow(df),
              replace = T,
              prob = c(4,1))
train <- df[idx=='train',]
test <- df[idx=='test',]
dim(df)
dim(train)
dim(test)  #1해결이 안 됨 -> 위에서부터 순서대로라고 했음. sample 쓰면 안 됨
nrow <- dim(df)[1]*0.8
nrow
train <- df[1:nrow,]
dim(train) #1해결

price_top100 <- head(sort(train$price, decreasing = T), 100)
price_top100
top100_mean <- mean(price_top100)
print(top100_mean) #2해결

price_down <- df %>% arrange(desc(price)) %>% select(price)
top100 <- price_down[1:100,]
tail(top100)
as.data.frame(top100)
str(top100)
mean_top100 <- mean(top100$price)
print(mean_top100) #2 해결. 다른 방법
######################################################################
#p.2-172
#No.4
#1.데이터 순서대로 90%를 훈련 데이터로 추출
#2.Ozone의 결측을 평균으로 변경
#3.대체 전후의 중앙값 차이
df <- airquality
train <- df[c(1:(nrow(df)*0.9)),]
dim(df)
dim(train) #1해결
colSums(is.na(df))
before_median <- median(df$Ozone, na.rm=T)
df$Ozone <- ifelse(is.na(df$Ozone),
                   mean(df$Ozone, na.rm=T),
                   df$Ozone)
colSums(is.na(df)) #2해결
after_median <- median(df$Ozone, na.rm=T)
diff <- abs(before_median - after_median)
print(diff)
######################################################################
#No.5
#1.tempo 상위 25%, 하위 25%를 0으로 대체
#2.훈련 데이터 생성
#3.tempo의 평균+표편
df <- read.csv('C:/Users/dlrpa/Downloads/data.csv', header=T)
View(df)
tempo_box <- boxplot(df$tempo)
tempo_box[1]
quantile(df$tempo) #boxplot으로 구하는 위 방법과 둘 중 하나 쓰면 됨
df$tempo <- ifelse(df$tempo<=99.38401|
                     df$tempo >=135.99918,
                   0,
                   df$tempo) #1해결
df$tempo
train <- df
View(train) #2해결
tempo_mean <- mean(train$tempo, na.rm=T)
tempo_sd <- sd(train$tempo, na.rm=T)
print(tempo_mean + tempo_sd) #3해결
######################################################################
#p.2-173
#No.6
#1.이상값은 평균에서 1.5 표편 이상인 값
#2.totalcharges 이상값 제외한 평균
df <- read.csv('C:/Users/dlrpa/Downloads/WA_Fn-UseC_-Telco-Customer-Churn.csv', header=T)
View(df)
outlier <- function(x){
  return (x < mean(x, na.rm=T)+1.5*sd(x, na.rm=T)&
            x > mean(x, na.rm=T)-1.5*sd(x, na.rm=T))
} #1해결
df %>% filter(outlier(TotalCharges)) %>% summarise(mean = mean(TotalCharges)) #2해결
######################################################################
#No.7
#1.이상값은 평균에서 1.5 표편 이상인 값
#2.Hwt 이상값의 평균
library(MASS)
data(cats)
df <- cats
View(df)
outlier <- function(x){
  return (x >= mean(x, na.rm=T) +1.5*sd(x, na.rm=T)|
            x <= mean(x, na.rm=T)-1.5*sd(x, na.rm=T))
}
df %>% filter(outlier(Hwt)) %>% summarise(mean = mean(Hwt))
######################################################################
#p.2-174
#No.8
#1.demage >=1 경우의 temp와 damage 간의 피어슨 상관계수
install.packages('faraway')
library(faraway)
data(orings)
df <- orings
View(df)
df <- df %>% filter(damage >=1)
View(df)
cor(df$temp, df$damage, method = 'pearson') #1해결
######################################################################
#No.9
#1.am=1 중에서 wt가 가장 적은 10개 데이터
#2.#1의 mpg 평균
#3.am=0 중에서 wt가 가장 적은 10개 데이터
#4.#3의 mpg 평균
#5.#2와 #4의 차이
df <- mtcars
View(df)
am1 <- df %>% filter(am == 1) %>% arrange(wt) %>% head(10) #1해결
am1
am11 <- df %>% filter(am ==1) %>% arrange(wt)
am111 <- mean(am11$mpg[1:10])
am111 #1해결 다른 방법 
mpg_mean1 <- mean(am1$mpg) #2해결
mpg_mean1 
am0 <- df%>% filter(am==0) %>% arrange(wt) %>% head(10) #3해결
am0
mpg_mean0 <- mean(am0$mpg) #4해결
mpg_mean0
diff <- abs(mpg_mean1-mpg_mean0)
diff #5해결
######################################################################
#p.2-175
#No.10
#1.데이터를 순서대로 80%를 제거 
#2.cut='fair'이면서 carat>=1인 price의 최대값
data("diamonds")
df <- diamonds
View(df)
df<-df[-c(1:(nrow(df)*0.8)),]
dim(df) #1해결
df
df %>% filter(cut=='Fair'& carat >= 1) %>% summarise(max = max(price)) #2해결
######################################################################
#p.2-176
#No.11
#1.8월 20일의 Ozone 값
df <- airquality
View(df)
df1 <- df %>% filter(Month == 8 & Day == 20) %>% select(Ozone)
df1 #1해결
######################################################################
#No.12
#1.Sepal.Length의 mean
#2. Sepal.Width의 mean
#3.#1+#2
df <- iris
len <- mean(df$Sepal.Length, na.rm=T) #1해결
wid <- mean(df$Sepal.Width, na.rm=T) #2해결
sum <- sum(len + wid)
print(sum) #3해결
######################################################################
#p.2-177
#No.13
#1.cyl=4의 비율
df <- mtcars
prop <- prop.table(table(df$cyl)) #table도 같이 써야 함 
prop
prop[1] #1해결
######################################################################
#No.14
#1.gear=4이고 am=1인 데이터에서 
#2.mpg의 평균과 hp의 표편 합
df1 <- df %>% filter(gear == 4 & am ==1) #1해결 
mpg_mean <- mean(df1$mpg, na.rm=T)
hp_sd <- sd(df1$hp, na.rm=T)
sum <- mpg_mean + hp_sd #2해결
sum 
######################################################################
#p.2-178
#No.15
#1.crim <=1에서의 medv의 mean
df <- BostonHousing
df %>% filter(crim <= 1) %>% summarise(mean = mean(medv, na.rm=T)) #1해결
######################################################################
#p.2-179
#No.16
#1.Species = virginica에서 Sepal.Length >6이면 1, 아니면 0인 파생 컬럼 Len 생성
#2. Len의 sum 
df <- iris 
df %>% filter(Species == 'virginica') %>% mutate(Len=ifelse(Sepal.Length >6, 1, 0)) %>% summarise(sum = sum(Len)) #1,2해결
######################################################################
#No.17
#1.Ozone의 결측을 평균으로 대체하고,
#2.Ozone의 median 값에서 2*IQR떨어진 값 사이에 존재하는 Ozone의 합
df <- airquality
colSums(is.na(df))
df$Ozone <- ifelse(is.na(df$Ozone),
                   mean(df$Ozone, na.rm=T),
                   df$Ozone) #1해결
colSums(is.na(df))
library(stats)
outlier <- function(x){
  return (x < median(x, na.rm=T) + 2*IQR(x,na.rm=T)&
            x > median(x, na.rm=T) - 2*IQR(x,na.rm=T))
}
df %>% filter(outlier(Ozone)) %>% summarise(sum = sum(Ozone)) #2해결
######################################################################
#p.2-180
#No.18
#1.Hair = brown Hair이고 Eye = Brown Eyes인 데이터로 훈련 데이터 생성
#2.appearances에서 이상값을 제외한 평균 
df <- read.csv("C:/Users/dlrpa/Downloads/marvel-wikia-data.csv", header=T)
df
train <- df %>% filter(HAIR == 'Brown Hair' & EYE == 'Brown Eyes') #1해결
View(train)
sum(is.na(train$APPEARANCES))
outlier <- function(x){
  return (x < mean(x, na.rm=T) + 1.5*IQR(x, na.rm=T)&
            x > mean(x, na.rm=T) - 1.5*IQR(x, na.rm=T))
}
train %>% filter(outlier(APPEARANCES)) %>% summarise(mean = mean(APPEARANCES,na.rm=T)) #답은 20.52006인데 난 왜 27.12371로 나오지..
sum(is.na(train$HAIR))
sum(is.na(train$EYE)) 
######################################################################
#No.19
#1.Time=10인 데이터로 훈련 데이터 생성
#2.weight이 상위 30번째 이상의 값은 weight평균으로 변환
#3.변환 전후의 평균 차이
library(MASS)
data("ChickWeight")
df <- ChickWeight
str(df)
train <- df %>% filter(Time == 10) #1해결
topdown <- train %>% arrange(desc(weight))
topdown
before_mean <- mean(train$weight, na.rm=T)
before_mean
top30 <- topdown[30,]
top30
train$weight <- ifelse(train$weight >= 103,
                         before_mean,
                         train$weight) #2해결
after_mean <- mean(train$weight, na.rm=T)
after_mean
diff <- abs(after_mean - before_mean) #3해결
diff
######################################################################
#p.2-181
#No.20
#1.total_points가 상위 3위인 국가를 선택(위 문제와 비슷)
#2.#1에서 구한 국가의 total_point 평균
df <- read.csv("C:/Users/dlrpa/Downloads/fifa_ranking.csv", header=T)
View(df)
df1 <- df %>% arrange(desc(total_points))
top3 <- df1$total_points[3]
top3_country <- df1$country_abrv[3] #1해결
ger_mean <- df %>% filter(country_abrv == 'GER') %>% summarise(mean = mean(total_points, na.rm=T))
ger_mean #2해결
######################################################################
#p.2-182
#No.21
#1.가장 많이 판매된 item_id 3개
#2.전체 상품에 대한 item_price 표편과  
#3.#1에 대한 item_price 표편의 차이 
df <- read.csv("C:/Users/dlrpa/Downloads/sales_train_v2.csv", header=T)
View(df)
str(df)
top_sell <- df %>% group_by(item_id) %>% summarise(n = n()) %>% arrange(desc(n)) # group_by를 쓰는 게 아이디어! 
class(top_sell)
top_sell <- as.data.frame(top_sell)
class(top_sell)
top_sell
top3_item <- top_sell$item_id[1:3] #1해결
top3_item # '20949', '5822', '17717'
str(df)
full_item_sd<-df %>% summarise(full_item_sd = sd(item_price, na.rm=T)) #1729.8
top3_item_sd<-df %>% filter(item_id == 20949 | item_id == 5822 | item_id == 17717) %>% summarise(top3_item_sd = sd(item_price, na.rm=T)) #2해결
top3_item_sd
diff <- abs(full_item_sd - top3_item_sd) #3해결 : 왜 책은 1101.796이고, 나는 1729.402지.. =>filter에서 조건을 or로 해야 함 
diff
######################################################################
#p.2-183
#작업형 2유형
#No.1
#1.Churn(고객의 이탈 여부, 이진분류)을 예측하고 csv로 제출
#이진 분류니까 RF, glm, svm
df <- read.csv("C:/Users/dlrpa/Downloads/WA_Fn-UseC_-Telco-Customer-Churn.csv")
View(df)
set.seed(1234)
colSums(is.na(df))
df <-na.omit(df)
colSums(is.na(df))
str(df)
summary(df)
library(base)
#D.split
idx <- sample(1:nrow(df),
              size = 0.8*nrow(df),
              replace = F)
train_x <- df[idx,-21]
train_y <- df[idx,c(1,21)]
test_x <- df[-idx, -21]
test_y <- df[-idx,c(1,21)]
dim(df)
dim(train_x)
dim(train_y)
dim(test_x)
dim(test_y)
idx_1 <- sample(1:nrow(train_x),
                size = 0.8*nrow(train_x),
                replace = F)
train_x <- train_x[idx_1,]
train_y <- train_y[idx_1,]
valid_x <- train_x[-idx_1,]
valid_y <- train_y[-idx_1,]
dim(train_x)
dim(train_y)
dim(valid_x)
dim(valid_y)
#Scaling(train_x, valid_x, test_x)
library(caret)
scale <- preProcess(train_x, method = 'range')
scaled_t_x <- predict(scale, train_x)
scaled_v_x <- predict(scale, valid_x)
scaled_test_x <- predict(scale, test_x)
dim(scaled_t_x)
#y변수(Churn) 범주형으로 변환
train_y$Churn <- as.factor(train_y$Churn)
valid_y$Churn <- as.factor(valid_y$Churn)
test_y$Churn <- as.factor(test_y$Churn)
str(train_y)
str(valid_y)
##모델링 : glm
model_glm <- glm(train_y$Churn ~ .-customerID,
                 data = scaled_t_x,
                 family = binomial)
dim(scaled_t_x)
model_glm_step <- step(model_glm, direction="both")
summary(model_glm_step)
#예측
pred_glm <- predict(model_glm_step, 
                    newdata = scaled_v_x,
                    type = 'response')  #오류 뜸 : In predict.lm(object, newdata, se.fit, scale = 1, type = if (type ==  :
                                        #prediction from a rank-deficient fit may be misleading
                                        #찾아보니 독립변수가 너무 많아서 그렇다고 한다..glm은 포기쓰
##모델링2 : svm
library(e1071)
model_svm <- svm(train_y$Churn ~ .-customerID,
             data = scaled_t_x)
pred_svm <- predict(model_svm, 
                    newdata = scaled_v_x,
                    type = 'response')
confusionMatrix(pred_svm, reference = valid_y$Churn) #Accuracy = 0.7969
library(ModelMetrics)
auc(actual = valid_y$Churn, predicted = pred_svm) #AUC = 0.6749
rmse_svm <- rmse(valid_y$Churn, pred_svm) #RMSE = 0.4507
rmse_svm 
##모델링3 : RF
library(randomForest)
model_rf <- randomForest(train_y$Churn ~ .-customerID,
                         data = scaled_t_x,
                         ntree = 300,
                         do.trace = T)
model_rf_400 <- randomForest(train_y$Churn ~ .-customerID,
                             data = scaled_t_x,
                             ntree = 400,
                             do.trace = T)
pred_rf <- predict(model_rf, 
                   newdata = scaled_v_x,
                   type = 'response')
caret :: confusionMatrix(pred_rf,reference = valid_y$Churn) #오류 뜸:Error in confusionMatrix(pred_rf, reference = valid_y$Churn) : 
                                       #unused argument (reference = valid_y$Churn)
                                       #위와 같은 이유로 나오지 않는다. caret :: 붙이고 썼더니 Accuracy = 0.9822 
auc(actual = valid_y$Churn, predicted = pred_rf) #AUC = 0.9711
rmse_rf <- rmse(valid_y$Churn,pred_rf) #RMSE = 0.1373 
rmse_rf
#ntree = 400은 오히려 성능이 떨어진다. 
# RF가 더 우수하므로 RF로 제출한다. RF는 scale이 필요 없기 때문에 스케일 없는 버전으로 제출
model_rf_1 <- randomForest(train_y$Churn ~ .-customerID,
                           data = train_x,
                           ntree = 300,
                           do.trace = T)
pred_rf_1 <- predict(model_rf_1, 
                     newdata = test_x,
                     type = 'response') 
length(pred_rf_1) #1407
length(test_y$Churn) #1407
caret::confusionMatrix(pred_rf_1, reference = test_y$Churn) #Accuracy=0.8109
auc(actual = test_y$Churn, predicted = pred_rf_1) #AUC=0.7159
rmse_result <- rmse(test_y$Churn, pred_rf_1)
rmse_result #RMSE = 0.4348
#제출
write.csv(pred_rf_1, '수험번호.csv', row.names = F)
dff <- read.csv('수험번호.csv', header = T)
View(dff)

#추가로 스케일 안 한 데이터로 했을 때 성능이 별로여서 스케일 데이터로 다시 해보자
model_rf_2 <- randomForest(train_y$Churn ~ .-customerID,
                          data = scaled_t_x,
                          ntree = 300,
                          do.trace = T)
pred_rf_2 <- predict(model_rf_2, 
                     newdata = scaled_test_x,
                     type = 'response') 
caret :: confusionMatrix(pred_rf_2, reference = test_y$Churn) #Accuracy = 0.8131으로 좀 더 높다.
auc(actual = test_y$Churn, predicted = pred_rf_2) #AUC = 0.7193으로 좀 더 높다.
rmse_result_2 <- rmse(test_y$Churn, pred_rf_2)
rmse_result_2 #RMSE = 0.4323 으로 좀 더 낮다. 
#스케일 데이터가 성능이 아주 조금 높다. 
######################################################################
#p.2-185
#No.2
#1.훈련:평가 = 7:3으로 분할 후 mpg를 예측 
#회귀 예측이므로 lm, RF를 사용한다.
df <- mtcars
summary(df)
#D.Split
set.seed(12345)
idx <- sample(1:nrow(df),
              size = 0.7*nrow(df),
              replace = T)
train <- df[idx,]
test <- df[-idx,]
dim(df)
dim(train)
dim(test)
train_x <- train[,-1]
train_y <- train[,1,drop=F] #하나의 열로도 데이터프레임 형태 유지! 중요
test_x <- test[,-1]
test_y <- test[,1,drop=F]
dim(train_x)
dim(test_x)
dim(train_y)
dim(test_y)
##모델1 : lm
model_lm <- lm(train_y$mpg ~.,
               data = train_x)
step_lm <- step(model_lm, direction = 'both')
pred_lm <- predict(step_lm,
                   newdata = test_x,
                   type = 'response')
rmse_lm <- rmse(actual = test_y$mpg, predicted = pred_lm)
rmse_lm #RMSE = 3.2095
##모델2 : RF
model_rf <- randomForest(train_y$mpg ~.,
                         data = train_x,
                         ntree = 300,
                         do.trace = T)
pred_rf <- predict(model_rf, 
                   newdata = test_x,
                   type = 'response') 
rmse_rf <- rmse(actual = test_y$mpg, predicted = pred_rf)
rmse_rf #RMSE = 2.9683으로 lm보다 좋은 성능이다. 최종 모델로 결정
#제출
write.csv(pred_rf,'0001.csv', row.names=F)
read.csv('0001.csv', header = T)
