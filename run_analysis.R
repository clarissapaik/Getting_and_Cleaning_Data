library(utils)
library(dplyr)
library(stringr)
library(tidyr)
library(reshape2)

testData <- cbind(read.table("./UCI HAR Dataset/test/X_test.txt"), 
                  read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity"),
                  read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject"))


trainData <- cbind(read.table("./UCI HAR Dataset/train/X_train.txt"), 
                  read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity"),
                  read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject"))

allData <- rbind(testData, trainData)

features <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = "\n")

features <- filter(features, 
                    str_detect(V1,"-mean()") == TRUE | str_detect(V1,"-std()") == TRUE)

features <- filter(features, 
                    str_detect(V1,"-meanFreq()") == FALSE)

features <- separate(features, V1, c("index","name"), sep = " ")

features <- mutate(features, index = as.integer(index))

smallData <- allData[,c(features$index,562, 563)]

names(smallData) <- c(features$name,"activity","subject")

tidyData <- melt(smallData, id=c("activity","subject"), measure.vars = features$name)

tidyData <- mutate(tidyData, activity = ifelse(activity==1, "Walking",
                                               ifelse(activity==2, "Walking upstairs",
                                                      ifelse(activity==3, "Walking downstairs",
                                                             ifelse(activity==4, "Sitting",
                                                                    ifelse(activity==5, "Standing",
                                                                           ifelse(activity==6, "Laying","NA")))))))

tidyData <- rename(tidyData, measurement = variable)

tidyData <- tidyData %>%
  group_by(activity,subject,measurement) %>%
  summarise(mean = mean(value))
