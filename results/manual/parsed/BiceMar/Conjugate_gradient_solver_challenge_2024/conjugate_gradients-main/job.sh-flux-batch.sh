#!/bin/bash
#FLUX: --job-name=chunky-buttface-6809
#FLUX: -n=10
#FLUX: -c=16
#FLUX: --queue=cpu
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun  --mpi=pspmix --cpus-per-task=$SLURM_CPUS_PER_TASK ./conjugate_gradients
