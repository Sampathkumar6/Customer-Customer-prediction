#splitting data into train and test
set.seed(123)
sample<-sample.split(main$package,SplitRatio = 0.7)
train<-main[sample,]
test<-main[!sample,]
#write.csv(train,file="C:/Users/Sampath/Desktop/PROJECT/trainfinal.csv")
#write.csv(test,file="C:/Users/Sampath/Desktop/PROJECT/testfinal.csv")

#correlation
cor(main[,"package"],main[,"age"])
cor(main[,"package"],main[,"Gender"])
cor(main[,"package"],main[,"height"])
cor(main[,"package"],main[,"weight"])

#VLF
# train_reg<-lm(train$main_1~train$age+train$Gender+train$main_fitness)
# train_reg
# vif(train_reg)
# train_reg1<-lm(train$main_1~train$main_fitness+train$main_body.building+train$Gender)
# train_reg1
# vif(train_reg1)
