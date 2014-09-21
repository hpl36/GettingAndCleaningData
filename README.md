GettingAndCleaningData
======================

Course project for the week 3 of the Getting and Cleaning Data coursera training

This repository contains a run_analysis.R script that is generating tidyData from the getdata-projectfiles-UCI HAR Dataset.zip file.

The assumption is that this zip file has been unzipped in the working directory where this script is run, into the default directory named UCI HAR Dataset.

All variables names are extracted from the features.txt file.
All variables values are extratced from the \train\X_train.txt and \test\X_test.txt files.

All subjects are extracted from the \train\subject_train.txt and \test\subject_test.txt.

All activities are extracted from the \train\y_train.txt and \test\y_test.txt

I grep on column names to keep only the ones containing 'std' and 'mean'.

And finally, I group per Subject and per Activity the mean of the remaining values.
