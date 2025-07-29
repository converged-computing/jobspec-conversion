#!/bin/bash
#FLUX: --job-name=hello-mpi
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=9
#FLUX: --urgency=16

echo $SLURM_JOB_NODELIST
sleep 10 
srun --mpi=pmix -n $SLURM_NTASKS ./hello_world
