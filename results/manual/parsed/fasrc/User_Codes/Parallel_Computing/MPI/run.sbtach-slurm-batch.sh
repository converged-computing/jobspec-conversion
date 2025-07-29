#!/bin/bash
#SBATCH --job-name=mpitest
#SBATCH --output=mpitest.out
#SBATCH --error=mpitest.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00
#SBATCH --partition=rc-testing

module load gcc/13/2-fasrc01 openmpi/5.0.2-fasrc01 
srun -n $SLURM_NTASKS --mpi=pmix ./mpitest.x
