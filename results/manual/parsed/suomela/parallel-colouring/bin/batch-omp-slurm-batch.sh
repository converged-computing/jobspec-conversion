#!/bin/bash
#SBATCH --output=tmp/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2000
#SBATCH --time=00:30:00
#SBATCH --qos=short
#SBATCH --constraint=xeon
#SBATCH --array=10-31

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
srun bin/run-test triton build-omp $SLURM_ARRAY_TASK_ID
