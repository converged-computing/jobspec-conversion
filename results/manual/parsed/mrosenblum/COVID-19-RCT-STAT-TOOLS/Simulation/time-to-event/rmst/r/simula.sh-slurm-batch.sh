#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: --queue=panda
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load -r @3.5.1
R CMD BATCH simula.r simula.rout
