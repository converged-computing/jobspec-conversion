#!/bin/bash
#SBATCH --job-name=MH_Li
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:01:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=4

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
