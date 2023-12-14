library(tidyverse)
library(readr)

ssp <- read_csv("work/source_data/SSP_Data.csv", locale = locale(encoding = "latin1"))

ssp_mutated <- ssp %>%
  mutate(
    HIV_screening = as.integer(grepl("HIV screening", `ssp_services required provided`)),
    Educational_services = as.integer(grepl("Educational services", `ssp_services required provided`)),
    Disposal_services = as.integer(grepl("Disposal services", `ssp_services required provided`)),
    Drug_abuse_treatment_services = as.integer(grepl("Drug abuse treatment services", `ssp_services required provided`)),
    Hepatitis_screening = as.integer(grepl("Hepatitis screening", `ssp_services required provided`)),
    Naloxone_services = as.integer(grepl("Naloxone services", `ssp_services required provided`))
  )

service_counts <- ssp_mutated %>%
  summarise(
    HIV_screening = sum(HIV_screening),
    Educational_services = sum(Educational_services),
    Disposal_services = sum(Disposal_services),
    Drug_abuse_treatment_services = sum(Drug_abuse_treatment_services),
    Hepatitis_screening = sum(Hepatitis_screening),
    Naloxone_services = sum(Naloxone_services)
  )

service_counts_long <- tidyr::gather(service_counts, key = "Service", value = "Count")
service_counts_long$Service <- gsub("_", " ", service_counts_long$Service)

# Create a bar chart
ggplot(service_counts_long, aes(x = Service, y = Count, fill = Service)) +
  geom_bar(stat = "identity") +
  geom_text(size=3, aes(label = Count), vjust = -0.25) +
  labs(title = "What additional services must be provided at SSPs?",
       x = "Required Services",
       y = "Number of States",
       fill = NULL) +
  theme_minimal() +
  theme(axis.text.x = element_blank())


# Save the ggplot object to a file
ggsave(filename = "work/figures/required_services_SSPs.png", 
       width = 6,  
       height = 4, 
       units = "in")  