overdose <- read_csv("source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))

ggplot(overdose, aes(x = `2019 Poverty rate (percent of persons in poverty)`, y = `2019 Age-adjusted Rate (per 100,000 population)`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add a linear regression line
  geom_text(aes(label = ifelse(`2019 Age-adjusted Rate (per 100,000 population)` > 50, `State Abbreviation`, "")),
            hjust = -0.25, vjust = 0, size = 3, color = "red") +  # Add labels for extreme values
  geom_text(aes(label = ifelse(`2019 Poverty rate (percent of persons in poverty)`> 20, `State Abbreviation`, "")),
            hjust = -0.25, vjust = 0, size = 3, color = "red") +  # Add labels for extreme values
  
  labs(title = "Relationship Between Poverty Rate and Overdose Rate",
       x = "Poverty Rate",
       y = "2019 Overdose Rate") +
  theme_minimal()

ggsave(filename = "figures/poverty_vs_overdose.png", 
       width = 10,  
       height = 8, 
       units = "in")  
