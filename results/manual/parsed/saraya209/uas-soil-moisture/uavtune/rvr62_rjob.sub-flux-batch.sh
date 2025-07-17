#!/bin/bash
#FLUX: --job-name=rvr62
#FLUX: --queue=fast.q
#FLUX: --urgency=16

module load openmpi-2.0/intel
module load anaconda3
source activate my-R
mpirun -np 1 --bind-to none R CMD BATCH --no-save RVR62.R
