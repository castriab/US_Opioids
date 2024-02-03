## **How do economic and political factors impact drug overdose rates on the state level?**

### Cynthia Fisher

In this project I aimed to understand if how a variety of economic and political factors impact drug overdose rates in the United States. 

To explore these connections, I used two data sets. The first data set was extracted from the CDC and contained information on state opioid overdose rates per 100,000 and economic factors. This first dataset is available [here](https://www.kaggle.com/datasets/craigchilvers/opioids-in-the-us-cdc-drug-overdose-deaths/data). The second data set has information harm reduction laws in each state, specifically focusing on the legality of syringe service programs. This second data set is available [here](https://lawatlas.org/datasets/syringe-services-programs-laws).

## Getting started

First, open your perferred terminal and clone this repository by running this command.

```
git clone https://github.com/castriab/BIOS611

cd 611/
```

This repository can be built using Docker. Run this command in your terminal to create a docker container.

``` 
docker build . -t 611 
``` 

Then to launch the docker container run this command

```
docker run -v $(pwd):/home/rstudio/work\
           -p 8787:8787\
           -p 8088:8088\
           -e PASSWORD=password\
           -it 611
```

If you are running Windows Powershell you may need to use this code instead

```
docker run -v ${PWD}:/home/rstudio/work `
           -p 8787:8787 `
           -p 8088:8088 `
           -e PASSWORD=password `
           -it 611
```

Now you are able to log in to a locally hosted RStudio server. Open your web browser and navigate to http://localhost:8787 . Then, log on with the username `rstudio` and password `password`.

## Project Organization
The best way to understand what this project does is to examine the Makefile.

A Makefile is a textual description of the relationships between artifacts (like data, figures, source files, etc.). In particular, it documents for each artifact of interest in the project: 
  - What is needed to construct that artifact 
  - How to construct it
  
A Makefile is more than documentation. Using the tool make (included in the Docker container), the Makefile allows for the automatic reproduction of an artifact (and all the artifacts which it depends on) by simply issuing the command to make it.

Consider this snippet from the Makefile included in this project:

```
# Data cleaning 
derived_data/cleaned_data.csv: .created-dirs code/data_cleaning.R source_data/CDC_Drug_Overdose_Deaths.csv source_data/SSP_Data.csv
	Rscript code/data_cleaning.R
```
The lines with `#` are comments which describe the target. 
Here we describe an artifact (`derived_data/cleaned_data.csv`), its dependencies (`.created-dirs`, `code/data_cleaning.R`, `source_data/CDC_Drug_Overdose_Deaths.csv`, `source_data/SSP_Data.csv`) and how to build it Rscript `code/data_cleaning.R`. If we invoke Make like so:

```
make derived_data/cleaned_data.csv
```

Make will construct this artifact for us. If a dependency does not exist for some reason it will also construct that artifact on the way. 

## Building the final report

In order to generate the final report, use the following command. Ensure that you are in the `work` directory while running this command.

```
make report.html
```



