#!/bin/bash
#SBATCH --job-name=optimize_mpi
#SBATCH --output=optimize_mpi.out
#SBATCH --error=optimize_mpi.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:30:00

module load python/3.10.12-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.5-fasrc03
source activate python3_env2
srun -n 8 --mpi=pmix python optimize_mpi.py
