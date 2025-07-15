#!/bin/bash
#FLUX: --job-name=placid-lentil-5887
#FLUX: --priority=16

PRO=mmult
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
