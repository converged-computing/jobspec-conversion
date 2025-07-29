#!/bin/bash
#SBATCH --job-name=25_diiodothiophene_CASTEP_opt
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=scarf
#SBATCH: --exclusive
#SBATCH --constraint=amd
#SBATCH --array=0

module purge
module load AMDmodules
module load Python/3.10.4-GCCcore-11.3.0
module load CASTEP/21.1.1-iomkl-2021a
module list
mpirun castep.mpi CuSO4_5H2O
