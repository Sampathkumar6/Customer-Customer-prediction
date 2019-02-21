#DESCRIPTIVE STATITICS
stat.desc(main[c(4)])  #age
stat.desc(main[c(6)])  #height
stat.desc(main[c(7)])  #weight
stat.desc(main[c(9)])  #package
main
names(main)
summary(main)
#EDA(Exploratory data analysis)
#bar plor for age
age_bar=ggplot(main) + geom_bar(aes(main$age), fill = "darkgreen")+xlab("age")+ylab("years")
age_bar

#bar plot for purpose
main$purpose[main$purpose == "body building"]<-"body"
purpose_bar=ggplot(main %>% group_by(purpose) %>% summarise(Count = n())) + geom_bar(aes(purpose, Count), stat = "identity", fill = "coral1")+xlab("purpose")+ylab("count")
purpose_bar


#histogram for height
height_hist = ggplot(main) + geom_histogram(aes(height), fill = "blue")
height_hist

#histogram for weight
weight_hist=ggplot(main) + geom_histogram(aes(weight),  fill = "blue")
weight_hist



#writing
#write.csv(main,file="C:/Users/Sampath/Desktop/PROJECT/mainupdated.csv")

#frequency of variables
table(main$age)     #age
table(main$height)  #height
table(main$weight)  #weight        
table(main$purpose) #purpose
table(main$package) #package
table(main$DOJ)     #DOJ

