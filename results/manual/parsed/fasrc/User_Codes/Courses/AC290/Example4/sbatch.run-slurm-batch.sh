#!/bin/bash
#SBATCH --job-name=mmult
#SBATCH --output=mmult.out
#SBATCH --error=mmult.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:00:30

module load gcc/8.2.0-fasrc01
module load openmpi/3.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./mmult.x
