# Finding the best aspect ratios for the model

library(tidyverse)

labels <- read.csv("Fulldata_Aug2.csv",header = TRUE)
# xdiff and ydiff are actually equal to the width and height of the coupons
labels$WHratio <- labels$xdiff/labels$ydiff
plot(labels$WHratio)
summary(labels$WHratio)
