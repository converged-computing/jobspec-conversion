#!/bin/bash
#SBATCH --job-name=ae_dense
#SBATCH --output=tensorflow_%j.log
#SBATCH --mail-user=nobr3541@colorado.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=300G
#SBATCH --time=1-00:00:00

module load cuda11.8/toolkit/11.8.0
srun python ae_training_dense.py
