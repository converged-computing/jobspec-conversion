#!/bin/bash
#FLUX: --job-name=blank-nunchucks-0958
#FLUX: -N=2
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module load gcc/8.3.0
module load openblas/0.3.8
module load openmpi/4.0.2
module load pmix/3.1.3
module load r/4.0.0
srun --mpi=pmix_v2 -n $SLURM_NTASKS Rscript --vanilla script.R
