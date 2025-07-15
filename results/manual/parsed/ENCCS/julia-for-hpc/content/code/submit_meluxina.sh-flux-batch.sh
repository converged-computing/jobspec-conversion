#!/bin/bash
#FLUX: --job-name=cowy-leader-9081
#FLUX: --urgency=16

module load OpenMPI
module load Julia
n=$SLURM_NTASKS
srun -n $n julia estimate_pi.jl         
