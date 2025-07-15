#!/bin/bash
#FLUX: --job-name=scruptious-gato-7443
#FLUX: --priority=16

module load gcc/8.2.0-fasrc01
module load openmpi/3.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./mmult.x
