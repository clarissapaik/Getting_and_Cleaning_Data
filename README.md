# Getting_and_Cleaning_Data: 

### Purpose and Overview

This assignment calls for merging, summarizing, and cleaning data utilizing tidy data principles. The original data, which tracks the 3-axial linear acceleration and 3-axial angular velocity of 30 subjects in the performance of six activities, should be credited to Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto of the Non Linear Complex Systems Laboratory at the University of Genova, Italy. A more detailed description of the data, as well as access to files used for this analysis, can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .

### Methodology

To replicate the results of the included script, the following packages should be installed and loaded:

- utils
- dplyr
- stringr
- tidyr
- reshape2

Datasets 'X_train.txt' and 'X_test.txt' were merged to to subject and activity data provided in their respective folders. They were then appended without regard to whether observations were used to train or test algorithms (as this was not relevant to the purpose of this exercise). Variables that measure means and standard deviation (from 'features.txt') were extracted for the purpose of selecting out desired variables from the compiled dataset and naming variables. At this point, the dataset was reshaped long, resulting in a 679,734 by 4 matrix. This was grouped by activity, subject, and measurement, and value was collapsed by mean--resulting in the final 11,880 by 4 matrix included.
