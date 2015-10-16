# This file creates the second plot of the Data Visualization Project 3
require(tidyr)
require(dplyr)
require(ggplot2)
# Join the fast food and zip code data into new data frame for Plot 1
Plot2_df <- dplyr::semi_join(zip_code, fast_food, by="ZIP")
Plot2_df <- dplyr::inner_join(Plot2_df, fast_food, by="ZIP")

# Need to relabel the data in the RESTAURANT column
Plot2_df$RESTAURANT <- factor(Plot2_df$RESTAURANT, levels=c("m", "b", "p", "t","w", "j", "h", "c", "i", "k"), labels = c("McDonalds", "Burger King", "Pizza Hut", "Taco Bell", "Wendys", "Jack In The Box", "Hardees", "Carls Jr.", "In-N-Out", "KFC")) 

# This selects only the zip code, median salary, and restaurant columns
Plot2_df <- Plot2_df %>% select(ZIP, MEDIAN, RESTAURANT, POP)

# This shows data for zip codes that have median salaries that are either in the top or bottom ten percent 

Plot2_df_both <- Plot2_df  %>% mutate(POP_PERCENT = cume_dist(Plot2_df$POP)) %>% filter(POP_PERCENT <= .1 | POP_PERCENT >= .9)

Plot2_df_bot10 <- Plot2_df  %>% mutate(POP_PERCENT = cume_dist(Plot2_df$POP)) %>% filter(POP_PERCENT <= .1)

Plot2_df_top10 <- Plot2_df  %>% mutate(POP_PERCENT = cume_dist(Plot2_df$POP)) %>% filter(POP_PERCENT >= .9)

# Main workhorse function. This is what took 4 hours to figure out
Plot2_df_both <- Plot2_df_both %>% group_by(ZIP) %>% summarize(POP = first(POP), TOTAL_RESTAURANTS = n())

Plot2_df_bot10 <- Plot2_df_bot10 %>% group_by(ZIP) %>% summarize(POP = first(POP), TOTAL_RESTAURANTS = n())

Plot2_df_top10 <- Plot2_df_top10 %>% group_by(ZIP) %>% summarize(POP = first(POP), TOTAL_RESTAURANTS = n())

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title="Top & Bottom 10 percent of Zip Codes by Population") +
  labs(x="Population of Zip Code", y="Total Number of Restaurants") +
  layer(data=Plot2_df_both , 
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  ) +
  layer(data=Plot2_df_bot10,
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="boxplot",
        stat_params=list(),
        geom="boxplot",
        geom_params=list(color="red",fill="red", alpha=.5),
        posiion=position_identity()
  ) + 
  layer(data=Plot2_df_top10,
        mapping=aes(x=as.numeric(POP), y=as.numeric(TOTAL_RESTAURANTS)),
        stat="boxplot",
        stat_params=list(),
        geom="boxplot",
        geom_params=list(color="red",fill="red", alpha=.4),
        posiion=position_identity()
  )
