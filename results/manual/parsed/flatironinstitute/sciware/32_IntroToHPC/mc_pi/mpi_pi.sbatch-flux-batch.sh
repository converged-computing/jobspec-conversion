#!/bin/bash
#FLUX: --job-name=lovely-buttface-5364
#FLUX: --queue=scc
#FLUX: -t=600
#FLUX: --urgency=16

echo $SLURM_JOBID
source load_env.sh
srun python mpi_pi.py 1000000
