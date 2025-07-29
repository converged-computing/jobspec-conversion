#!/bin/bash
#SBATCH --output=slurm-8-12-1000.out
#SBATCH --mail-user=mikhaelr@chop.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=8
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=00:06:00

unset LD_PRELOAD
module load openmpi4/gcc/4.0.5
srun --mpi=pmix_v3 -n 8 ./combined 8 12 1000
