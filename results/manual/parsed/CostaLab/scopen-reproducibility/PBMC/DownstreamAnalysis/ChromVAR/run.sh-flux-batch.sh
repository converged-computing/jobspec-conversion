#!/bin/bash
#FLUX: --job-name=bloated-bike-4047
#FLUX: --urgency=16

source ~/.bashrc
conda activate r-4.0.3
time Rscript run_chromvar.R
