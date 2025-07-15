#!/bin/bash
#FLUX: --job-name=fuzzy-hobbit-9884
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=128
#FLUX: --queue=knl
#FLUX: -t=900
#FLUX: --priority=16

export KMP_AFFINITY='SCATTER'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load intel-ics intel-impi
export KMP_AFFINITY=SCATTER
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun ./mpi-prog
