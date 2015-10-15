# This file creates the first plot of the Data Visualization Project 3
require(tidyr)
require(dplyr)
require(ggplot2)
# Join the fast food and zip code data into new data frame for Plot 1
Plot1_df <- dplyr::left_join(fast_food, zip_code, by="ZIP") 

# Need to relabel the data in the RESTAURANT column
Plot1_df$RESTAURANT <- factor(Plot1_df$RESTAURANT, levels=c("m", "b", "p", "t","w", "j", "h", "c", "i", "k"), labels = c("McDonalds", "Burger King", "Pizza Hut", "Taco Bell", "Wendys", "Jack In The Box", "Hardees", "Carls Jr.", "In-N-Out", "KFC")) 

# This selects only the zip code, median salary, and restaurant columns
Plot1_df <- Plot1_df %>% select(ZIP, MEDIAN, RESTAURANT, POP)

# This shows data for zip codes that have median salaries that are either in the top or bottom ten percent 
Plot1_df <- Plot1_df  %>% mutate(POP_PERCENT = cume_dist(Plot1_df$POP)) %>% filter(POP_PERCENT <= .1 | POP_PERCENT >= .9)

# Main workhorse function. This is what took 4 hours to figure out
Plot1_df <- Plot1_df %>% group_by(ZIP) %>% summarize(POP = first(POP), TOTAL_RESTAURANTS = n())


ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  #facet_wrap(~R) +
  labs(title="Top & Bottom 10 percent of Zip codes by population") +
  labs(x="Population", y="Number of Restaurants", color="Fast Food restaurant") +
  layer(data=Plot1_df , 
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
