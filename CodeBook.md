
Coursera - Getting and Cleaning Data - Assignment Codebook
=============================

This is the codebook describing the data, along with the process to get to it, for the Assignement of the "Getting and Cleaning Data" course on Coursera.


The Course Assignment
======================
The assignment asks to start from data collected from accelerometers of Samsung Galaxy S Smartphone during tests run by Smartlab. The request is to download the raw data from the web site where it's published, process it according to the provided instructions and publish a new tidy dataset.
For clarity, these are the instructions provided for the assignment


> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
>
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
>
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
>
> Here are the data for the project: 
>
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
>
> You should create one R script called run_analysis.R that does the following. 
> * Merges the training and the test sets to create one data set.
> * Extracts only the measurements on the mean and standard deviation for each measurement. 
> * Uses descriptive activity names to name the activities in the data set
> * Appropriately labels the data set with descriptive variable names. 
> * Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


In the following sections you can find the descriptions of the raw input data, the output data created and the cleansing process used to build it


The raw data
============
As described in the assignment, the data can be downloaded from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and a full description can be found at this link http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
What follows here is a mix of extract from that documentation and personal notes to add a little more clarity on how the data is structured and how the files relate to each other.

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
>
> For each record it is provided:
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.
>
> The dataset includes the following files:
> - 'README.txt'
> - 'features_info.txt': Shows information about the variables used on the feature vector.
> - 'features.txt': List of all features.
> - 'activity_labels.txt': Links the class labels with their activity name.
> - 'train/X_train.txt': Training set.
> - 'train/y_train.txt': Training labels.
> - 'test/X_test.txt': Test set.
> - 'test/y_test.txt': Test labels.
>
> The following files are available for the train and test data. Their descriptions are equivalent. 
> - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its > range is from 1 to 30. 
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
> 
> Notes: 
> - Features are normalized and bounded within [-1,1].
> - Each feature vector is a row on the text file.
> 
> For more information about this dataset contact: activityrecognition@smartlab.ws
> 
> License:
> Use of this dataset in publications must be acknowledged by referencing the following publication: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on > Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
> 
> This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
> 
> Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Of all the files provided in the zip file, we are interested in the following ones, which have been copied in the "indata" folder of this project:

| File        | Description |
|------------ |-------------| 
| activity_labels.txt | This file simply lists the six activities for the experiment. For each activity ID and description are provided (1 WALKING, 2 WALKING_UPSTAIRS, ..., 6 LAYING)|
| features.txt | This file lists the 561 features included in the data, providing for each of them their feature number and description. The list is in the same order in which the information appears in the dataset (feature #1 is the first column in the dataset, #2 the second, etc.)|
| X_train.txt<br>X_test.txt | These two files contain (for the training and test sets, respectively) one row for each recording. Each row includes the 561 values of each of the features listed in the features.txt file above. |
| subject_train.txt<br>subject_test.txt | These two files contain (for the training and test sets, respectively) one row for each recording. Each row has one value only, which is the ID of the subject (one of the 30 people partecipating to the experiment) that the recording belongs to. |
| y_train.txt<br>y_test.txt | These two files contain (for the training and test sets, respectively) one row for each recording. Each row has one value only, which is the ID of the activity that has been recorded, as specified in the activity_labels.txt file (e.g. a value of 1 means that the recording is made while the subject was WALKING)|
| features_info.txt | This file is a descriptive one, which specifies a little better what type of data is included, how it was recorded and processed. What is interesting for the sake of the assignement is the specification of how the 561 feature names have been built. One of the most important things to notice for us is the part of the feature name which specifies the type of measure, whether it's a mean, a standard deviation, a maximum value, etc. All mean and standard deviations, which we are requested to select in the assignment can be recognised because they have "mean()" or "std()" as part of their feature name  |

One thing worth mentioning is that the files are all text files, with columns separated by space and they don't have column headers.

In order to match all the information for the same recording you can rely on the row number which is the same in the three files "X_train.txt", "subject_train.txt" and "y_train.txt" (same thing applies to the test files). Given one row number you can select the rows with that row number in the three files and
* from X_train.txt you can get the 561 measure values 
* you can use features.txt to know which measure is in each column of X_train.txt
* from subject_train.txt you can know which of the 30 people the measurement comes from
* from y_train.txt you can know what type of activity was performed while recording. In the y_train.txt file you find the activity ID, which you need to decode using the activity_labels.txt file

(As already said, the same applies also to the *_test.txt files)


The cleansing process
=====================

As specified in the assignment the steps required are the following (I've added a preliminary step 0 which consists in reading the files)

0. Read the data from the raw files into R
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Step 0. Read the data from the raw files into R
Here in this step, the input text files are read into R data frames. In all the files the columns are separated by a blank character and no header line is available, so the data is read according to this.
The following data frames are created, each corresponding to one of the input files:
* activity_labels - 2 columns (activity.ID and activity.name) and 6 rows
* features - 2 columns (feature.ID and feature.name) and 561 rows (one for each feature)
* x_test - 561 columns (named from V1 to V561) where each column corresponds to one feature, 2947 rows (one for each recording in the test set)
* x_train - 561 columns (named from V1 to V561) where each column corresponds to one feature, 7352 rows (one for each recording in the training set)
* subject_test - 1 column (subject.ID), 2947 rows (one for each recording in the test set)
* subject_train - 1 column (subject.ID), 7352 rows (one for each recording in the training set)
* y_test - 1 column (activity.ID), 2947 rows (one for each recording in the test set)
* y_train - 1 column (activity.ID), 7352 rows (one for each recording in the training set)

### Step 1. Merges the training and the test sets to create one data set.



### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 



### Step 3. Uses descriptive activity names to name the activities in the data set



### Step 4. Appropriately labels the data set with descriptive variable names. 



### Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 




The output data
===============



