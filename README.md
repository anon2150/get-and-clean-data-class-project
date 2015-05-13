Course Project - ReadMe File
=============================

This file explains how the run_analysis.R script in this repo works and how it is connected to other items in the repo.

# Repo Contents
* run_analysis.r - this file is the driving force behind the data analysis and created the mytidydata.txt file
* CodeBook.md - this file describes the variables in the mytidydata.txt file, along with the data munging that occurred to the data from its raw form
* mytidydata.txt - this file is the output of of the run_analysis after taking the following steps:
	* Merging the training and the test sets from the raw data to create one data set
	* Extracting only the measurements on the mean and standard deviation for each measurement
	* Altering activity field to be more descriptive
	* Appropriately labeling the data set with descriptive variables
	* Then creating a tidy data set from the prior step with the average of each variable for each activity and participant (i.e. subject)
	
# run_analyis.r
The run_analysis.r script loads raw data (detailed below in the raw data section), cleans the data and creates a tidy data set.

# Raw Data
The raw data is titled "Human Activity Recognition Using Smartphones Dataset Version 1.0".  The dataset used for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The data linked to above represent data collected from the accelerometers from the Samsung Galaxy S smartphone.