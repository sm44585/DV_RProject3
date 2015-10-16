# This file creates the third plot of the Data Visualization Project 3
require(tidyr)
require(dplyr)
require(ggplot2)
# Join the fast food and zip code data into new data frame for Plot 1
Plot3_df <- dplyr::inner_join(fast_food, zip_code, by="ZIP") 

# Need to relabel the data in the RESTAURANT column
Plot3_df$RESTAURANT <- factor(Plot3_df$RESTAURANT, levels=c("m", "b", "p", "t","w", "j", "h", "c", "i", "k"), labels = c("McDonalds", "Burger King", "Pizza Hut", "Taco Bell", "Wendys", "Jack In The Box", "Hardees", "Carls Jr.", "In-N-Out", "KFC")) 

# This selects only the zip code, median salary, and restaurant columns
Plot3_df <- Plot3_df %>% select(ZIP, MEDIAN, RESTAURANT, POP)

# Main workhorse function. This is what took 4 hours to figure out
Plot3_df <- Plot3_df %>%group_by(ZIP,POP) %>% summarize(TOTAL_RESTAURANTS = n())%>%ungroup()%>%arrange(POP)

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  #facet_wrap(~R) +
  labs(title="Relationship of zip code population and number of fast food restaurants") +
  labs(x="Population of Zip Code", y="Total number of restaurants per Zip Code") +
  layer(data=Plot3_df , 
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )+
  layer(
    data=Plot3_df,
    mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
    stat="smooth",
    stat_params=list(method="glm", formula=y~poly(x,2)),
    geom="smooth",
    geom_params=list(color="red"),
    position=position_identity()
  )
