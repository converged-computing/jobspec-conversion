#!/bin/bash
#SBATCH --job-name=rjmnamd1
#SBATCH --output=slurm.log
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=00:10:00

ml purge
ml NAMD/2.12-gimkl-2017a-mpi
srun namd2 apoa1.namd
