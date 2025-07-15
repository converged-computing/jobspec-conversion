#!/bin/bash
#FLUX: --job-name=creamy-house-5920
#FLUX: -N=7
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --priority=15

export JULIA_WORKER_TIMEOUT='300'

module load julia/1.1.0
export JULIA_WORKER_TIMEOUT=300
rm -f nodefile
for i in `srun -n $SLURM_NTASKS hostname |sort`
do echo $i-ib0 >> nodefile
done
julia ../../../../specPredDensity.jl 112 $1 $2 $3 $4
