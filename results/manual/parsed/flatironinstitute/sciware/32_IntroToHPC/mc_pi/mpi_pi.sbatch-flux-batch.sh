#!/bin/bash
#FLUX: --job-name=pusheena-egg-8421
#FLUX: --urgency=16

echo $SLURM_JOBID
source load_env.sh
srun python mpi_pi.py 1000000
