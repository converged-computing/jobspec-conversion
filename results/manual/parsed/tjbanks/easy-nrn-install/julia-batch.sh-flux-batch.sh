#!/bin/bash
#FLUX: --job-name=spicy-cat-6020
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=128
#FLUX: --queue=knl
#FLUX: -t=900
#FLUX: --urgency=16

export KMP_AFFINITY='SCATTER'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load intel-ics intel-impi
export KMP_AFFINITY=SCATTER
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun ./mpi-prog
