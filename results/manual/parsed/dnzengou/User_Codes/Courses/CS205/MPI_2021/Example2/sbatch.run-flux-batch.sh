#!/bin/bash
#FLUX: --job-name=expressive-leg-0232
#FLUX: --urgency=16

PRO=mpi_dot
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x | sort -k7 -n > ${PRO}.dat
