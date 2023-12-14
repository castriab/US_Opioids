.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs
	
# Data cleaning 
derived_data/cleaned_data.csv: .created-dirs data_cleaning.R source_data/CDC_Drug_Overdose_Deaths.csv source_data/SSP_Data.csv
	Rscript data_cleaning.R

# Make figures for report
figures/state_overdose_rates_2019.png: source_data/CDC_Drug_Overdose_Deaths.csv state_overdose_rates_2019.R
	Rscript state_overdose_rates_2019.R

figures/state_poverty_rates_2019.png: source_data/CDC_Drug_Overdose_Deaths.csv state_poverty_rates_2019.R
	Rscript state_poverty_rates_2019.R
	
figures/us_map_overdose_rates_2013.png: source_data/CDC_Drug_Overdose_Deaths.csv us_map_overdose_rates_2013.R
	Rscript us_map_overdose_rates_2013.R
	
figures/us_map_overdose_rates_2019.png: source_data/CDC_Drug_Overdose_Deaths.csv us_map_overdose_rates_2019.R
	Rscript us_map_overdose_rates_2019.R
	
figures/poverty_vs_overdose.png: source_data/CDC_Drug_Overdose_Deaths.csv poverty_vs_overdose.R
	Rscript poverty_vs_overdose.R
	
figures/correlation_matrix.png: source_data/CDC_Drug_Overdose_Deaths.csv correlation.R
	Rscript correlation.R
	
figures/us_map_ssp.png: source_data/CDC_Drug_Overdose_Deaths.csv source_data/SSP_Data.csv us_map_ssp_legality.R
	Rscript us_map_ssp_legality.R
	
figures/required_services_SSPs.png: source_data/CDC_Drug_Overdose_Deaths.csv source_data/SSP_Data.csv required_services_SSPs.R
	Rscript required_services_SSPs.R
	
report.html: figures/us_map_overdose_rates_2013.png figures/us_map_overdose_rates_2019.png figures/poverty_vs_overdose.png figures/correlation_matrix.png figures/us_map_ssp.png figures/required_services_SSPs.png
	R -e "rmarkdown::render(\"Report.Rmd\", output_format = \"html_document\")"

	

	