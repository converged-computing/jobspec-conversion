#!/bin/bash
#FLUX: --job-name=chromvar
#FLUX: -t=18000
#FLUX: --urgency=16

source ~/.bashrc
conda activate r-4.0.3
Rscript run_chromvar.R
