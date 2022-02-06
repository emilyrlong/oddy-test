# A Script to Randomly Sort the Images into Training, Validation, and Test Groups

library(tidyverse)

# - - - Adjusting CSV labels for the TF Record Format - - - 

labels <- read.csv("Fulldata_Aug2.csv",header = TRUE)
labels$xmax <- labels$xmin + labels$xdiff
labels$ymax <- labels$ymin + labels$ydiff
# Rearranging columns
labels2 <- labels[, c(6,7,8,1,2,3,9,10)]
write.csv(labels2,"Fulldata_Aug10_TFRecord.csv")

# Resizing labels so they fit the scale of the resized images
resized_labels <- labels2
# New width: 960
resized_labels$xmin <- round((resized_labels$xmin/resized_labels$width)*960)
resized_labels$xmax <- round((resized_labels$xmax/resized_labels$width)*960)
# New height: 640
resized_labels$ymin <- round((resized_labels$ymin/resized_labels$height)*640)
resized_labels$ymax <- round((resized_labels$ymax/resized_labels$height)*640)
# Replacing height and width values
n <- nrow(resized_labels)
resized_labels$height <- rep(640,n)
resized_labels$width <- rep(960,n)
write.csv(resized_labels,"Fulldata_Aug11_Resized.csv")

# - - - SEPARATING IMAGES INTO SETS - - - 

filenames <- as.data.frame(unique(resized_labels$filename))
colnames(filenames) <- c("filename")

# train: 1540 val: 448 test: 220
group_vec4 <- c(rep('train',1540),rep('val',448),rep('test',220))
set.seed(2)
filenames$group <- sample(group_vec4)

val_names <- data.frame(filenames[filenames$group == 'val',1])
colnames(val_names) <- c('filename')
write.csv(val_names,"val_names_Aug11.csv")

train_names <- data.frame(filenames[filenames$group == 'train',1])
colnames(train_names) <- c('filename')
write.csv(train_names,"train_names_Aug11.csv")

test_names <- data.frame(filenames[filenames$group == 'test',1])
colnames(test_names) <- c('filename')
write.csv(test_names,"test_names_Aug11.csv")

# Getting spreadsheets with all labels for each of the groups
val_full <- left_join(val_names, resized_labels)
write.csv(val_full, "val_labels.csv")

test_full <- left_join(test_names, resized_labels)
write.csv(test_full, "test_labels.csv")

train_full <- left_join(train_names, resized_labels)
write.csv(train_full, "train_labels.csv")
