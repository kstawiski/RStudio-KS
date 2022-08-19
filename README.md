# RStudio-KS

Version of RStudio Server with OmicSelector and other usefull packages for NGS analysis.

# Run

```
docker pull ghcr.io/kstawiski/rstudio-ks:main
docker run -d --gpus all --name RStudio-KS -p 28787:8787 -v /home/konrad/Projekty/:/home/rstudio/Projekty/ ghcr.io/kstawiski/rstudio-ks:main
```
