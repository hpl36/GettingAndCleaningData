##
## First load the features.txt file that contains the name of all variables
## Be careful in order not to load them as factors, set the colClasses accordingly
variableNames<-read.table(".\\UCI HAR Dataset\\features.txt",colClasses="character")

## Then transform this 561 rows matrix into a 561 columns vector
## To keep only the names of variables
vectorNames <- matrix(nrow=1,ncol=nrow(variableNames))
vectorNames[1,] <- variableNames[,2]

##
## Then read the data in X_train and X_test
## Take this opportunity to specify column names when reading the 1st data set
trainData<-read.table(".\\UCI HAR Dataset\\train\\X_train.txt",
				col.names=vectorNames)
testData<-read.table(".\\UCI HAR Dataset\\test\\X_test.txt",
				col.names=vectorNames)

## Row bind the 2 train + test data sets
tidyData<- rbind(trainData, testData)

##
## Now read the subject_train and subject_test
trainData<-read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",
				col.names=c("Subject"))
testData<-read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",
				col.names=c("Subject"))

## Rbind the two before cbinding them into data
tmpData<- rbind(trainData,testData)
tidyData<- cbind(tidyData,tmpData)

##
## Now read the y_train and y_test
trainData<-read.table(".\\UCI HAR Dataset\\train\\y_train.txt",
				col.names=c("Activity"))
testData<-read.table(".\\UCI HAR Dataset\\test\\y_test.txt",
				col.names=c("Activity"))

## Rbind the two before cbinding them into data
tmpData<- rbind(trainData,testData)
tidyData<- cbind(tidyData,tmpData)

##
## Now grep on all the column names of tidyData that contains: std, mean but keep Subject and Activity
indexToKeep <- c(ncol(tidyData)-1,ncol(tidyData))
indexToKeep <- append(indexToKeep,grep("std",names(tidyData)))
indexToKeep <- append(indexToKeep,grep("mean",names(tidyData)))

# Order the indexes and restrict tidyData to those columns
tidyData <- tidyData[sort(indexToKeep)]

##
## Replace in the Activy column the numeric values into descriptions
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==1),"WALKING")
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==2),"WALKING_UPSTAIRS")
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==3),"WALKING_DOWNSTAIRS")
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==4),"SITTING")
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==5),"STANDING")
tidyData$Activity <- replace(tidyData$Activity,which(tidyData$Activity==6),"LAYING")

##
## Then do a double split per Subject and then per Activity 
## and apply the mean function on all columns
tidyData<-ddply(tidyData,.(Subject,Activity),numcolwise(mean))

##
## Dump the tidyData dataframe onto a .txt file
write.table(tidyData,file=".\\tidyData.txt",row.names=FALSE)