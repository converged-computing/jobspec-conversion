#!/bin/bash
#SBATCH --account=edu23.introgpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
echo '--- Run solution_hip ---'
time srun -n 1 solution_hip
