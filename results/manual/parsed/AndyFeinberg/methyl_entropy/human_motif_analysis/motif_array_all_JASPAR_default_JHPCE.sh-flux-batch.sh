#!/bin/bash
#FLUX: --job-name=motif_array
#FLUX: -c=24
#FLUX: --queue=shared,parallel,skylake
#FLUX: -t=43200
#FLUX: --urgency=16

ml R/3.6.1
ml atlas
ml intel/18.0
Rscript --vanilla motif_break_array.R "$SLURM_ARRAY_TASK_ID" variant_in_all.rds 50 motif_all_JASPAR default 
