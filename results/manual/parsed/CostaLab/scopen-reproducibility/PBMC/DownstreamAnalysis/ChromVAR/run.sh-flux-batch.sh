#!/bin/bash
#FLUX: --job-name=chromvar
#FLUX: -c=8
#FLUX: -t=432000
#FLUX: --urgency=16

source ~/.bashrc
conda activate r-4.0.3
time Rscript run_chromvar.R
