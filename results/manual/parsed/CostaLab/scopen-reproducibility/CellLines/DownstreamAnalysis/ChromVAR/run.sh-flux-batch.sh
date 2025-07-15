#!/bin/bash
#FLUX: --job-name=phat-punk-3463
#FLUX: --priority=16

source ~/.bashrc
conda activate r-4.0.3
Rscript run_chromvar.R
