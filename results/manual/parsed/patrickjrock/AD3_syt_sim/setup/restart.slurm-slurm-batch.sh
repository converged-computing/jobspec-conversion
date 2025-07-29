#!/bin/bash
#SBATCH --job-name=namd_job
#SBATCH --account=AD3-mutations-of-Syn
#SBATCH --output=namd_job.o%j
#SBATCH --error=namd_job.o%j
#SBATCH --mail-user=patrick.rock@ttuhsc.edu
#SBATCH --mail-type=all
#SBATCH --nodes=8
#SBATCH --ntasks=196
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal

module load namd/2.10
ibrun namd2 restart.namd > restart.out
