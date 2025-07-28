#!/bin/bash
#FLUX: --job-name=fugly-leg-7246
#FLUX: -c=6
#FLUX: -t=14400
#FLUX: --urgency=16

Rscript /home/malosree/projects/def-gturecki/malosree/scclusteval_round2/pyflow_seurat_parameter_custom/post_snakemake.R
