#!/bin/bash
#FLUX: --job-name=confused-squidward-2856
#FLUX: --urgency=16

PRO=mpi_dot
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x | sort -k7 -n > ${PRO}.dat
