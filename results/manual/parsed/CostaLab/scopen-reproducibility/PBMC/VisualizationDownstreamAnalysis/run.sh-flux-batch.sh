#!/bin/bash
#FLUX: --job-name=evasive-fork-6277
#FLUX: --urgency=16

source ~/.bashrc
conda activate r-4.0.3
Rscript visualize_UMAP.R
