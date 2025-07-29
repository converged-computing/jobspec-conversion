#!/bin/bash
#SBATCH --job-name=CS 601.471/671 final project
#SBATCH --account=danielk80_gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --qos=qos_gpu
#SBATCH --constraint=ntasks-per-node=1

export TRANSFORMERS_CACHE='/scratch4/danielk/schaud31'

module load anaconda
export TRANSFORMERS_CACHE=/scratch4/danielk/schaud31
conda activate ppi_pred # open the Python environment
srun python main.py train --batch-size 32 --epochs 10 --lr 1e-4 --small_subset False
