#!/bin/bash
#SBATCH --job-name=gkyl
#SBATCH --account=pppl
#SBATCH --output=gkyl-%j.out
#SBATCH --error=gkyl-%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl c2-Lz4-lbo-collisions.lua
