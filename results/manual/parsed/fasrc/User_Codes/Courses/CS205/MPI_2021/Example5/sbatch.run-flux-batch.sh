#!/bin/bash
#FLUX: --job-name=strawberry-leopard-5786
#FLUX: --priority=16

PRO=planczos
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
