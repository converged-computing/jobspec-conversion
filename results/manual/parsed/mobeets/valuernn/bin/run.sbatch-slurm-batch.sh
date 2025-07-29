#!/bin/bash
#SBATCH --output=logs/pytorch_%j.out
#SBATCH --error=logs/pytorch_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:08:00
#SBATCH --partition=shared

module load python/3.8.5-fasrc01
source activate pt38
srun -c 1 python quick_train.py newloss
