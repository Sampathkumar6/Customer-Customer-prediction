
setwd("C:/Users/Sampath/Desktop/PROJECT")

#packages
library(car)     #for splitting data
library(dummies) #for adding dummy variables
library(pastecs) #for statistics
library(ggplot2) #for plotting
library(dplyr)   #for manipulating data tables
library(caTools) #for splitting data
#reading data.
main<-read.csv("main.csv")
main<-read.csv("main.csv",na.strings=c(""))

head(main)
dim(main)
str(main)

#str(main)
#main$DOJ<-as.data.frame(main$DOJ)
#str(main)
#renaming the column
colnames(main)[colnames(main)=="Age"] <- "age"
colnames(main)[colnames(main)=="main_body"]<-"main_body building"
str(main)
#to change the data types of columns.
main$age<-as.numeric(main$age)


#Identifying whether data is complete or not
complete.cases(main)
head(main)

#exact opposite to i.e which are not complete
main[!complete.cases(main),]

# Median Imputation for height
med_height=median(main [,"height"],na.rm = TRUE)
main[is.na(main$height),"height"]<-med_height
main

#Median Imputation for weight
med_weight=median(main[,"weight"],na.rm = TRUE)
main[is.na(main$weight),"weight"]<-med_weight
main

#Mean Imputation foe age
mean(main[,"age"],na.rm = TRUE)
mean_age=c("26")
main[is.na(main$age),"age"]<-mean_age
main

#mode imputation for purpose
val_purpose=unique(main$purpose[!is.na(main$purpose)])
mode_purpose=val_purpose[which.max(tabulate(match(main$purpose,val_purpose)))]
main[is.na(main$purpose),"purpose"]<-mode_purpose
main

#mode imputation for package
val_package=unique(main$package[!is.na(main$package)])
mode_package=val_package[which.max(tabulate(match(main$package,val_package)))]
main[is.na(main$package),"package"]<-mode_package
main

#mode imputation for Gender
val_Gender=unique(main$Gender[!is.na(main$Gender)])
mode_Gender=val_Gender[which.max(tabulate(match(main$Gender,val_Gender)))]
main[is.na(main$Gender),"Gender"]<-mode_Gender
main

#combining same categories
#main$purpose[main$purpose == "body"] = "body building"
#names(main)
main
main[!complete.cases(main),]


#feature engineering
#creating dummy variables for purpose
#main=cbind(main,dummy(main$purpose,sep = "_"))
#main
#names(main)
#main=main[c(1:9)]

#creating dummy variables for package
main=cbind(main,dummy(main$package,sep = "_"))
View(main)

#main=cbind(main,dummy(main$purpose,sep = "_"))
#View(main)
#main1=merge(main_dummy_purpose,main_dummy_package)
#View(main)
write.csv(main,file = "C:/Users/Sampath/Desktop/PROJECT/main.csv")

