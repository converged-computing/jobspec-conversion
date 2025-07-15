#!/bin/bash
#FLUX: --job-name=reclusive-salad-1522
#FLUX: --priority=16

echo $SLURM_JOBID
source load_env.sh
srun python mpi_pi.py 1000000
