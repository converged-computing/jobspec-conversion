#!/bin/bash
#SBATCH --job-name=brt62
#SBATCH --mail-user=saraya@ucmerced.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=long.q
#SBATCH --constraint=ntasks-per-node=24

module load openmpi-2.0/intel
module load anaconda3
source activate my-R
mpirun -np 1 --bind-to none R CMD BATCH --no-save BRT62.R
