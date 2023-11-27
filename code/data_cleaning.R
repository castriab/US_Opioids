library(tidyverse)
library(readr)

overdose <- read_csv("work/source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))
ssp <- read_csv("work/source_data/SSP_Data.csv", locale = locale(encoding = "latin1"))

merged_data <- merge(overdose, ssp, by = "State")