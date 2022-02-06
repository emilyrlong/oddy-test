# Oddy Test: Consolidating Expert Labels

# This R script file takes in the CSV file of the expert labels, finds the mode 
# coupon labels and identifies ties, and outputs a CSV file.

# Load required packages
library(tidyverse)
library(DescTools)

# Loading the data
label_data <- read.csv("ExpertLabels_AICWikiData.csv",header = TRUE)
# Some of the columns had messy values, so using the factor labels to tidy them up a bit 
label_data$ResultsCu <- as.character(factor(label_data$ResultsCu, levels = c("P","PT","P/T","T","T/U","U/T","U","PU","P/U"),
                               labels = c("P","PT","PT","T","TU","TU","U","PU","PU")))
label_data$ResultsAg <- as.character(factor(label_data$ResultsAg, levels = c("P","PT","P/T","T","T/U","U/T","U","PU","U/P"),
                               labels = c("P","PT","PT","T","TU","TU","U","PU","PU")))

# Get list of the images in dataset without repeats - there are 170
image_names <- unique(label_data$Image)
# Get the number of images
m <- length(image_names)

# Creating a new dataframe to hold the mode results
new_df <- data.frame(rep("test_image",m),rep("P",m),rep("P",m),rep(0,m),rep("P",m),rep(0,m),rep("P",m),rep(0,m))
colnames(new_df) <- c("Image","Results","ResultsCu","CuP","ResultsAg","AgP","ResultsPb","PbP")

# Function to find the mode results and add them to the new dataframe
image_mode <- function(i, image_name, new_df){
  # Sub-dataframe for a particular image
  img_data <- label_data[label_data$Image == image_name,]
  # Number of rows in the image dataset
  n <- nrow(img_data)
  # Adding data to new data frame
  new_df$Image[i] <- image_name
  new_df$Results[i] <- unique(img_data$Results)
  # Finding the mode of Copper column
  mode <- Mode(img_data$ResultsCu, na.rm = TRUE)
  # If there's more than one mode, print tie, otherwise add data to dataframe
  if (length(mode) > 1){
    new_df$ResultsCu[i] <- paste("Tie:",mode[1],"+",mode[2])
  } else {
    new_df$ResultsCu[i] <- mode[1]
    new_df$CuP[i] <- attr(mode,"freq")/n
  }
  
  # Finding the mode of Silver column
  modeA <- Mode(img_data$ResultsAg, na.rm = TRUE)
  if (length(modeA) > 1){
    new_df$ResultsAg[i] <- paste("Tie:",modeA[1],"+",modeA[2])
  } else {
    new_df$ResultsAg[i] <- modeA[1]
    new_df$AgP[i] <- attr(modeA,"freq")/n
  }
  
  # Finding the mode of Lead column
  modeP <- Mode(img_data$ResultsPb, na.rm = TRUE)
  if (length(modeP) > 1){
    new_df$ResultsPb[i] <- paste("Tie:",modeP[1],"+",modeP[2])
  } else {
    new_df$ResultsPb[i] <- modeP[1]
    new_df$PbP[i] <- attr(modeP,"freq")/n
  }
  
  return(new_df)
}

# For loop to iterate over the images
for (i in 1:m) {
  new_df <- image_mode(i,image_names[i],new_df)
}

write.csv(new_df,'NonMetConsolidated.csv')
