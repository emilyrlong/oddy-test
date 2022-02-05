# oddy-test
Convolutional Neural Network to Detect Corrosion in Oddy Tests

The image data from the AIC Oddy Test wiki table [26] is publicly available and downloadable. For more information on how to download the images used in the project, see Section 5.1. The image data provided by the Met is not currently open access, but may be available from the authors on reasonable request.

5.1 Labelling Spreadsheet
This label spreadsheet was sent to the experts to label the images. This spreadsheet is a Google Sheet, but can be downloaded as a CSV or XLSX file. There are four empty columns: three for the labels for each of the metal types and one for any additional comments. The AIC Oddy Test wiki table [26] can be searched by the material name in this spreadsheet to identify the images used in the project. The expert labels are contained in two spreadsheets:
1 The expert labels were compiled into one CSV file which can be accessed via Google Sheets: Expert- Labels AICWikiData.csv.
2 The above labels were consolidated in R (Ap- pendix 5.3.1) then analysed in Excel: ExpertLa- bels AICWikiData Consolidated.xlsx

5.2 Met Labels
• The bounding box labels for the Met data are in this CSV file on Google Drive.
• This CSV file includes the Met image filenames and their corresponding assignment into the train- ing, validation, or test sets.

5.3 R Code
All of the below code can be downloaded from Google Drive and opened in RStudio or a code editor such as Atom.
5.3.1 Consolidating Expert Labels
This R script file takes in the CSV file of the expert labels, finds the mode coupon labels and identifies ties, and outputs a CSV file.
5.3.2 Calculating Anchor Sizes
This R file is a short script that calculates the width height ratios of the coupons, plots them, and outputs a summary to help determine the ideal anchor sizes.
5.3.3 Randomly Assigning Image Sets
This R file randomly assigns the Met images into train- ing, test, and validation sets.
5.3.4 Statistics on Met Labels
This R script file finds the number of coupons in each of the classes for all of the images as well as the train- ing, validation, and test sets.

5.4 Python Notebooks
The following are Python notebooks that will open in Google Colab.
1 Loading JPG Images and saving into NumPy Ar- rays: Colab
2 Loading JPG Images and label CSV files and sav- ing into TFRecords: Colab
3 Moving JPG images or npy files into folders for training, validation, and test sets: Colab
4 Code to train the model using the model config. The validation code below should run in parallel with this file: Colab
5 Code to validate the model and visualise the re- sults in Tensorboard: Colab
6 Code for visualising the images with errors in the validation and test sets. Also finds the contin- gency tables shown in the results section: Colab

5.5 EffDet Model Configs
The model configs from EffDet version 1 and 2 can be downloaded from this Google Drive folder. The config files will need to be opened in a code editor such as Atom or Google Colab.

5.6 TensorBoard Plots
The following links will open up a TensorBoard dash- board in your browser. They include loss plots from the training and validation of the model, as well as plots of the mAP from validation.
• E↵Det Version 1: https://tensorboard.dev/ experiment/pK3VIZ5kQayZPEdFbcJXFQ
• E↵Det Version 2: https://tensorboard.dev/ experiment/bl2gMwOIQd6qUNyRF4YmkA
