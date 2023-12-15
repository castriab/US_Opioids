library(tidyverse)
library(readr)

overdose <- read_csv("source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))
ssp <- read_csv("source_data/SSP_Data.csv", locale = locale(encoding = "latin1"))

ssp_mutated <- ssp %>%
  mutate(
    HIV_screening = as.integer(grepl("HIV screening", `ssp_services required provided`)),
    Educational_services = as.integer(grepl("Educational services", `ssp_services required provided`)),
    Disposal_services = as.integer(grepl("Disposal services", `ssp_services required provided`)),
    Drug_abuse_treatment_services = as.integer(grepl("Drug abuse treatment services", `ssp_services required provided`)),
    Hepatitis_screening = as.integer(grepl("Hepatitis screening", `ssp_services required provided`)),
    Naloxone_services = as.integer(grepl("Naloxone services", `ssp_services required provided`))
  )

colnames(overdose) <- c("State",	"State Abbreviation",	"2019",	"2019 Number of Deaths", "2018",	
                        "2018 Number of Deaths",	"2017",
                        "2017 Number of Deaths",	"2016",
                        "2016 Number of Deaths",	"2015",
                        "2015 Number of Deaths",	"2014",	"2014 Number of Deaths",
                        "2013",	"2013 Number of Deaths", "2019 Poverty rate (percent of persons in poverty)",
                        "Gini coefficient of income inequality",	"GDP per capita 2021",	"GDP (nominal in millions of USD)",
                        "2021 Urban population as a percentage of the total population in 2010",
                        "Population density per km≤",	"Population", "Land Area (km≤)")

merged_data <- merge(overdose, ssp_mutated, by = "State")


merged_data$`State` <- tolower(merged_data$`State`)

write_csv(merged_data, "derived_data/cleaned_data.csv")


