# General Description

The R script `run_analysis.R` is a part of grad in Getting and Cleaning Data Course
of Johns Hopkins University and Coursera. 

### About `run_analysis.R` script:

* At the first moment, this script makes a download of the data zipped file from the url.
* Unzip the file and loads the data files necessary for the analysis.
* After that, the code implements a concatenation of the data in a new and unique file 
containing all information.
* The column names are restructured in the new file, considering the features.txt.
* The means and standard deviations are extracting from this new file and they 
are assigned in a output object.
* After that, the code implements a standardization in the column names of the output
object.
* After all, the code creates a new dataset with all average measures for each subject and 
each actitivity type.

### About files and objects cited in R script:

* act, act.train, act.test, subj.train, subj.test, feat.train, feat.test and features containing
all data downloaded from the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
* train, test, data, labs, mean.std and out are objects that was used to manipulate the original data.
* train, test and data objects was used to merge the original data downloaded from the url cited above.
* labs object receive the labeling names for the data file output.
* Finally, the out.avg object contain the tidy data with the average which will be stored in a text file
called activity_subject_avg.txt.


