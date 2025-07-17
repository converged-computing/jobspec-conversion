#!/bin/bash
#FLUX: --job-name=reclusive-bits-8210
#FLUX: --queue=cpu
#FLUX: -t=600
#FLUX: --urgency=16

module load OpenMPI
module load Julia
n=$SLURM_NTASKS
srun -n $n julia estimate_pi.jl         
