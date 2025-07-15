#!/bin/bash
#FLUX: --job-name=lovely-chip-3263
#FLUX: --priority=16

module load OpenMPI
module load Julia
n=$SLURM_NTASKS
srun -n $n julia estimate_pi.jl         
