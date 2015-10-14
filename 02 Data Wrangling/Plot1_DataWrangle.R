# This file creates the first plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)

# Move data into new data frame for Plot 1
Plot1_df <- fast_food  

# Need to relabel the data in the Education column
Plot1_df$RESTAURANT <- factor(Plot1_df$RESTAURANT, levels=c("m", "b", "p", "t","w", "j", "h", "c", "i", "k"), labels = c("McDonald's", "Burger King", "Pizza Hut", "Taco Bell", "Wendy's", "Jack In The Box", "Hardee's", "Carl's Jr.", "In-N-Out", "KFC")) 
