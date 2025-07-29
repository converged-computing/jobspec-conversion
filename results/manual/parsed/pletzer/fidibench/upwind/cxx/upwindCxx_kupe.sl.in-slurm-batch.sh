#!/bin/bash
#SBATCH --job-name=upwindCxx
#SBATCH --account=nesi99999
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export OMP_PROC_BIND='true'
export OMP_PLACES='cores'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_PROC_BIND=true
export OMP_PLACES=cores
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindCxx"
time srun --hint=nomultithread $exe -numCells 800 -numSteps 10
