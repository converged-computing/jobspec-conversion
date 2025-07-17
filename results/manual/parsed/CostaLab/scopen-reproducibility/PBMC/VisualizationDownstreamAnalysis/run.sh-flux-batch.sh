#!/bin/bash
#FLUX: --job-name=analysis
#FLUX: -c=12
#FLUX: -t=36000
#FLUX: --urgency=16

source ~/.bashrc
conda activate r-4.0.3
Rscript visualize_UMAP.R
