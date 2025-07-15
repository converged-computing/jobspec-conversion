#!/bin/bash
#FLUX: --job-name="misTreat"
#FLUX: --priority=16

ulimit -l unlimited
module load gcc/6.2.0 R/4.0.1
module load openmpi/4.1.1
mpirun --mca btl tcp,self Rscript tmle_MultinomialTrts.R ${SLURM_ARRAY_TASK_ID} 'binomial' 'TRUE' 'TRUE' 'FALSE' 'FALSE' 'TRUE' 'FALSE' 'FALSE'
