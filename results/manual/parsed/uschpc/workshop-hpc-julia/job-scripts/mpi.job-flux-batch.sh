#!/bin/bash
#FLUX: --job-name=swampy-puppy-8891
#FLUX: -N=2
#FLUX: --queue=epyc-64
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load julia/1.10.2
module load gcc/12.3.0
module load openmpi/4.1.6
ulimit -s unlimited
srun --mpi=pmix_v2 -n $SLURM_NTASKS julia mpi.jl
