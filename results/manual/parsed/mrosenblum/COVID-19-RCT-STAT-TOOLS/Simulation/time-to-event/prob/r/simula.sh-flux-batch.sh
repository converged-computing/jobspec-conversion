#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: --queue=curie-cpu
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load /mjrrusu
R CMD BATCH simula.r simula.rout
