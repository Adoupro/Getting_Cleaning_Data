run_analysis <- function(){

# Let's load some packages

library(plyr); library(dplyr)


#Getting file on the computer

if(!file.exists('./project.zip')){
        link <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
        download.file( url = link, destfile = './project.zip', method = 'curl')
        unzip('./project.zip', exdir = './' )   
}

setwd( './UCI HAR Dataset' )


#Prepare the data into R

data_train <- read.table( 'train/X_train.txt', sep = '')
data_test <- read.table( 'test/X_test.txt', sep = '')

var <- read.table( 'features.txt', sep='')
names(data_train) <- var[ , 2]
names(data_test) <- var[ , 2]
rm(var)

sample <- rep( 'test', length(data_test[ , 1]))
subject <- read.table( 'test/subject_test.txt', sep = '')
activity <- read.table( 'test/y_test.txt', sep = '')

y_value <- cbind(sample, subject )
y_value <- cbind(y_value, activity )

data_test <- cbind(y_value, data_test)


sample <- rep( 'train', length(data_train[ , 1]))
activity <- read.table( 'train/y_train.txt', sep = '')
subject <- read.table( 'train/subject_train.txt', sep = '')

y_value <- cbind(sample, subject )
y_value <- cbind(y_value, activity )

data_train <- cbind(y_value, data_train)


#Merge and create the first dataset

data <- rbind(data_test, data_train)
colnames(data)[2] <- 'subject'
colnames(data)[3] <- 'activity'


#Select mean and standard deviation measurement

column_1 <- c('sample', 'subject', 'activity')
column_2 <- grep( 'mean|std' , names(data), value = TRUE)
column <- append(column_1, column_2 )
data <- data[ , column ]

data[ , 'activity'] <- mapvalues( data[ , 'activity'], from = c('1', '2', '3', '4', '5', '6'), to = c('walking', 'walking_upstairs', 'walking_downstairs', 'sitting', 'standing', 'laying' ) )  

names(data) <- gsub( '[()]|-', '', names(data) )

data[ , 'subject'] <- as.numeric(data[ , 'subject'])
data[ , 'activity'] <- as.factor(data[ , 'activity'])


#Caching the first dataset
dataset_1 <<- data


# Create second dataset

N <- unique(data['subject'])
N <- length(N[[1]])

new_data <- vector('list', N)

for( i in 1:N){
        subset <- filter(data, subject == i)
        subset <- aggregate( subset[,4:82], subset['activity'], mean)
        new_data[[i]] <- subset
}

#Caching the second dataset
dataset_2 <<- new_data

#End

setwd( '../' )

}

