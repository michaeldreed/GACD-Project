#### A script to transform the raw accelerometer and gyroscope data into a clean dataset ####

## Load data
test<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, colClasses="numeric")
train<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, colClasses="numeric")

## Load activity data
test_act<-read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)
train_act<-read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE)

## Combine the test and train data to form one dataset
data<-rbind(test,train)
data_act<-rbind(test_act,train_act)

## Extract mean and standard deviations for each measurement ####
cols<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,
        253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)
data<-data[,cols]

## Add activity label to the data
data<-cbind(data_act,data)

## Read in the activity and measurement names 
features<-read.table("UCI HAR Dataset/features.txt")
activities<-read.table("UCI HAR Dataset/activity_labels.txt")

## Subset the measurement names and label the columns
features<-features[cols,]
feature_labels<-c()
for (i in 1:nrow(features)){
    feature_labels[i]<-as.character(features[,2][i])
}
feature_labels<-c("Activity",feature_labels)
names(data)<-feature_labels

## Name the activities in the Activity Column
for (i in 1:nrow(data)){
    data[,1][i]<-as.character(activities[,2][as.numeric(data[,1][i])])
}

## Calculate average of each variable for each activity and each subject
## Split data by activity
data_split<-split(data,data$Activity)
final_data<-data.frame()
for (i in 1:length(data_split)){
    tmp<-data_split[[i]]
    ## Remove the activity column
    tmp<-tmp[2:67]
    ## Make sure all the values are numeric
    for (i in 1:66){
        tmp[,i]<-as.numeric(tmp[,i])
    }
    ## Calculate mean for each variable
    row<-sapply(tmp,mean, rm.na=TRUE)
    ## Combine into dataset
    final_data<-rbind(final_data,row)
}

## Label the final data set
names(final_data)<-features[,2]
row.names(final_data)<-activities[,2]

## Export the final data set to a txt file
write.table(final_data, "motion_data.txt", sep="\t")
