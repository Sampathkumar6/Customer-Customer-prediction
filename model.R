#Feature Scaling
training_set=read.csv("training_set.csv")
test_set=read.csv("test_set.csv")

View(training_set)
View(test_set)
write.csv(training_set,file="C:/Users/Sampath/Desktop/PROJECT/training_set.csv")
write.csv(test_set,file="C:/Users/Sampath/Desktop/PROJECT/test_set.csv")
#fitting logistic regression to the training set.
classifier=glm(formula= main_1~.,family = binomial,data = training_set[c(4:8)])

#Predicting the test set results
prob_pred=predict(classifier, type = 'response', newdata = test_set[c(3:7)])
prob_pred

View(prob_pred)

y_pred=ifelse(prob_pred > 0.75,1,0)
#making confusion matrix
cm = table(y_pred,test[,11])
cm

#Confusion matrix plot
library(ggplot2)
Class1 <- factor(c(0, 0, 1, 1))
Class2 <- factor(c(0, 1, 0, 1))
Y=c(11,5,19,34)
df <- data.frame(TClass, PClass, Y)
ggplot(data = df, mapping = aes(x = Class1, y = Class2)) + geom_tile(aes(fill = Y), colour = "white") +  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1) +  scale_fill_gradient(low = "blue", high = "red") +  theme_bw() + theme(legend.position = "none")

#Roc curve
library(pROC)
g <- roc(test[,11] ~ y_pred)
plot(g)

#save(classifier,file = 'LogisticRegression.rda')
