FROM rocker/verse 

RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
RUN yes|unminimize

ARG USER_ID
RUN usermod -u $USER_ID rstudio
RUN chown -R rstudio:rstudio /home/rstudio
