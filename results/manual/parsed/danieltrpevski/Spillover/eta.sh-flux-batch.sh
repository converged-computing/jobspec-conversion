#!/bin/bash
#FLUX: --job-name=no_spillover
#FLUX: -N=25
#FLUX: --queue=normal
#FLUX: -t=57600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
for i in $(seq 0 5 50)
do
   srun python3 ./eta_mpi.py $i
done
