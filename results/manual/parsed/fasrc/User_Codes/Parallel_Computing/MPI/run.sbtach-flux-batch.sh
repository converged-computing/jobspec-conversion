#!/bin/bash
#FLUX: --job-name=scruptious-fork-8704
#FLUX: --urgency=16

module load gcc/13/2-fasrc01 openmpi/5.0.2-fasrc01 
srun -n $SLURM_NTASKS --mpi=pmix ./mpitest.x
