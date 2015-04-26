library(lubridate)
library(dplyr)

#download and unzip data
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dt <- Sys.time()
timestamp_vect <- as.character(c(year(dt),month(dt),day(dt),hour(dt),minute(dt),"00"))
timestamp_vect<-sapply(timestamp_vect,function(x){if (nchar(x) ==1) {x <- paste(c("0",x), collapse = "")}else{x<-x}})
directory <- paste(c("COURSE_PROJECT",timestamp_vect), collapse = "")
destination_path <- paste(c(getwd(),directory),collapse = "/")
dir.create(destination_path)
file_name <- "course_project.zip"
dest_file_path <- paste(c(destination_path,file_name),collapse = "/")

download.file(file_url,dest_file_path)
unzip(dest_file_path,exdir = destination_path)


#read test data
files <- c("subject_test.txt","X_test.txt","y_test.txt")
files <- sapply(files,function(x){paste(c(destination_path,"UCI HAR Dataset","test",x),collapse = "/")})

subject_test <- read.table(files[1]) #(2947x1) (ID subjektu)
x_test <- read.table(files[2]) #(2947x561) (datova sada)
y_test <- read.table(files[3]) #(2947x1) (ID aktivity)

#read train data
files <- c("subject_train.txt","X_train.txt","y_train.txt")
files <- sapply(files,function(x){paste(c(destination_path,"UCI HAR Dataset","train",x),collapse = "/")})

subject_train <- read.table(files[1]) #(7352x1) 
x_train <- read.table(files[2]) #(7352x561)
y_train <- read.table(files[3]) #(7352x1)

#create test dataset
test <- cbind(subject_test,y_test,x_test) #(2947, 563)
#create train dataset
train <- cbind(subject_train,y_train,x_train) #(7352, 563)
#put train and test datasets together
data <- rbind(test,train) #(10299,563)

#read helping data (features and activity information)
files <- c("features.txt","activity_labels.txt")
files <- sapply(files,function(x){paste(c(destination_path,"UCI HAR Dataset",x),collapse = "/")})

features <- read.table(files[1])
activity <- read.table(files[2])

#create names of variable based on features.txt
names <- c("subjektId","activityId",as.character(features[,2]))
names(data) <- names

#subsetting of data (choose only variables which contains mean and std values)
req_data <- data[,c(1,2,grep("mean()|std()|meanFreq()",names))]

#adjusment of variable names
names <- names(req_data)
from <- c("(",")","-")
to <- c("","","_")
fixed <- c(TRUE,TRUE,TRUE)
for (i in seq_along(from)){
    names <- gsub(from[i],to[i],names,fixed = fixed[i])
}
names(req_data) <- names

#replace activity number with activity name
names(activity) <- c("activityId","activityName")
req_data <- merge(activity,req_data, by = "activityId")
req_data <- select(req_data, -activityId)

#create outcome dataset with name tidy_data
#group data and then calulate mean for every variables based on groups
tidy_data <- group_by(req_data,activityName,subjektId)
tidy_data<- summarise_each(tidy_data,funs(mean)) 
names(tidy_data) <- sapply(names(tidy_data),function(x){if(grepl("^t|f",x)){x<-paste(c("avgof",x),collapse = "_")}else{x}})

#write outcome dataset into file with name "tidy_data.txt"
write_path <- paste(c(destination_path,"tidy_data.txt"), collapse = "/")
write.table(tidy_data,write_path, row.names = FALSE)
