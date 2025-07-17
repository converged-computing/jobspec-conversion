#!/bin/bash
#FLUX: --job-name=JobArray
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

srun sleep $SLURM_ARRAY_TASK_ID
srun echo running on $(hostname)
module load intel/2015a
srun /sNow/utils/bin/pi_mpi
