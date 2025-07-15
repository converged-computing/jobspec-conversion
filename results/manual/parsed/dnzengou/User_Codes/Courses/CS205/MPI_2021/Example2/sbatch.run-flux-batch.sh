#!/bin/bash
#FLUX: --job-name=doopy-cattywampus-8468
#FLUX: --priority=16

PRO=mpi_dot
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x | sort -k7 -n > ${PRO}.dat
