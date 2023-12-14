install.packages("maps")
library(maps)
library(tidyverse)

### Load in datasets
us_map <- map_data("state")

overdose <- read_csv("work/source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))
ssp <- read_csv("work/source_data/SSP_Data.csv", locale = locale(encoding = "latin1"))

merged_data <- merge(overdose, ssp, by = "State")

merged_data$`State` <- tolower(merged_data$`State`)


us_map_merged <- merge(us_map, merged_data, by.x = "region", by.y = "State", all.x = TRUE)

us_map_merged$`ssp_does state allow` <- ifelse(us_map_merged$`ssp_does state allow` == 0, "No", "Yes")


### Make graph
ggplot(us_map_merged, aes(x = long, y = lat, group = group, fill = `ssp_does state allow`)) +
  geom_polygon(color = "white", size = 0.5) +
  scale_fill_manual(values = c("No" = "lightblue", "Yes" = "darkblue"), na.value = "grey50", guide = "legend", name = "Legal") +
  labs(title = "State Law Allows for Syringe Services Programs (SSPs)",
       fill = "State Allows SSP") +
  theme_minimal()

ggsave(filename = "work/figures/us_map_ssp.png", 
       width = 6,  
       height = 4, 
       units = "in") 

