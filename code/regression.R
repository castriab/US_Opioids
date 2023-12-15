library(tidyverse)
library(readr)
library(glmnet)
library(pROC)
library(kableExtra)
library(ggplot2)

overdose <- read_csv("source_data/CDC_Drug_Overdose_Deaths.csv", locale = locale(encoding = "latin1"))
ssp <- read_csv("source_data/SSP_Data.csv", locale = locale(encoding = "latin1"))

colnames(overdose) <- c("State",	"State Abbreviation",	"2019",	"2019 Number of Deaths", "2018",	
                        "2018 Number of Deaths",	"2017",
                        "2017 Number of Deaths",	"2016",
                        "2016 Number of Deaths",	"2015",
                        "2015 Number of Deaths",	"2014",	"2014 Number of Deaths",
                        "2013",	"2013 Number of Deaths", "2019 Poverty rate (percent of persons in poverty)",
                        "Gini coefficient of income inequality",	"GDP per capita 2021",	"GDP (nominal in millions of USD)",
                        "2021 Urban population as a percentage of the total population in 2010",
                        "Population density per km≤",	"Population", "Land Area (km≤)")

final_overdose <- overdose[, -2]
final_overdose <- final_overdose[, -c(3:15)]
final_overdose <- final_overdose[, -c(6)]

final_ssp <- ssp[, c(1,2)]
merged_data <- merge(final_overdose, final_ssp, by = "State")
merged_data <- merged_data[, -1]
merged_data <- merged_data[, -8]

summary(merged_data$`2019`)

merged_data <- merged_data %>%
  mutate(high_rate = ifelse(`2019` > 25, 1, 0))

results <- cv.glmnet(merged_data %>% select(`2019 Poverty rate (percent of persons in poverty)`:`ssp_does state allow`) %>% as.matrix(),
                     merged_data$high_rate,
                     family = "binomial")
plot(results)

best_model <- glmnet(merged_data %>% select(`2019 Poverty rate (percent of persons in poverty)`:`ssp_does state allow`) %>% as.matrix(),
                     merged_data$high_rate,
                     lambda=results$lambda.min,
                     family = "binomial")
coef(best_model)
names(best_model)
merged_data$rate_predicted_p <- (predict(best_model, merged_data %>% select(`2019 Poverty rate (percent of persons in poverty)`:`ssp_does state allow`) %>% as.matrix(), type="response"))*1;
merged_data$rate_predicted <- (predict(best_model, merged_data %>% select(`2019 Poverty rate (percent of persons in poverty)`:`ssp_does state allow`) %>% as.matrix(), type="response") > 0.65)*1;
confusion <- merged_data %>% group_by(high_rate, rate_predicted) %>% tally()

# save the coefficients_matrix as a csv
coefficients_matrix <- as.matrix(coef(best_model))
coefficients_table <- as.data.frame(coefficients_matrix)
write.csv(coefficients_table, file = "derived_data/coefficients_table.csv")


# Create ROC curve
roc_obj <- roc(merged_data$high_rate, merged_data$rate_predicted_p)

# Save the  ROC curve object to a file
png("figures/roc.png", width=680, height=680)
# Plot the ROC curve
plot(roc_obj, main="ROC Curve", col="blue")
# Add AUC to the plot
text(0.4, 0.5, paste("AUC =", round(auc(roc_obj), 3)), col="blue")
dev.off()