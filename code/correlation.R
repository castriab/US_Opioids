library(tidyverse)
library(dplyr)
library(png)
library(corrplot)

overdose <- read_csv("source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))
num_overdose <- overdose[, -c(1, 2)]
num_overdose <- num_overdose[, -c(2:14)]
num_overdose <- num_overdose[, -c(5)]

colnames(num_overdose) <- c('Overdose Rate', "Poverty Rate", "Income Inequality", 'GDP per Capita', "Urban Percent", "Population Density", "Population", "Land Area")
corr <- round(cor(num_overdose), 1)

png("figures/correlation_matrix.png", width=680, height=680)
corrplot(corr, type = "lower", tl.cex = 1.5)
dev.off()
