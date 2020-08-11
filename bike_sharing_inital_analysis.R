## R Shiny Dashboard of “Bike Sharing Dataset” - Analysis ##

#Import the dataset
data <- read.csv('hour.csv')[,-1]
str(data)

#Data preparation
  #Arranging values and changing data type
data$yr <- as.factor(ifelse(data$yr == 0, '2011', '2012'))

data$mnth <- as.factor(months(as.Date(data$dteday), 
                              abbreviate = TRUE))

data$hr <- factor(data$hr)

data$weekday <- as.factor(weekdays(as.Date(data$dteday)))

data$season <- as.factor(ifelse(data$season == 1, 'Spring',
                                ifelse(data$season == 2, 'Summer',
                                       ifelse(data$season == 3, 
                                              'Fall', 'Winter'))))

data$weathersit <- as.factor(ifelse(data$weathersit == 1, 'Good',
                                    ifelse(data$weathersit == 2, 
                                           'Fair',
                                           ifelse(data$weathersit == 
                                                    3, 'Bad', 
                                                  'Very Bad'))))

data$holiday<-as.factor(ifelse(data$holiday == 0, 'No', 'Yes'))

data$workingday<-as.factor(ifelse(data$workingday == 0, 'No', 
                                  'Yes'))

  #Changing columns names
names(data)[names(data) == "registered"] <- "new"
names(data)[names(data) == "cnt"] <- "total"

  #Denormalizing the values
    #Temperature
for (i in 1:nrow(data)){
  tn = data[i, 10]
  t = (tn * (39 - (-8))) + (-8)
  data[i, 10] <- t
}

    #Feeling temperature
for (i in 1:nrow(data)){
  tn = data[i, 11]
  t = (tn * (50 - (-16))) + (-16)
  data[i, 11] <- t
}

    #Humidity
data$hum <- data$hum * 100

    #Wind speed
data$windspeed <- data$windspeed * 67

#Write the new file
data <- data[-1]
write.csv(data, "bike_sharing.csv", row.names = FALSE)

#Modeling
  #Dropping columns
data <- data[c(-1,-2,-7,-13,-14)]

  #Splitting data
library(caTools)

set.seed(123)
split = sample.split(data$total, SplitRatio = 0.8)
train_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)

    #Write new files for the train and test sets
write.csv(train_set, "bike_train.csv", row.names = FALSE)
write.csv(test_set, "bike_test.csv", row.names = FALSE)

  #Multilinear regression
multi = lm(formula = total ~ ., data = train_set)

    #Predicting the test values
y_pred_m = predict(multi, newdata = test_set)

    #Performance metrics
#install.packages('Metrics')
library(Metrics)

mae_m = mae(test_set[[10]], y_pred_m)
rmse_m = rmse(test_set[[10]], y_pred_m)
mae_m
rmse_m

  #Decision tree
library(rpart)

dt = rpart(formula = total ~ ., data = train_set,
           control = rpart.control(minsplit = 3))

    #Predicting the test values
y_pred_dt = predict(dt, newdata = test_set)

    #Performance metrics
mae_dt = mae(test_set[[10]], y_pred_dt)
rmse_dt = rmse(test_set[[10]], y_pred_dt)
mae_dt
rmse_dt

  #Random forest
library(randomForest)

set.seed(123)
rf = randomForest(formula = total ~ ., data = train_set,
                  ntree = 100)

    #Predicting the test values
y_pred_rf = predict(rf, newdata = test_set)

    #Performance metrics
mae_rf = mae(test_set[[10]], y_pred_rf)
rmse_rf = rmse(test_set[[10]], y_pred_rf)
mae_rf
rmse_rf

#Saving the model
saveRDS(rf, file = "./rf.rda")

#Single prediction value
test_pred<- test_set

values = data.frame(mnth = 'Jan', 
                    hr = '0', 
                    holiday = 'No', 
                    weekday = 'Saturday',
                    weathersit = 'Good',
                    temp = 3.28, 
                    atemp = 3.0014, 
                    hum = 81, 
                    windspeed = 0,
                    total = NA)

test_pred <- rbind(test_pred,values)

prediction <- predict(rf, newdata = test_pred[nrow(test_pred),-10])
prediction



