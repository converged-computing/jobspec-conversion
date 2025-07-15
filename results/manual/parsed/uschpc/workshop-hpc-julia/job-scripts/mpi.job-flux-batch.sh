#!/bin/bash
#FLUX: --job-name=adorable-egg-7172
#FLUX: -N=2
#FLUX: --queue=epyc-64
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load julia/1.10.2
module load gcc/12.3.0
module load openmpi/4.1.6
ulimit -s unlimited
srun --mpi=pmix_v2 -n $SLURM_NTASKS julia mpi.jl
