#!/bin/bash
#FLUX: --job-name=stinky-lentil-6344
#FLUX: -n=4
#FLUX: -t=300
#FLUX: --urgency=16

export UCX_TLS='sm,tcp,self'

module purge
module load gcc/8.3.0
module load openmpi/4.0.2
module load pmix/3.1.3
export UCX_TLS=sm,tcp,self
ulimit -s unlimited
srun --mpi=pmix_v2 -n $SLURM_NTASKS ./p2_3
