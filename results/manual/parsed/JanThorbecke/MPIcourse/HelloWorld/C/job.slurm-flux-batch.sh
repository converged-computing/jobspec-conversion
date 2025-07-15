#!/bin/bash
#FLUX: --job-name=tart-chip-1320
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: -t=9
#FLUX: --urgency=16

echo $SLURM_JOB_NODELIST
sleep 10 
srun --mpi=pmix -n $SLURM_NTASKS ./hello_world
