Code Book
=================================
This file includes information regarding the data munging of the raw data used in the run_analysis.r script.  It also includes information regarding the variables in the mytidydata.txt file.

# Data in mytidydata.txt
The data in mytidydata.txt is the output of of the run_analysis after taking the following steps:
	* Merging the training and the test sets from the raw data (see details in the Raw Data section below) to create one data set
	* Extracting only the measurements on the mean and standard deviation for each measurement
	* Altering the activity field to be more descriptive
	* Appropriately labeling the data set with descriptive variables
	* Then creating a tidy data set from the prior step with the average of each variable for each activity and participant (i.e. subject)	
	
# The Variables
68 variables were selected from the original dataset.  66 of these variables are measurements of the accelerometers on which mean and standard deviation calcluations were performed.  The last two variables represent the activity performed (walking, walking upstairs, walking downstairs, sitting, standing or laying) and the subject, i.e. and identifier for the participant of the tests, identified as participant 1 through participant 30.

# Data Munging Procedures & Modifications
Numerous munging and modifications were made to the raw data.  The script is outlined with comments.

The first section reads the training and test data from the raw files, assigns column names, adds a column to identify the activity, and adds another column to identify the subject (i.e. the participant).  The data is then combined into one complete set (training and testing data together).

The second section extracts only variables that are based on the mean and standard deviation for each measurement in the raw data.  This are identified by using the grep function and searching for "mean()" and "std()".  It should be noted that we did not search for "mean" and "stdev", without the "()", because there are some features in the raw data that have mean in the feature name, but aren't necessarily based on the mean of another feature.  For instance there are a number of features that include the mean frequency, but for which the feature isn't the calculation of the mean on another feature.

The third section adjusts the activity names to be more descriptive.  Below is a mapping of the changes:

Activity ID | Adjusted Activity Value
------------|------------------------
1 | walking
2 | walking_upstairs
3 | walking_downstairs
4 | sitting
5 | standing
6 | laying

The fourth section labels the dataset with descriptive variables.  Below is a mapping of changes made:

* all feature names were made lowercase to remove any uppercase letters
* t - variables beginning in "t" were adjusted to make more clear that t represents a time measurement
* f - variables beginning in "f" were adjusted to make more clear that f represents a frequency measurement
* acc - variables with "acc" were adjusted to make more clear that acc represents accelerometer
* gyro - variables with "gyro" were adjusted to make more clear that gyro represents gyroscope
* mag - variables with "mag" were adjusted to make more clear that mag represents magnitude
* bodybody - variables that had body repeated consecutively were changed to a single "body" to eliminate the redundancy

The fifth section creates an independant tidy dataset with the average of each variable for each activity by subject (i.e. by participant).  It then writes the tidy dataset as a text file - mytidydata.txt.  In order to facilitate a tidy data set, the participants feature/variable is changed from a single integer value to a more descriptive name.  For instance "1" is changed to "participant 1", and this field is made a factor to facilitate aggregating based on this feature. 

# The Raw Data
The raw data is titled "Human Activity Recognition Using Smartphones Dataset Version 1.0".  The dataset used for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The data linked to above represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  

*"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "*

The information provided in the README.txt, features.txt, features_info.txt and activity_labels.txt files are particularly relevant.

For more information go to: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
