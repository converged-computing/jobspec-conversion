#!/bin/bash
#FLUX: --job-name=r0_9_l_k
#FLUX: -c=48
#FLUX: -t=345600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export MKL_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export HOME='~'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export MKL_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export HOME=~
module load compiler/intel/19.1.2
module load mpi/impi
module load devel/valgrind
module load numlib/mkl/2020.2
srun $(ws_find conda)/conda/envs/quimbPet/bin/python ~/Anderson-localization/mpsPhonons.py ${SLURM_ARRAY_TASK_ID} ${SLURM_ARRAY_TASK_COUNT}
