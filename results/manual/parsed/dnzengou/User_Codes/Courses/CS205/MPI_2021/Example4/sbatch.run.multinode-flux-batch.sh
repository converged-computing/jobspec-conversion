#!/bin/bash
#FLUX: --job-name=fuzzy-leopard-5311
#FLUX: --priority=16

PRO=mmult
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
