library(tidyverse)
library(readr)

overdose <- read_csv("work/611/source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))


# Create a bar plot for 2019 overdose rates by state (sorted from highest to lowest)
ggplot(overdose, aes(x = reorder(`State Abbreviation`, -`2019 Age-adjusted Rate (per 100,000 population)`), 
                     y = `2019 Age-adjusted Rate (per 100,000 population)`)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  ggtitle("Overdose Rates by State (2019) from Highest to Lowest") +
  xlab("State") +
  ylab("2019 Age-adjusted Rate (per 100,000 population)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the ggplot object to a file
ggsave(filename = "work/611/figures/state_overdose_rates_2019.png", 
       width = 10,  
       height = 8, 
       units = "in")  

