#!/bin/bash
#SBATCH --job-name=mpi4py_test
#SBATCH --output=mpi4py_test.out
#SBATCH --error=mpi4py_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load python/3.10.12-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.5-fasrc03
source activate python3_env2
srun -n 16 --mpi=pmix python mpi4py_test.py
