# Data-Cleaning
---
Joe Stoffa
Coursera's Johns Hopkins Getting and Cleaning Data Course
10 July 2016
---

##Description
This repository is for Coursera's Johns Hopkins Getting and Cleaning Data course final project.  The purpose of the project was to take data from the UCI Machine Learning Repository, tidy it, and perform a basic preliminary analysis.  The tidy data frame and a data frame outputted from the analysis (mean value for each attribute in the tidy data set) have been outputted as CSV files.

##Files
###run_analysis.r
This R file downloads the zipped folder of data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", unzips the folder, and loads the initial files.  The script then combines and cleans the disparate data files into a single tidy data set that includes only the variables related to the mean and standard deviations of triaxial data.  The script calculates the mean of the standard deviations and means and outputs as a new dataframe.  Lastly, the script outputs CSV files of the tidy dataset (tidy_data.csv) and means (mean_data.csv).

###Code_book.md
This markdown file provides a description of the variables from the tidy data set.

###tidy_data.csv
This file is outputted by run_analysis.r and includes a tidy data set of variables relating to the mean and standard deviations from the triaxial data.

###mean_data.csv
This file contains 

