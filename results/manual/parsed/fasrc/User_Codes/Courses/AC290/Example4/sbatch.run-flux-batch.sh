#!/bin/bash
#FLUX: --job-name=mmult
#FLUX: -n=4
#FLUX: --queue=shared
#FLUX: -t=30
#FLUX: --urgency=16

module load gcc/8.2.0-fasrc01
module load openmpi/3.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./mmult.x
