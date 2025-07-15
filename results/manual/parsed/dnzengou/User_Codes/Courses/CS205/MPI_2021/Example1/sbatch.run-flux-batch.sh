#!/bin/bash
#FLUX: --job-name=phat-diablo-2322
#FLUX: --urgency=16

PRO=mpi_hello
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
