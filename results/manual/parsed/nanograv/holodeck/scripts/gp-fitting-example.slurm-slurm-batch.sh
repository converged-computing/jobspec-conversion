#!/bin/bash
#SBATCH --job-name=gp-fitting
#SBATCH --account=<your-account>
#SBATCH --output=./outputs/gp-fitting-results-%J.out
#SBATCH --error=./errors/gp-fitting-results-%J.err
#SBATCH --mail-user=<your-mail>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=18

module purge
module load openmpi/<your-mpi-module>
module load anaconda/anaconda3
source ~/.bashrc
conda activate holodeck
CONFIG="./gp_config.ini"
mpiexec python gp_trainer.py "${CONFIG}"
