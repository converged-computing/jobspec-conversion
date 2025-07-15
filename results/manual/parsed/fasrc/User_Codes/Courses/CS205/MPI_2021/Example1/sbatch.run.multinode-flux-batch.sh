#!/bin/bash
#FLUX: --job-name=hello-truffle-3035
#FLUX: --priority=16

PRO=mpi_hello
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
