#!/bin/bash
#SBATCH --account=p200301
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=16
#SBATCH --time=00:15:00
#SBATCH --qos=default

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun  --mpi=pspmix --cpus-per-task=$SLURM_CPUS_PER_TASK ./conjugate_gradients
