#!/bin/bash
#FLUX: --job-name=pusheena-lentil-4434
#FLUX: -c=6
#FLUX: -t=14400
#FLUX: --priority=16

Rscript /home/malosree/projects/def-gturecki/malosree/scclusteval_round2/pyflow_seurat_parameter_custom/post_snakemake.R
