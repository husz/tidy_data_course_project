---
title: "CodeBook"
author: "husz"
date: "Saturday, April 25, 2015"
output: html_document
---

This code book file describes transormation of data for course project Getting and celaning data.

Original datasets: original datasets are available in 
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
in this analysis we work with following files:

- subject_test.txt, X_test.txt, y_test.txt from test directory (test part of data)

- subject_train.txt, X_train.txt, y_train.txt from train directory (train part of data)

- activity_labels.txt, features.txt

Data in original datasets comes from experiment where data (signals) from smartphone for particular activities of subjects was collected.
For understanding of original datasets and purpose of experiment please read README.txt.
Variables of original datasets are described in file features_info.txt, please read it for better understanding.

Outcome of transformation is tidy dataset, which contains avg values of certain subset of original datasets variables for certain activity and subject. Each row contains avg values of original variables for certain combination of activity and subjectId.

Transformation has following parts:

Phase 1: create one common original dataset from test and train datasets.

Data from subject_test.txt, y_test.txt X_test.txt was put together via columns (cbind), 
where data from subject_test creates column of subjects, data from y_test is activity column
and data from X_data is is data collected from smartphone.
Data from subject_train.txt, y_train.txt X_train.txt was put together by same way as test data.
test and train dataset were put together via rows (rbind)
dimension of this dataset is 10299x563, where variables 3-563 correspond to variables from features.txt file in original data.

Phase 2: determine set of variables for new dataset

Only variables which are mean() or std() values are supossed to be in new dataset.
In file features.txt are names of all variables from original dataset. For new dataset only variables which 
contains mean(), std(),meanFreq() strings will be part of  new dataset. (according description in features_info.txt, I believe that only these variables represent mean or std values.)
dataset from phase 1 was subsetting accordingly. 

Phase 3: replace Activit numbers with activity names

for this phase I create help dataset from activity_labels.txt and merge it with dataset from phase 2 (via merge).
Then column with activity number was wxcluded from dataset.

phase 4: names of variables in dataset from phase 3

first column contains activity and its name is "activityName"
second column contains ID of subject and its name is "subjectId"
Rest columns are variables with mean or std values of signal info, their names are almost same as in original dataset.

For example if original variable is "tBodyAcc-mean()-Y" new name will be "tBodyAcc_mean_Y"
I just remove "()" and replace "-" with "_".
so "tBodyAccJerk-std()-Y" will change to "tBodyAccJerk_std_Y".
values are still same as in original dataset. Final transformation comes in next phase.

phase 5: create new tidy dataset

crete new dataset  with name tidy_dataset.
this dataset should contains avg values of each variable in dataset from phase 4 per activity and subject.
First dataset from phase 4 is grouped by ActivityName and SubjectId (group_by)
and then mean of every variables in every group is calculated (summarise_each)
At the end I add "avgof_" to variable names (except of ActivityName and subjectId variables) to emphasize that it is avg value of original variables.
New dataset has dimension 180x81.

phase 6. write tidy dataset into file

In this phase outcome dataset is written in file which is stored on your machine.

Note: I apologize for typos and grammar mistakes. English is not my native language.







