#!/bin/bash
#FLUX: --job-name=sticky-cat-8926
#FLUX: --urgency=16

module load intel/24.0.1-fasrc01  intelmpi/2021.11-fasrc01
srun -n $SLURM_NTASKS --mpi=pmi2 ./mpitest.x
