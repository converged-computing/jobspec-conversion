#!/bin/bash
#FLUX: --job-name=mmult
#FLUX: -n=4
#FLUX: --queue=test
#FLUX: -t=30
#FLUX: --urgency=16

PRO=mmult
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
