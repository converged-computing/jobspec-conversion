#!/bin/bash
#SBATCH --job-name=CADEC_train
#SBATCH --output=logslurms/cadec/slurm-%j.out
#SBATCH --error=logslurms/cadec/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=gpu_prod_long
#SBATCH --exclude=sh[00,10-16]

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate new_PGx_env
python3 -m pip install torch torch
python ./BARTNER/train.py --dataset_name CADEC
