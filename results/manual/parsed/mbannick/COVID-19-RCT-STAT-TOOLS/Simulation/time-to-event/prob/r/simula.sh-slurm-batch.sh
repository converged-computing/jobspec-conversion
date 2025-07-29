#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: -c=2
#FLUX: --queue=campus-new
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
ml R
R CMD BATCH simula.r simula.rout
