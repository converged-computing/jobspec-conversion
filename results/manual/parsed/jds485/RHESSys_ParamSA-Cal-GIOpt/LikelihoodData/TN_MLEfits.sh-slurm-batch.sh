#!/bin/bash
#SBATCH --account=quinnlab
#SBATCH --output=/scratch/js4yd/LikelihoodAnalysis/TN_MLEfits.out
#SBATCH --mail-user=js4yd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=15
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=20
#SBATCH --chdir=/scratch/js4yd/LikelihoodAnalysis/

module purge
module load gcc/7.1.0 openmpi/3.1.4 python/3.6.6 mpi4py
mpirun python TN_MLEfits.py
