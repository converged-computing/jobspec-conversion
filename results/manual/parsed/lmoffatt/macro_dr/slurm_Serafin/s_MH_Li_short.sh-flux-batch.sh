#!/bin/bash
#FLUX: --job-name=MH_Li
#FLUX: -c=16
#FLUX: --queue=short
#FLUX: -t=60
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MKL_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PATH_MACRO_DR='/home/lmoffatt/macro_dr/v8/'

. /etc/profile
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PATH_MACRO_DR=/home/lmoffatt/macro_dr/v8/
module load amdblis
module load amdlibflame
srun /home/lmoffatt/macro_dr/macro_dr/multi_task/multi_task_slurm.sh
