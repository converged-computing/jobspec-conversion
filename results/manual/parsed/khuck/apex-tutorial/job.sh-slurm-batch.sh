#!/bin/bash
#SBATCH --account=project_2006549
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --time=00:10:00
#SBATCH --partition=True
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='close'
export OMP_PLACES='threads'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=close
export OMP_PLACES=threads
module load cuda/11.5.0 cmake papi APEX
srun ./build/bin/pthread_c
