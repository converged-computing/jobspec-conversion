#!/bin/bash
#FLUX --job-name=nerdy-fudge-0454
#FLUX --queue=scc
#FLUX -t=600
#FLUX --urgency=16

echo $SLURM_JOBID
source load_env.sh
srun python mpi_pi.py 1000000
