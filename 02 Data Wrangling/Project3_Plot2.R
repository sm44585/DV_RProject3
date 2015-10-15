# This file creates the first plot of the Data Visualization Project 3
require(tidyr)
require(dplyr)
require(ggplot2)
# Join the fast food and zip code data into new data frame for Plot 1
Plot2_df <- dplyr::left_join(fast_food, zip_code, by="ZIP") 

# Need to relabel the data in the RESTAURANT column
Plot2_df$RESTAURANT <- factor(Plot2_df$RESTAURANT, levels=c("m", "b", "p", "t","w", "j", "h", "c", "i", "k"), labels = c("McDonalds", "Burger King", "Pizza Hut", "Taco Bell", "Wendys", "Jack In The Box", "Hardees", "Carls Jr.", "In-N-Out", "KFC")) 

# This selects only the zip code, median salary, and restaurant columns
Plot2_df <- Plot2_df %>% select(ZIP, MEDIAN, RESTAURANT, POP)

# This shows data for zip codes that have median salaries that are either in the top or bottom ten percent 
Plot2_df <- Plot2_df  %>% mutate(MEDIAN_SAL_PERCENT = cume_dist(Plot2_df$MEDIAN)) %>% filter(MEDIAN_SAL_PERCENT  <= .1 | MEDIAN_SAL_PERCENT  >= .9)

# Main workhorse function. This is what took 4 hours to figure out
Plot2_df <- Plot2_df %>%group_by(ZIP,POP) %>% summarize(TOTAL_RESTAURANTS = n())%>%ungroup()%>%arrange(POP)

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  #facet_wrap(~R) +
  labs(title="The relationship between the population and the total number of fast food restaurants") +
  labs(x="Population", y="Number of Restaurants", color="Fast Food restaurant") +
  layer(data=Plot2_df , 
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
