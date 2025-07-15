#!/bin/bash
#FLUX: --job-name=eccentric-peanut-2702
#FLUX: --priority=16

source ~/.bashrc
conda activate r-4.0.3
Rscript visualize_UMAP.R
