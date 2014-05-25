Instructions for run_analysis.R script
================================================================

**The run_analysis.R script turns raw accelerometer and gyroscope data and generates a clean dataset representing the average value for each of the mean and standard deviation measurements, for each of the activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) over all of the observations.**

## Running the script: 
Make sure the script is in your current directory along with the "UCI HAR Dataset" folder containing the raw data.

## Input: 
The script reads in the following inputs located within the "UCI HAR Dataset" folder:

* ./test/X_test.txt
* ./test/Y_test.txt
* ./train/X_train.txt
* ./train/Y_train.txt
* ./features.txt
* ./activity_labels.txt

## Output: 
The script generates a clean dataset in the current directory called "motion_data.txt"