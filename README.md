


## Conception of the tidy dataset_1

This exercice help us to use our new skills, to clean a dataset by using R programming.


### Step 1

If the data zip file doesn't exist, run_analysis() download and unzip it on the computeur.


### Step 2

The function run_analysis() read and take from the texts files, the X variables, the Y variables, the names's variables and the subject's ID, of each sample of participant ( test and train ). A new column 'sample' is create for differenciate the two samples.


### Step 3

At the moment where the test and train datasets are clean, we merge its in one.


### Step 4

Within the merged dataset, we search and take the column which have the words 'means' or 'std'. We get 'sample', 'subject' and 'activity' column too, in the purpose to create our first principale and tidy dataset. During this procedure, the variables' names are cleanning. The class of subjects and the activity variable are upgrade too.


### Step 5

The tidy dataset is cached into dataset_1



##  Conception of the tidy dataset_2


### Step 1

We begin by create a empty list called 'new_data'. Afterwards, we take each subject ID. For each subject ID, we subset data from dataset_1. With the subset object, we calculate the mean of each column and by each activity. Each compute is store in 'new_data' list.


### Step 2

Our list is cached into dataset_2
