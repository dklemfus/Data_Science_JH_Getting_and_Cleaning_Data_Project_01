# run_analysis.R
# Author: Dan Klemfuss
library(data.table)
library(dplyr)
library(codebook) # Used for optional update to codebook output

#' @title LoadSamsungData
#'
#' @description
#' Function that loads the 'Human Activity Recognition Using Smartphones' Data 
#' Sets, and combines the 'training' and 'test' sets into a single data set. 
#' Extracts only fields related to mean and standard deviation from the data set.  
#'
#' @param dirPath (character) the full path to directory containing dataset
#' @return (data frame) a 'raw' data frame containing the single merged data set 
#'                               or NULL if files do not exist or are invalid
#' @examples
#' LoadAnalysisData('./data')   

LoadSamsungData <- function(dirPath='./data'){
  # Check to ensure that file exists:
  if (dir.exists(dirPath)){
    tryCatch({
      ##
      ## Load in Activity/Feature Definitions, and create logical vector to 
      ## determine if features are mean or standard deviations
      ##
    
      act.labels <- fread(file.path(dirPath,'activity_labels.txt')) # 5 Total
      feat.labels <- fread(file.path(dirPath,'features.txt')) # 561 Total
      feat.mean.std <- grepl('std[(][])]|mean[(][])]',feat.labels$V2) # 66 Total

      ##
      ## Load the training data, add feature labels, and extract only std/mean:
      ##
      
      train.df <- fread(file.path(dirPath,'train/X_train.txt'))
      # Label training data with descriptive variable names:
      names(train.df) <- feat.labels$V2

      # Extract only measurements of mean/standard deviation for each measurement:
      train.df <- train.df[, ..feat.mean.std]
      # Add the Descriptive activity name to the activities in the data set: 
      train.activity.ids <- fread(file.path(dirPath,'train/y_train.txt'))
      train.act.labels <- merge(train.activity.ids, act.labels,
                                     by.x='V1', by.y='V1') %>% 
        select(V2)
      train.df$Activity <- train.act.labels
      # Add train subject data: 
      train.subject <- fread(file.path(dirPath,'train/subject_train.txt'))
      train.df$Subject <- train.subject
      
      ##
      ## Load the test data, add feature labels, and extract only std/mean:
      ##
      
      test.df <- fread(file.path(dirPath,'test/X_test.txt'))
      # Label test data with descriptive variable names:
      names(test.df) <- feat.labels$V2

      # Extract only measurements of mean/standard deviation for each measurement:
      test.df <- test.df[, ..feat.mean.std]
      # Add the Descriptive activity name to the activities in the data set: 
      test.activity.ids <- fread(file.path(dirPath,'test/y_test.txt'))
      test.act.labels <- merge(test.activity.ids, act.labels,
                                     by.x='V1', by.y='V1') %>% 
        select(V2)
      test.df$Activity <- test.act.labels
      # Add train subject data: 
      test.subject <- fread(file.path(dirPath,'test/subject_test.txt'))
      test.df$Subject <- test.subject
      
      ##
      ## Merge the training and test sets to create one data set, and return:
      ##
      merged.df <- rbind(train.df, test.df)
      return(merged.df)
      
    }, error=function(e){
      print(e)
      return(NULL) # Return NULL if error occurs during data loading
    })

  } else {
    print('Error: dirPath does not exist...aborting')
    return(NULL) # Return NULL if unable to locate directory path
  }
}


#' @title TidySamsungData
#'
#' @description
#' Function that uses output from LoadSamsungData() to create a second, 
#' independent tidy data set with average of each variable for each activity and
#' each subject. 
#'
#' @param merged.df (data frame) A data frame output from LoadSamsungData()
#' @return (data frame) A tidy data frame containing activity/subject averages 
#' @aliases            or returns NULL if an exception/error occurs
#'
#' @examples
#' TidySamsungData(merged.df) 

TidySamsungData <- function(merged.df){
  if (!is.null(merged.df) & nrow(merged.df)>0){
    tryCatch({
      # Determine the average of each activity (group) and each subject (column):
      tidy.df <- merged.df %>% group_by(Subject,Activity) %>% 
        summarize_all(list(name=mean))
      
      return(tidy.df)
    }, error = function(e){
      print(e)
      return(NULL) # Return NULL if error occurs during Tidying
    })

  } else {
    print('Error: merged.df has zero rows or is missing...aborting')
    return(NULL) # Return NULL if merged.df has no records
  }
}

################################################################################
#                      MAIN SCRIPT (run_analysis.R)                            #
################################################################################

# Allow user to specify data location if it varies from './data':
dirPath <- './data'

# Load Data from data set, and create a merged data frame: 
merged.df <- LoadSamsungData(dirPath)

# Create Tidy Dataframe showing average for each subject/activity: 
final.df <- TidySamsungData(merged.df)

# Export Data frame to directory:
write.table(final.df, './tidy_samsung_summary.txt',row.name=F)
fwrite(final.df,'./tidy_samsung_summary.csv')


