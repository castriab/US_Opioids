FROM rocker/verse 

RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
RUN yes|unminimize

RUN R -e "install.packages(\"tidyverse\")"
RUN R -e "install.packages(\"maps\")"
RUN R -e "install.packages(\"kableExtra\")"
RUN R -e "install.packages(\"readr\")"
RUN R -e "install.packages(\"glmnet\")"
RUN R -e "install.packages(\"corrplot\")"
RUN R -e "install.packages(\"png\")"
RUN R -e "install.packages(\"ggplot2\")"
RUN R -e "install.packages(\"dplyr\")"
RUN R -e "install.packages(\"glmnet\")"
RUN R -e "install.packages(\"pROC\")"

