#!/bin/bash
#FLUX: --job-name=BBPip
#FLUX: -c=4
#FLUX: --queue=htc
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun -np $SLURM_NTASKS python main.py $1
