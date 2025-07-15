#!/bin/bash
#FLUX: --job-name=expensive-plant-9330
#FLUX: --priority=16

PRO=mpi_dot
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x | sort -k7 -n > ${PRO}.dat
