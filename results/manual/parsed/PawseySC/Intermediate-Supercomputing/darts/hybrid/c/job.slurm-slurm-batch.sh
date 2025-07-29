#!/bin/bash
#SBATCH --job-name=darts-hybrid
#SBATCH --account=courses01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

export OMP_NUM_THREADS='6'
export OMP_PLACES='cores'
export OMP_PROC_BIND='close'

module swap PrgEnv-cray PrgEnv-intel 
export OMP_NUM_THREADS=6
export OMP_PLACES=cores
export OMP_PROC_BIND=close
srun --export=ALL -n 4 -c 6 darts-hybrid
