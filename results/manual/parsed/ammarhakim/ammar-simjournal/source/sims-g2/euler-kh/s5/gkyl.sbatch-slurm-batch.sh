#!/bin/bash
#SBATCH --job-name=gkyl
#SBATCH --account=pppl
#SBATCH --output=gkyl-%j.out
#SBATCH --error=gkyl-%j.err
#SBATCH --nodes=16
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s5-euler-kh.lua
