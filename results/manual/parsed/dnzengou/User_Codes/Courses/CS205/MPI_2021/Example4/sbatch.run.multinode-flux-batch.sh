#!/bin/bash
#FLUX: --job-name=mmult
#FLUX: -n=4
#FLUX: -t=30
#FLUX: --urgency=16

PRO=mmult
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
