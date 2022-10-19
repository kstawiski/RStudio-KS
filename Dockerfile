FROM rocker/rstudio
LABEL maintainer "Konrad Stawiski <konrad@konsta.com.pl>"

ENV DEBIAN_FRONTEND=noninteractive
ENV ROOT=true
ENV DISABLE_AUTH=true
ENV USERID=1000
ENV GROUPID=1000

RUN apt update && apt -y dist-upgrade && apt -y install mc autossh curl libz-dev libxml2-dev libglpk-dev libbz2-dev liblzma-dev libxt6 libmagick++-6.q16-dev

COPY cuda.sh /
RUN bash /cuda.sh

# Google Cloud for Terra
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y && export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && apt-get update && apt-get install gcsfuse -y

# Get docker for docker in docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sudo bash get-docker.sh && rm get-docker.sh

# Install code-server
# RUN curl -fsSL https://code-server.dev/install.sh | sh

# Ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && tar xvzf ngrok-v3-stable-linux-amd64.tgz && rm ngrok-v3-stable-linux-amd64.tgz && ./ngrok config add-authtoken 2GJj2YAtqhxPapAatx2QxqfKn61_5PRMDpMj5n9vwMrtCeMNe 

# Signularity - get new from https://github.com/sylabs/singularity/releases
RUN wget https://github.com/sylabs/singularity/releases/download/v3.10.3/singularity-ce_3.10.3-focal_amd64.deb && apt -y install ./singularity-ce_3.10.3-focal_amd64.deb && rm ./singularity*.deb

# Dropbox
RUN apt -y install python3-pip && pip3 install dbxfs

RUN Rscript -e "update.packages(ask = F)"
RUN Rscript -e "install.packages('devtools')"

COPY setup.R /
RUN Rscript /setup.R

# Inherited
EXPOSE 8787
CMD ["/init"]


