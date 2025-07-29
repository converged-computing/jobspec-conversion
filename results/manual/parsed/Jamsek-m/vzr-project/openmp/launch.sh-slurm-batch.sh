#!/bin/bash
#SBATCH --job-name=heat
#SBATCH --output=out/run_32_cores_1024.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:10:00
#SBATCH --constraint=AMD

export OMP_PLACES='cores'
export OMP_PROC_BIND='TRUE'
export OMP_NUM_THREADS='32'

export OMP_PLACES=cores
export OMP_PROC_BIND=TRUE
export OMP_NUM_THREADS=32
srun prog 1024 1024 1 1
wait
