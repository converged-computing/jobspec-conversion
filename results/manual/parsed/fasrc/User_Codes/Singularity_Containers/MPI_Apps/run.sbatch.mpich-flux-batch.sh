#!/bin/bash
#FLUX: --job-name=phat-pedo-8663
#FLUX: --priority=16

module load python/3.8.5-fasrc01
source activate python3_env1
srun -n 8 --mpi=pmi2 singularity exec mpich_test.simg /usr/bin/mpitest.x
