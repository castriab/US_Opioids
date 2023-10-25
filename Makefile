.PHONY: clean

clean:
	rm -rf figures
	mkdir -p figures

figures/state_overdose_rates_2019.png: source_data/CDC_Drug_Overdose_Deaths.csv state_overdose_rates_2019.R
	Rscript state_overdose_rates_2019.R

figures/state_poverty_rates_2019.png: source_data/CDC_Drug_Overdose_Deaths.csv state_poverty_rates_2019.R
	Rscript state_poverty_rates_2019.R