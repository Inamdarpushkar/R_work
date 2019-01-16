
# Different approaches to perform cross validation

##Data Split
library(caret)
library(klaR)

##load iris dataset
data(iris)

#p decides split 80% -can be used for the training the data 
trainIndex<-createDataPartition(iris$Species,p=0.8, list=FALSE)

#train and test data
data_train<-iris[trainIndex,]
data_test<-iris[-trainIndex,]

#building 1st model on training data

model<-NaiveBayes(Species~.,data=data_train)

#make predictions
x_test<-data_test[,1:4]
y_test<-data_test[,5]

predictions<-predict(model,x_test)

confusionMatrix(predictions$class,y_test)

#---------------------------------------------------------------------------------------------------------------

## Bootstrap

#define training control
train_control<-trainControl(method = "boot",number = 100)

#train the model
model<-train(Species~.,data=iris,trControl=train_control,method="nb")

print(model)


##II


#---------------------------------------------------------------------------------------------------------------
#k-fold regression

data(iris)

train_control<-tranControl(method="cv",number=10)















