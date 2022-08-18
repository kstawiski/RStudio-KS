FROM rocker/rstudio
LABEL maintainer "Konrad Stawiski <konrad@konsta.com.pl>"

ENV ROOT=true
ENV DISABLE_AUTH=true
ENV USERID=1000
ENV GROUPID=1000

RUN apt update && apt -y dist-upgrade && apt -y install mc autossh libz-dev libxml2-dev libglpk-dev libbz2-dev liblzma-dev libxt6 libmagick++-6.q16-dev

COPY cuda.sh /
RUN bash /cuda.sh

RUN Rscript -e "update.packages(ask = F)"
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::source_url('https://raw.githubusercontent.com/kstawiski/OmicSelector/master/vignettes/setup.R')"

COPY setup.R /
RUN Rscript /setup.R

# Inherited
EXPOSE 8787
CMD ["/init"]


