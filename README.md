## Introduction

This Project was developed as part of the 'Getting and Cleaning Data' Course,
a requirement for the Data Science Specialization Certification offered by 
Johns Hopkins / Coursera. 

## 1. Project Description:

The purpose of this project is to demonstrate your ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later
analysis. You will be graded by your peers on a series of yes/no questions related
to the project. You will be required to submit: 1) a tidy data set as described 
below, 2) a link to a Github repository with your script for performing the 
analysis, and 3) a code book that describes the variables, the data, and any 
transformations or work that you performed to clean up the data called CodeBook.md.
You should also include a README.md in the repo with your scripts. This repo 
explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable 
computing - see for example this article . Companies like Fitbit, Nike, and 
Jawbone Up are racing to develop the most advanced algorithms to attract new users.
The data linked to from the course website represent data collected from the 
accelerometers from the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each 
measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with 
the average of each variable for each activity and each subject.

## 2. Project Overview: 

### MAIN SCRIPT (run_analysis.R):

The run_analysis.R script consists of two functions that read in the samsung 
example data, process the data, and produce a tidy set of data. The output 
dataframe finds the average of each subject, shown by group (activity). For users
looking to inspect/use the 'untidy' data, it can be accessed via the merged.df
object written to the global environment. A summary of the functions follow: 

#### LoadSamsungData(dirPath): 
Function that loads the 'Human Activity Recognition
Using Smartphones' Data Sets, and combines the 'training' and 'test' sets into a 
single data set. Extracts only fields related to mean and standard deviation from 
the data set.

parameters: dirPath (character) the full path to directory containing dataset

return: (data frame) a 'raw' data frame containing the single merged data set 
                               or NULL if files do not exist or are invalid
Example: 
LoadAnalysisData('./data') 

#### TidySamsungData(merged.df): 
Function that uses output from LoadSamsungData() 
to create a second, independent tidy data set with average of each variable for 
each activity and each subject. 

parameters: merged.df (data frame) A data frame output from LoadSamsungData()

return: (data frame) A tidy data frame containing activity/subject averages 
                     or returns NULL if an exception/error occurs
Example:
TidySamsungData(merged.df)


### DATA (./data):

The 'data' folder contained in this project is an uncompressed version of the 
provided data. See links in Project Description for further details. 


### CODEBOOK:

This project contains a CodeBook_Generator.rmd and CodeBook.md file, which 
generate the 'CodeBook_Generator.html' document. These markdown documents make 
use of R-markdown to create an interactive summary that indicates all the 
variables and summaries calculated, along with other relevant information. 


### OUTPUTS:

This project contains several outputs: 

#### tidy_samsung_summary.csv: 
A CSV export of the final dataframe produced by the
TidySamsungData() function. Automatically written by script to current directory. 

#### tidy_samsung_summary.txt: 
A text export of the final dataframe produce by the 
TidySamsungData() function. Automatically written by script to current directory. 

#### CodeBook_Generator.html: 
An HTML codebook output produced by CodeBook_Generator.rmd/CodeBook.md.

