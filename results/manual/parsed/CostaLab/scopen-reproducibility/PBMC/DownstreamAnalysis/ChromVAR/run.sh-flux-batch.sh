#!/bin/bash
#FLUX: --job-name=red-cat-0076
#FLUX: --priority=16

source ~/.bashrc
conda activate r-4.0.3
time Rscript run_chromvar.R
