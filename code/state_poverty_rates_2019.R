library(tidyverse)
library(readr)

overdose <- read_csv("work/611/source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))


ggplot(overdose, aes(x = reorder(`State Abbreviation`, -`2019 Poverty rate (percent of persons in poverty)`), 
                     y = `2019 Poverty rate (percent of persons in poverty)`)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  ggtitle("Poverty Rates by State (2019) from Highest to Lowest") +
  xlab("State") +
  ylab("2019 Poverty rate (percent of persons in poverty)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the ggplot object to a file
ggsave(filename = "work/611/figures/state_poverty_rates_2019.png", 
       width = 10,  
       height = 8, 
       units = "in")  
