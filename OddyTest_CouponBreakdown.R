# Dissertation: Finding the Breakdown of Corrosion Types by Coupon in the Different Sets

library(tidyverse)

# Loading in all labels
labels <- read.csv("Fulldata_Aug12.csv",header = TRUE)

# Grouping by filename and getting counts of the classes
label_counts <- as.data.frame(labels %>% group_by(filename, class) %>% summarise(class_count = n()))

# Loading the lists with the training/validation/test sets
train <- read.csv("train_names_Aug11.csv",header = TRUE)
val <- read.csv("val_names_Aug11.csv",header = TRUE)
test <- read.csv("test_names_Aug11.csv",header = TRUE)

# Adding columns for the group names
train$group <- rep('train',nrow(train))
train <- train[,-1]
test$group <- rep('test',nrow(test))
test <- test[,-1]
val$group <- rep('validation',nrow(val))
val <- val[,-1]

# Merging the datasets with files and groups
files <- rbind(train,val)
files <- rbind(files,test)

# Writing the filenames into one csv just for future reference
write.csv(files,'group_list_Aug11.csv')

# Left joining the label counts and the group names from files dataframe
all_data <- left_join(label_counts,files)

# Getting the breakdown of corrosion types by group
cor1 <- as.data.frame(all_data %>% group_by(group,class) %>% summarise(class_count = sum(class_count)))
write.csv(cor1,'cor_types_by_group.csv')

# Getting average number of coupons per image
coup_num <- as.data.frame(label_counts %>% group_by(filename) %>% summarise(coup_count = sum(class_count)))
avg_cp <- mean(coup_num$coup_count)

# - - - Loading in Non-Duplicate Data and Writing New Label Lists - - - 

# There are a few images with duplicate labels in each of the sets
coup_num <- left_join(coup_num, files)

# Reading in the non-duplicate data
labels_nodup <- read.csv("Fulldata_Aug12.csv",header = TRUE)
labels_nodup <- left_join(labels_nodup,files)

train_labels <- labels_nodup[labels_nodup$group=='train',]
train_labels <- train_labels[,-9]
write.csv(train_labels,'train_labels_Aug12.csv')

val_labels <- labels_nodup[labels_nodup$group=='validation',-9]
write.csv(val_labels,'val_labels_Aug12.csv')

test_labels <- labels_nodup[labels_nodup$group=='test',-9]
write.csv(test_labels,'test_labels_Aug12.csv')
