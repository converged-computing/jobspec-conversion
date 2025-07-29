#!/bin/bash
#SBATCH --job-name=ll_mpi
#SBATCH --account=PHYS030544
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=00:05:00
#SBATCH --partition=teach_cpu
#SBATCH --constraint=ntasks-per-node=4

echo 'running mpi test'
module load languages/miniconda
echo "Before activation: $(which python)"
source activate desktop_clone_env
echo "After activation: $(which python)"
srun --mpi=pmi2 python LebwohlLasher_mpi.py 50 50 0.5 0
