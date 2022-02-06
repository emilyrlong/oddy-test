# oddy-test

## Convolutional Neural Network to Detect Corrosion in Oddy Tests

This GitHub repository contains materials from the above paper. This research was completed as a part of my dissertation in the UCL Data Science for Cultural Heritage MSc programme.

### Image Data
The image data from the American Institute for Conservation (AIC) Oddy Test [Wiki page](https://www.conservation-wiki.com/wiki/Combined_Materials_Testing_Results) is publicly available and downloadable. The image data provided by the Metropolitan Museum of Art (Met) is not currently open access, but may be available from the paper authors on reasonable request.

### 5.1 - Image Label Spreadsheets
A label spreadsheet was sent to heritage experts to label the images. This spreadsheet is a Google Sheet, but can be downloaded as a CSV or XLSX file. There are four empty columns: three for the labels for each of the metal types and one for any additional comments. The AIC Oddy Test wiki table can be searched by the material name in this spreadsheet to identify the images used in the project. 
1. Empty spreadsheet for expert labels: OddyTestsLabelling.csv
2. The expert labels were compiled into one CSV file: ExpertLabels_AICWikiData.csv
3. The above labels were then consolidated in R and further analysed in Excel: ExpertLabels_AICWikiData_Consolidated.xlsx

### 5.2 - Met Labels
1. FullData_Aug12.csv - The bounding box labels for the Met data are in this CSV file
2. group_list_Aug11.csv - This CSV file includes the Met image filenames and their corresponding assignment into the training, validation, or test sets.

### 5.3 - R Code
All of the below code can be downloaded from Google Drive and opened in RStudio or a code editor such as Atom.
1. OddyTest_ExpertLabels.R - This R script file takes in the CSV file of the expert labels, finds the mode coupon labels and identifies ties, and outputs a CSV file.
2. OddyTest_AspectRatios.R - This R file is a short script that calculates the width height ratios of the coupons, plots them, and outputs a summary to help determine the ideal anchor sizes.
3. OddyTest_RandomImgSorting.R - This R file randomly assigns the Met images into training, test, and validation sets.
4. OddyTest_CouponBreakdown.R - This R script file finds the number of coupons in each of the classes for all of the images as well as the training, validation, and test sets.

### 5.4 - Python Notebooks
The following are Python notebooks that will open in Google Colab.
1. Dissertation_0_Image_Loading.ipynb - Loading JPG Images and saving into NumPy Arrays
2. Dissertation_0_4_Converting_Image_Files_to_TF_Records.ipynb - Loading JPG Images and label CSV files and saving into TFRecords
3. Dissertation_0_3_Moving_Image_Files.ipynb - Moving JPG images or npy files into folders for training, validation, and test sets
4. Dissertation_1_6_Training_with_Full_Configs.ipynb - Code to train the model using the model config. The validation code below should run in parallel with this file.
5. Dissertation_1_7_Evaluating_the_Full_Configs.ipynb - Code to validate the model and visualise the results in Tensorboard
6. Dissertation_1_8_Visualising_Box_Labels.ipynb - Code for visualising the images with errors in the validation and test sets. Also finds the contingency tables shown in the results section

### 5.5 - EffDet Model Configs
The model configs from EffDet version 1 and 2 can be downloaded from GitHub and opened in a code editor such as Atom or Google Colab.
1. eff_det_version1_pipeline.config
2. eff_det_version2_pipeline.config

### 5.6 - TensorBoard Plots
The following links will open up a TensorBoard dash- board in your browser. They include loss plots from the training and validation of the model, as well as plots of the mAP from validation.
1. [EffDet Version 1](https://tensorboard.dev/experiment/pK3VIZ5kQayZPEdFbcJXFQ)
2. [EffDet Version 2](https://tensorboard.dev/experiment/bl2gMwOIQd6qUNyRF4YmkA)
