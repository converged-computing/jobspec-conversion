#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=bbym-hydro
#SBATCH --output=slurm_logs/train.%j.out
#SBATCH --error=slurm_logs/train.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=32g
#SBATCH --time=2-00:00:00
#SBATCH --partition=a100
#SBATCH --constraint=ntasks-per-node=1

export WANDB_API_KEY='6503c82b63d216d89775a9c56d0a24fb8fd19580'

nvidia-smi
source ~/.bashrc
export WANDB_API_KEY=6503c82b63d216d89775a9c56d0a24fb8fd19580
python train.py
