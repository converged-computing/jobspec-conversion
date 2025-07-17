#!/bin/bash
#FLUX: --job-name=mpitest
#FLUX: -n=8
#FLUX: --queue=rc-testing
#FLUX: -t=1800
#FLUX: --urgency=16

module load gcc/13/2-fasrc01 openmpi/5.0.2-fasrc01 
srun -n $SLURM_NTASKS --mpi=pmix ./mpitest.x
