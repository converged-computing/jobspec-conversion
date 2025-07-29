#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --output=mpi_test.out
#SBATCH --error=mpi_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:30:00

module load python/3.8.5-fasrc01
source activate python3_env1
srun -n 8 --mpi=pmi2 singularity exec mpich_test.simg /usr/bin/mpitest.x
