#!/bin/bash
#FLUX: --job-name=lovable-train-5060
#FLUX: --urgency=16

PRO=mpi_hello
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
