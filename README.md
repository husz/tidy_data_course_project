---
title: "README for run_analysis.R"
author: "husz"
date: "Friday, April 24, 2015"
output: html_document
---


This README file is part of course project of Getting and cleaning data course on coursera.com
Goal of this project is getting and transform data for further analysis.
Project includes follwing files: 
    run_analysis.R - script provides required data analysis and data transformation
    README.md -  provides necessary information how run_analysis.R works
    CodeBook.md - provides information how data was changed/transformed by run_analysis script

requirements for analysis: 
    installed dplyr and lubridate packages on your machine.
    script was developed on windows OS, but I believe (hope), it will work on other platforms as well.

Purpose of analysis:
    To prepare tidy data according project requirements that can be used for later analysis.
    Source data are here <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 
    
Output: output of this analysis is file tidy_data.txt which contains required dataset and will be stored on your computer   

How to run analysis:
step1: please put script run_analysis.R into your working directory
step2: source the script in Rstudio and enjoy :)

so how does script run_analysis.R work:

Phase 1: Download data

I know it wasn't required, but I think it is nice for reproducibility and you don't have to care wether you have a data or not. Script creates directory "COURSE_PROJECTyyyymmddhhmmss" in your working directory in this phase, 
downloads zipped data and unzzips them into created directory.
yyyymmddhhmmss is timestamp when directory was created and analysis was run. So it means, that everytime you run script new directory will be created and fresh data will be downloaded. (Of course I could chceck wether data is already downloaded, but this approach assures that analysis will be provided always on fresh data. (as data could change in time.))

Phase 2: Transformation of data and creating new required dataset 

Detailed information how is original data transformed via script is available in CodeBook.md file.
Please read this file.
Result of analysis is new dataset with tidy data

Phase 3: write results into tidy_data.txt file

Dataset with results is stored in the file with name tidy_data.txt.
File is stored in directory from phase 1 (COURSE_PROJECTyyyymmddhhmmss)

so after analysis you should see following in your working directory:

1. new directory called COURSE_PROJECTyyyymmddhhmmss (where yyyymmddhhmmss is timestamp when you run script)
2. in this new directory should be zip file with original data as well as unzipped  original data
3. file tidy_data.txt with results dataset

If you want to see tidy_data dataset in R, please read it into R with 
```{r}
data <- read.table(file_path, header = TRUE)
View(data)
```

Note: I apologize for typos and grammar mistakes. English is not my native language.


